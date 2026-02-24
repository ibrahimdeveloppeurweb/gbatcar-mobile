import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/user_model.dart';

class UserProvider with ChangeNotifier {
  final SharedPreferences prefs;
  UserModel? _currentUser;
  bool _isLoading = false;
  String? _error;

  UserProvider(this.prefs) {
    _loadUser();
  }

  UserModel? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isLoggedIn => _currentUser != null;

  Future<void> _loadUser() async {
    try {
      final userData = prefs.getString('user_data');
      if (userData != null) {
        final json = jsonDecode(userData);
        _currentUser = UserModel.fromJson(json);
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error loading user: $e');
    }
  }

  Future<void> _saveUser(UserModel user) async {
    try {
      final json = jsonEncode(user.toJson());
      await prefs.setString('user_data', json);
      _currentUser = user;
      notifyListeners();
    } catch (e) {
      debugPrint('Error saving user: $e');
    }
  }

  Future<bool> register({
    required String nom,
    required String telephone,
    required String ville,
    required String parcours,
    String? codeParrain,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final user = UserModel(
        id: 'USER_${DateTime.now().millisecondsSinceEpoch}',
        nom: nom,
        telephone: telephone,
        ville: ville,
        licenseNumber: codeParrain, // Utilise l'argument passé pour le permis
        parcours: parcours,
        currentScore: 1,
        targetScore: parcours == 'classique' ? 20 : 35,
        referralLink:
            'sellovia.app/join?ref=${nom.substring(0, 3).toUpperCase()}${DateTime.now().millisecondsSinceEpoch % 1000}',
        dateInscription: DateTime.now(),
      );

      await _saveUser(user);

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = 'Erreur lors de l\'inscription: $e';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> updateScore(int newScore) async {
    if (_currentUser != null) {
      final updatedUser = _currentUser!.copyWith(currentScore: newScore);
      await _saveUser(updatedUser);
    }
  }

  Future<void> logout() async {
    await prefs.remove('user_data');
    _currentUser = null;
    notifyListeners();
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}
