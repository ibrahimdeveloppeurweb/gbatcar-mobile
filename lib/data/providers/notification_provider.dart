import 'package:flutter/foundation.dart';

/// Modèle d'une notification
class AppNotification {
  final String id;
  final String title;
  final String body;
  final String? type; // 'payment', 'deposit', 'alert', etc.
  final DateTime receivedAt;
  bool isRead;

  AppNotification({
    required this.id,
    required this.title,
    required this.body,
    this.type,
    required this.receivedAt,
    this.isRead = false,
  });

  factory AppNotification.fromMap(Map<String, dynamic> data) {
    return AppNotification(
      id: data['id']?.toString() ??
          DateTime.now().millisecondsSinceEpoch.toString(),
      title: data['title'] ?? '',
      body: data['body'] ?? '',
      type: data['type'],
      receivedAt:
          data['receivedAt'] is DateTime ? data['receivedAt'] : DateTime.now(),
      isRead: data['isRead'] ?? false,
    );
  }
}

/// Provider pour gérer l'état des notifications dans l'UI
class NotificationProvider extends ChangeNotifier {
  final List<AppNotification> _notifications = [];

  List<AppNotification> get notifications => List.unmodifiable(_notifications);

  int get unreadCount => _notifications.where((n) => !n.isRead).length;

  bool get hasUnread => unreadCount > 0;

  // ─── Ajouter une notification ─────────────────────────────────────────────

  void addNotification({
    required String title,
    required String body,
    String? type,
    String? id,
  }) {
    final notif = AppNotification(
      id: id ?? DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      body: body,
      type: type,
      receivedAt: DateTime.now(),
      isRead: false,
    );
    _notifications.insert(0, notif);
    notifyListeners();
  }

  // ─── Marquer comme lu ─────────────────────────────────────────────────────

  void markAsRead(String id) {
    final index = _notifications.indexWhere((n) => n.id == id);
    if (index != -1) {
      _notifications[index].isRead = true;
      notifyListeners();
    }
  }

  void markAllAsRead() {
    for (final notif in _notifications) {
      notif.isRead = true;
    }
    notifyListeners();
  }

  // ─── Supprimer ────────────────────────────────────────────────────────────

  void remove(String id) {
    _notifications.removeWhere((n) => n.id == id);
    notifyListeners();
  }

  void clearAll() {
    _notifications.clear();
    notifyListeners();
  }

  // ─── Initialiser depuis l'API ─────────────────────────────────────────────

  void setNotifications(List<Map<String, dynamic>> data) {
    _notifications.clear();
    _notifications.addAll(data.map(AppNotification.fromMap));
    notifyListeners();
  }
}
