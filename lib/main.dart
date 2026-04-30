import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

// Services
import 'package:project/core/services/storage_service.dart';
import 'package:project/core/services/api_service.dart';
import 'package:project/core/services/auth_service.dart';
import 'package:project/core/services/notification_service.dart';

// Repositories
import 'package:project/repositories/auth_repository.dart';

// Providers
import 'package:project/data/providers/auth_provider.dart';
import 'package:project/data/providers/user_provider.dart';
import 'package:project/data/providers/notification_provider.dart';

// Firebase options (reconstruit manuellement)
import 'firebase_options.dart';

// Screens
import 'package:project/presentation/screens/splash_screen.dart';

// Global Variables
late StorageService storageService;
late ApiService apiService;
late AuthService authService;
late NotificationService notificationService; // 🔔

late AuthRepository authRepository;

late AuthProvider authProvider;
late UserProvider userProvider;
late NotificationProvider notificationProvider; // 🔔

// Global Navigation Key pour les redirections depuis les services
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Configure device orientation
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // System UI overlay
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ),
  );

  // 🔔 Initialiser Firebase + handler background
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  // ============ INITIALIZE SERVICES ============
  storageService = StorageService();
  await storageService.init();

  apiService = ApiService(storageService: storageService);
  authService =
      AuthService(apiService: apiService, storageService: storageService);

  // 🔔 Initialiser le service de notifications
  notificationService = NotificationService(apiService: apiService);

  // ============ INITIALIZE REPOSITORIES ============
  authRepository = AuthRepository(authService: authService);

  // ============ INITIALIZE PROVIDERS ============
  authProvider = AuthProvider(authRepository: authRepository);

  final prefs = await SharedPreferences.getInstance();
  userProvider = UserProvider(prefs);

  notificationProvider = NotificationProvider(); // 🔔

  // 🔔 Initialisation finale du service avec le provider
  await notificationService.init(notificationProvider);

  runApp(const GoCabApp());
}

class GoCabApp extends StatelessWidget {
  const GoCabApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<StorageService>.value(value: storageService),
        Provider<ApiService>.value(value: apiService),
        Provider<AuthService>.value(value: authService),
        Provider<NotificationService>.value(value: notificationService), // 🔔

        Provider<AuthRepository>.value(value: authRepository),

        ChangeNotifierProvider<AuthProvider>.value(value: authProvider),
        ChangeNotifierProvider<UserProvider>.value(value: userProvider),
        ChangeNotifierProvider<NotificationProvider>.value(
            value: notificationProvider), // 🔔
      ],
      child: MaterialApp(
        title: 'GbatCar',
        navigatorKey:
            navigatorKey, // 🔔 Indispensable pour la navigation globale
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'Outfit',
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
