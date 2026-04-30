import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:project/main.dart' show navigatorKey;
import 'package:project/data/providers/notification_provider.dart';
import 'package:project/presentation/screens/notifications_screen.dart';
import 'api_service.dart';

/// Handler global pour les messages reçus en background (obligatoirement top-level)
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint('[FCM] Background message: ${message.notification?.title}');
}

/// Canal de notification Android
const AndroidNotificationChannel androidChannel = AndroidNotificationChannel(
  'gbatcar_high_importance_channel',
  'GBATCAR Notifications',
  description: 'Rappels de paiement, alertes et informations GBATCAR',
  importance: Importance.high,
);

/// Service centralisé pour les notifications push (Android & iOS)
class NotificationService {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();
  final ApiService _apiService;
  NotificationProvider? _provider; // 🔔

  // Callback optionnel pour réagir à la navigation lors d'un tap
  Function(RemoteMessage)? onNotificationTap;

  NotificationService({required ApiService apiService})
      : _apiService = apiService;

  Future<void> init(NotificationProvider provider) async {
    _provider = provider; // 🔔

    // 1. Demander la permission (indispensable sur iOS, recommandé Android 13+)
    await _requestPermission();

    // 2. Initialiser les notifications locales (foreground)
    await _initLocalNotifications();

    // 3. Créer le canal Android (obligatoire Android 8+)
    await _createAndroidChannel();

    // 4. Récupérer et enregistrer le token FCM auprès du backend
    await _registerToken();

    // 5. Écouter les messages reçus en foreground
    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);

    // 6. Tap sur notification quand l'app est en arrière-plan
    FirebaseMessaging.onMessageOpenedApp.listen(_handleNotificationTap);

    // 7. Tap sur notification quand l'app était complètement fermée
    final RemoteMessage? initialMessage = await _fcm.getInitialMessage();
    if (initialMessage != null) {
      _handleNotificationTap(initialMessage);
    }
  }

  // ─── Permission ───────────────────────────────────────────────────────────

  Future<void> _requestPermission() async {
    final NotificationSettings settings = await _fcm.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    debugPrint('[FCM] Permission: ${settings.authorizationStatus}');
  }

  // ─── Notifications locales (foreground) ───────────────────────────────────

  Future<void> _initLocalNotifications() async {
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/launcher_icon');

    const DarwinInitializationSettings iosSettings =
        DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    await _localNotifications.initialize(
      const InitializationSettings(
        android: androidSettings,
        iOS: iosSettings,
      ),
      onDidReceiveNotificationResponse: _onLocalNotificationTap,
    );
  }

  Future<void> _createAndroidChannel() async {
    if (Platform.isAndroid) {
      await _localNotifications
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(androidChannel);
    }
  }

  // ─── Token FCM ────────────────────────────────────────────────────────────

  Future<void> _registerToken() async {
    try {
      // Sur iOS, s'assurer d'avoir l'APNS token d'abord
      if (Platform.isIOS) {
        final apnsToken = await _fcm.getAPNSToken();
        if (apnsToken == null) {
          debugPrint(
              '[FCM] APNS Token non disponible. C\'est normal sur simulateur. Pour tester les push réels, utilisez un appareil physique.');
          return;
        }
      }

      final String? token = await _fcm.getToken();
      if (token != null) {
        debugPrint('[FCM] Token: $token');
        await _sendTokenToBackend(token);
      }

      // Mettre à jour le token si FCM en génère un nouveau
      _fcm.onTokenRefresh.listen((String newToken) async {
        debugPrint('[FCM] Token renouvelé: $newToken');
        await _sendTokenToBackend(newToken);
      });
    } catch (e) {
      debugPrint('[FCM] Erreur récupération token: $e');
    }
  }

  Future<void> _sendTokenToBackend(String token) async {
    try {
      await _apiService.post('/api/auth/fcm-token', data: {'fcmToken': token});
      debugPrint('[FCM] Token envoyé au backend avec succès');
    } catch (e) {
      debugPrint('[FCM] Erreur envoi token au backend: $e');
    }
  }

  // Permet de récupérer le token depuis l'extérieur si nécessaire
  Future<String?> getToken() async {
    return await _fcm.getToken();
  }

  // ─── Gestion des messages ─────────────────────────────────────────────────

  /// Message reçu quand l'app est en foreground (ouverte)
  Future<void> _handleForegroundMessage(RemoteMessage message) async {
    debugPrint('[FCM] Foreground message: ${message.notification?.title}');
    final RemoteNotification? notification = message.notification;
    if (notification == null) return;

    // 🔔 Ajouter au provider pour affichage dans la liste
    _provider?.addNotification(
      title: notification.title ?? '',
      body: notification.body ?? '',
      type: message.data['type'],
      id: message.messageId,
    );

    await _localNotifications.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          androidChannel.id,
          androidChannel.name,
          channelDescription: androidChannel.description,
          icon: '@mipmap/launcher_icon',
          importance: Importance.high,
          priority: Priority.high,
          showWhen: true,
        ),
        iOS: const DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
      payload: message.data['type'],
    );
  }

  /// Tap sur une notification (foreground local)
  void _onLocalNotificationTap(NotificationResponse response) {
    debugPrint('[FCM] Tap local notification, payload: ${response.payload}');
    // Naviguer selon le type de notification
    _navigateByType(response.payload);
  }

  /// Tap sur une notification FCM (background ou terminé)
  void _handleNotificationTap(RemoteMessage message) {
    debugPrint('[FCM] Tap FCM notification: ${message.data}');

    // 🔔 Ajouter au provider si c'est une nouvelle notif
    final notification = message.notification;
    if (notification != null) {
      _provider?.addNotification(
        title: notification.title ?? '',
        body: notification.body ?? '',
        type: message.data['type'],
        id: message.messageId,
      );
    }

    if (onNotificationTap != null) {
      onNotificationTap!(message);
    }
    _navigateByType(message.data['type']);
  }

  void _navigateByType(String? type) {
    debugPrint('[FCM] Navigation déclenchée pour le type: $type');

    // 🔔 Navigation globale via navigatorKey
    navigatorKey.currentState?.push(
      MaterialPageRoute(
        builder: (context) => const NotificationsScreen(),
      ),
    );
  }
}
