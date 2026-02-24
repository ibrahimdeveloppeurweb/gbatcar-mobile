import 'package:dio/dio.dart';
import '../../data/models/user_model.dart';
import '../services/api_service.dart';
import '../services/storage_service.dart';

/// Service gérant toutes les opérations d'authentification
class AuthService {
  final ApiService _apiService;
  final StorageService _storageService;

  AuthService({
    required ApiService apiService,
    required StorageService storageService,
  })  : _apiService = apiService,
        _storageService = storageService;

  // ========== AUTHENTICATION ==========

  /// Connexion utilisateur
  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _apiService.post(
        '/auth/login',
        data: {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        final data = response.data;

        // Sauvegarder le token si disponible
        if (data['token'] != null) {
          await _storageService.saveToken(data['token']);
        }

        // Sauvegarder le refresh token si disponible
        if (data['refreshToken'] != null) {
          await _storageService.saveRefreshToken(data['refreshToken']);
        }

        // Sauvegarder les données utilisateur
        final user = UserModel.fromJson(data['user'] ?? data);
        await _storageService.saveUserData(user.toJson());
        await _storageService.saveUserId(user.id);

        return {
          'user': user,
          'token': data['token'],
        };
      } else {
        throw Exception('Erreur de connexion');
      }
    } catch (e) {
      throw Exception('Échec de la connexion: ${e.toString()}');
    }
  }

  /// Inscription utilisateur
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
      final response = await _apiService.post(
        '/auth/register',
        data: {
          'nom': nom,
          'telephone': telephone,
          'ville': ville,
          'parcours': parcours,
          if (codeParrain != null) 'code_parrain': codeParrain,
          if (email != null) 'email': email,
          if (password != null) 'password': password,
        },
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        // Si l'API retourne un token et user après inscription
        if (response.data['token'] != null) {
          await _storageService.saveToken(response.data['token']);
        }
        
        if (response.data['user'] != null) {
          final user = UserModel.fromJson(response.data['user']);
          await _storageService.saveUserData(user.toJson());
          await _storageService.saveUserId(user.id);
        }

        return true;
      } else {
        throw Exception('Erreur d\'inscription');
      }
    } catch (e) {
      throw Exception('Échec de l\'inscription: ${e.toString()}');
    }
  }

  /// Déconnexion utilisateur
  Future<void> logout() async {
    try {
      // Appeler l'API de déconnexion si nécessaire
      try {
        await _apiService.post('/auth/logout');
      } catch (_) {
        // Continuer même si l'appel API échoue
      }

      // Nettoyer le stockage local
      await clearToken();
      await _storageService.clearAll();
    } catch (e) {
      // S'assurer que le nettoyage local se fait même en cas d'erreur
      await clearToken();
      await _storageService.clearAll();
      throw Exception('Erreur lors de la déconnexion: ${e.toString()}');
    }
  }

  // ========== USER MANAGEMENT ==========

  /// Récupère l'utilisateur actuel depuis le stockage local
  Future<UserModel?> getCurrentUser() async {
    try {
      final userData = await _storageService.getUserData();
      if (userData != null) {
        return UserModel.fromJson(userData);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  /// Met à jour le profil utilisateur
  Future<UserModel> updateProfile(Map<String, dynamic> updateData) async {
    try {
      final userId = await _storageService.getUserId();
      
      final response = await _apiService.put(
        '/user/$userId',
        data: updateData,
      );

      if (response.statusCode == 200) {
        final user = UserModel.fromJson(response.data['user'] ?? response.data);
        await _storageService.saveUserData(user.toJson());
        return user;
      } else {
        throw Exception('Erreur de mise à jour');
      }
    } catch (e) {
      throw Exception('Échec de la mise à jour: ${e.toString()}');
    }
  }

  // ========== PASSWORD MANAGEMENT ==========

  /// Change le mot de passe
  Future<Response> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      final response = await _apiService.post(
        '/auth/change-password',
        data: {
          'current_password': currentPassword,
          'new_password': newPassword,
        },
      );
      return response;
    } catch (e) {
      throw Exception('Erreur lors du changement de mot de passe: ${e.toString()}');
    }
  }

  /// Réinitialise le mot de passe
  Future<void> resetPassword(String email) async {
    try {
      await _apiService.post(
        '/auth/forgot-password',
        data: {'email': email},
      );
    } catch (e) {
      throw Exception('Erreur lors de la réinitialisation: ${e.toString()}');
    }
  }

  // ========== TOKEN MANAGEMENT ==========

  /// Sauvegarde le token
  Future<void> saveToken(String token) async {
    try {
      await _storageService.saveToken(token);
    } catch (e) {
      throw Exception('Erreur lors de la sauvegarde du token: ${e.toString()}');
    }
  }

  /// Récupère le token
  Future<String?> getToken() async {
    try {
      return await _storageService.getToken();
    } catch (e) {
      return null;
    }
  }

  /// Supprime le token
  Future<void> clearToken() async {
    try {
      await _storageService.clearToken();
    } catch (e) {
      throw Exception('Erreur lors de la suppression du token: ${e.toString()}');
    }
  }

  /// Vérifie si le token est valide
  Future<bool> verifyToken(String token) async {
    try {
      final response = await _apiService.post(
        '/auth/verify-token',
        data: {'token': token},
      );
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  /// Rafraîchit le token
  Future<Map<String, dynamic>> refreshToken() async {
    try {
      final refreshToken = await _storageService.getRefreshToken();

      if (refreshToken == null) {
        throw Exception('Aucun refresh token disponible');
      }

      final response = await _apiService.post(
        '/auth/refresh-token',
        data: {'refresh_token': refreshToken},
      );

      if (response.statusCode == 200) {
        final data = response.data;

        // Sauvegarder le nouveau token
        await saveToken(data['token']);

        if (data['refresh_token'] != null) {
          await _storageService.saveRefreshToken(data['refresh_token']);
        }

        return data;
      } else {
        throw Exception('Erreur de rafraîchissement du token');
      }
    } catch (e) {
      throw Exception('Échec du rafraîchissement du token: ${e.toString()}');
    }
  }

  // ========== STATUS CHECKS ==========

  /// Vérifie si l'utilisateur est authentifié
  Future<bool> isAuthenticated() async {
    try {
      final token = await getToken();
      if (token == null || token.isEmpty) {
        return false;
      }
      
      // Pour l'instant, on vérifie juste que le token existe
      return true;
    } catch (e) {
      return false;
    }
  }
}