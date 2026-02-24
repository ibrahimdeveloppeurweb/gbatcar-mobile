import 'package:dio/dio.dart';
import '../data/models/user_model.dart';
import '../core/services/auth_service.dart';

/// Repository d'authentification
/// Couche intermédiaire entre le Provider et le Service
class AuthRepository {
  final AuthService _authService;

  AuthRepository({required AuthService authService})
      : _authService = authService;

  // ========== AUTHENTICATION ==========

  /// Login - Connexion utilisateur
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _authService.login(
        email: email,
        password: password,
      );
      return response['user'];
    } catch (e) {
      throw Exception('Erreur de connexion: ${e.toString()}');
    }
  }

  /// Register - Inscription utilisateur
  Future<bool> register({
    required String nom,
    required String telephone,
    required String ville,
    required String parcours,
    String? codeParrain,
    String? email,
    String? password,
  }) async {
    try {
      final response = await _authService.register(
        nom: nom,
        telephone: telephone,
        ville: ville,
        parcours: parcours,
        codeParrain: codeParrain,
        email: email,
        password: password,
      );
      return response;
    } catch (e) {
      throw Exception('Erreur d\'inscription: ${e.toString()}');
    }
  }

  /// Logout - Déconnexion utilisateur
  Future<void> logout() async {
    try {
      await _authService.logout();
    } catch (e) {
      throw Exception('Erreur de déconnexion: ${e.toString()}');
    }
  }

  // ========== USER MANAGEMENT ==========

  /// Get current user - Récupère l'utilisateur actuel
  Future<UserModel?> getCurrentUser() async {
    try {
      return await _authService.getCurrentUser();
    } catch (e) {
      return null;
    }
  }

  /// Check authentication - Vérifie si l'utilisateur est authentifié
  Future<bool> isAuthenticated() async {
    try {
      final user = await _authService.getCurrentUser();
      return user != null;
    } catch (e) {
      return false;
    }
  }

  /// Update profile - Met à jour le profil
  Future<UserModel> updateProfile(Map<String, dynamic> updateData) async {
    try {
      return await _authService.updateProfile(updateData);
    } catch (e) {
      throw Exception('Erreur de mise à jour: ${e.toString()}');
    }
  }

  // ========== PASSWORD MANAGEMENT ==========

  /// Change password - Change le mot de passe
  Future<Response> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      final response = await _authService.changePassword(
        currentPassword: currentPassword,
        newPassword: newPassword,
      );
      return response;
    } catch (e) {
      throw Exception('Erreur de changement de mot de passe: ${e.toString()}');
    }
  }

  /// Forgot password - Réinitialisation mot de passe
  Future<void> forgotPassword(String email) async {
    try {
      await _authService.resetPassword(email);
    } catch (e) {
      throw Exception('Erreur de réinitialisation: ${e.toString()}');
    }
  }

  // ========== TOKEN MANAGEMENT ==========

  /// Refresh token - Rafraîchit le token
  Future<Map<String, dynamic>> refreshToken() async {
    try {
      return await _authService.refreshToken();
    } catch (e) {
      throw Exception('Erreur de rafraîchissement: ${e.toString()}');
    }
  }
}