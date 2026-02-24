import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../../repositories/auth_repository.dart';
import '../mock/mock_data.dart'; // ✅ Import des données mockées

/// Provider d'authentification
/// Gère l'état de l'authentification et expose les méthodes au UI
class AuthProvider extends ChangeNotifier {
  final AuthRepository _authRepository;

  UserModel? _currentUser;
  bool _isAuthenticated = false;
  bool _isLoading = false;
  String? _errorMessage;

  AuthProvider({required AuthRepository authRepository})
      : _authRepository = authRepository {
    // ✅ MODE MOCK: Charger automatiquement l'utilisateur mocké
    if (MockData.USE_MOCK_DATA) {
      _loadMockUser();
    }
  }

  // ========== GETTERS ==========

  UserModel? get currentUser => _currentUser;
  bool get isAuthenticated => _isAuthenticated;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isLoggedIn => _isAuthenticated && _currentUser != null;

  // ========== MODE MOCK: Charger l'utilisateur mocké ==========

  void _loadMockUser() {
    _currentUser = MockData.getMockUserClassic();
    _isAuthenticated = true;
    debugPrint('✅ MODE MOCK: Utilisateur mocké chargé: ${_currentUser!.nom}');
  }

  // ========== AUTHENTICATION METHODS ==========

  /// Vérifie le statut d'authentification au démarrage
  Future<bool> checkAuthStatus() async {
    // ✅ MODE MOCK: Toujours authentifié
    if (MockData.USE_MOCK_DATA) {
      await MockData.simulateNetworkDelay();
      _currentUser = MockData.getMockUserClassic();
      _isAuthenticated = true;
      notifyListeners();
      return true;
    }

    // ❌ MODE API: Appel réel (commenté pour l'instant)
    /*
    try {
      final isAuth = await _authRepository.isAuthenticated();

      if (isAuth) {
        final user = await _authRepository.getCurrentUser();

        if (user != null) {
          _currentUser = user;
          _isAuthenticated = true;
          notifyListeners();
          return true;
        } else {
          _isAuthenticated = false;
          return false;
        }
      } else {
        _isAuthenticated = false;
        return false;
      }
    } catch (e) {
      _isAuthenticated = false;
      return false;
    }
    */
    return false;
  }

  /// Connexion utilisateur
  Future<bool> login({
    required String telephone,
    required String password,
  }) async {
    _setLoading(true);
    _clearError();

    // ✅ MODE MOCK: Connexion simulée
    if (MockData.USE_MOCK_DATA) {
      await MockData.simulateNetworkDelay();

      // Simuler une vérification de téléphone
      if (telephone == '0712345678' && password.length >= 6) {
        _currentUser = MockData.getMockUserClassic();
        _isAuthenticated = true;
        _setLoading(false);
        notifyListeners();
        return true;
      } else {
        _setError('Téléphone ou mot de passe incorrect');
        _setLoading(false);
        return false;
      }
    }

    // ❌ MODE API: Appel réel (commenté pour l'instant)
    /*
    try {
      _currentUser = await _authRepository.login(
        telephone: telephone,
        password: password,
      );
      
      _isAuthenticated = true;
      _setLoading(false);
      notifyListeners();
      return true;
    } catch (e) {
      _setError(_formatErrorMessage(e.toString()));
      _setLoading(false);
      return false;
    }
    */

    _setLoading(false);
    return false;
  }

  /// Inscription utilisateur
  Future<bool> register({
    required String nom,
    required String telephone,
    required String password,
    required String ville,
    required String parcours,
    String? codeParrain,
  }) async {
    _setLoading(true);
    _clearError();

    // ✅ MODE MOCK: Inscription simulée
    if (MockData.USE_MOCK_DATA) {
      await MockData.simulateNetworkDelay();

      // Créer un nouvel utilisateur mocké avec les données fournies
      _currentUser = UserModel(
        id: 'USER_NEW_${DateTime.now().millisecondsSinceEpoch}',
        nom: nom,
        telephone: telephone,
        ville: ville,
        parcours: parcours,
        licenseNumber: 'PERMIS-TEMP',
        currentScore: 0,
        targetScore: parcours == 'classic' ? 20 : 35,
        cycleCount: 0,
        bonusFidelite: false,
        referralLink:
            'https://sellovia.app/join?ref=NEW${DateTime.now().millisecondsSinceEpoch % 10000}',
        dateInscription: DateTime.now(),
      );

      _isAuthenticated = true;
      _setLoading(false);
      notifyListeners();
      return true;
    }

    // ❌ MODE API: Appel réel (commenté pour l'instant)
    /*
    try {
      final response = await _authRepository.register(
        nom: nom,
        telephone: telephone,
        password: password,
        ville: ville,
        parcours: parcours,
        codeParrain: codeParrain,
      );

      if (response) {
        _isAuthenticated = true;
        await refreshUserData();
      }

      _setLoading(false);
      notifyListeners();
      return response;
    } catch (e) {
      _setError(_formatErrorMessage(e.toString()));
      _setLoading(false);
      return false;
    }
    */

    _setLoading(false);
    return false;
  }

  /// Déconnexion utilisateur
  Future<void> logout() async {
    _setLoading(true);

    // ✅ MODE MOCK: Déconnexion simulée
    if (MockData.USE_MOCK_DATA) {
      await MockData.simulateNetworkDelay();
      _currentUser = null;
      _isAuthenticated = false;
      _errorMessage = null;
      _isLoading = false;
      notifyListeners();
      return;
    }

    // ❌ MODE API: Appel réel (commenté pour l'instant)
    /*
    try {
      await _authRepository.logout();
    } catch (e) {
      // Continuer avec la déconnexion même si l'API échoue
    } finally {
      _currentUser = null;
      _isAuthenticated = false;
      _errorMessage = null;
      _isLoading = false;
      _setLoading(false);
      notifyListeners();
      debugPrint('✅ AuthProvider nettoyé');
    }
    */
  }

  // ========== USER MANAGEMENT ==========

  /// Met à jour le profil utilisateur
  Future<bool> updateProfile(Map<String, dynamic> updateData) async {
    _setLoading(true);
    _clearError();

    // ✅ MODE MOCK: Mise à jour simulée
    if (MockData.USE_MOCK_DATA) {
      await MockData.simulateNetworkDelay();

      if (_currentUser != null) {
        // Mettre à jour les champs fournis
        _currentUser = _currentUser!.copyWith(
          nom: updateData['nom'] ?? _currentUser!.nom,
          telephone: updateData['telephone'] ?? _currentUser!.telephone,
          ville: updateData['ville'] ?? _currentUser!.ville,
        );
        _setLoading(false);
        notifyListeners();
        return true;
      }

      _setLoading(false);
      return false;
    }

    // ❌ MODE API: Appel réel (commenté pour l'instant)
    /*
    try {
      _currentUser = await _authRepository.updateProfile(updateData);
      _setLoading(false);
      notifyListeners();
      return true;
    } catch (e) {
      _setError(_formatErrorMessage(e.toString()));
      _setLoading(false);
      return false;
    }
    */

    _setLoading(false);
    return false;
  }

  /// Rafraîchit les données utilisateur
  Future<void> refreshUserData() async {
    // ✅ MODE MOCK: Pas besoin de rafraîchir
    if (MockData.USE_MOCK_DATA) {
      return;
    }

    // ❌ MODE API: Appel réel (commenté pour l'instant)
    /*
    try {
      final user = await _authRepository.getCurrentUser();
      if (user != null) {
        _currentUser = user;
        notifyListeners();
      }
    } catch (e) {
      // Échec silencieux
    }
    */
  }

  /// Met à jour le score (pour compatibilité avec l'ancien code)
  Future<void> updateScore(int newScore) async {
    if (_currentUser != null) {
      _currentUser = _currentUser!.copyWith(currentScore: newScore);
      notifyListeners();
    }
  }

  // ========== PASSWORD MANAGEMENT ==========

  /// Change le mot de passe
  Future<bool> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    _setLoading(true);
    _clearError();

    // ✅ MODE MOCK: Changement simulé
    if (MockData.USE_MOCK_DATA) {
      await MockData.simulateNetworkDelay();
      _setLoading(false);
      return true;
    }

    // ❌ MODE API: Appel réel (commenté pour l'instant)
    /*
    try {
      final response = await _authRepository.changePassword(
        currentPassword: currentPassword,
        newPassword: newPassword,
      );

      final statusCode = response.statusCode;
      
      if (statusCode == 200 || statusCode == 201) {
        _setLoading(false);
        return true;
      } else {
        final data = response.data;
        _setError(data['message'] ?? 'Erreur de changement de mot de passe');
        _setLoading(false);
        return false;
      }
    } catch (e) {
      _setError(_formatErrorMessage(e.toString()));
      _setLoading(false);
      return false;
    }
    */

    _setLoading(false);
    return false;
  }

  /// Réinitialise le mot de passe
  Future<bool> forgotPassword({required String email}) async {
    _setLoading(true);
    _clearError();

    // ✅ MODE MOCK: Réinitialisation simulée
    if (MockData.USE_MOCK_DATA) {
      await MockData.simulateNetworkDelay();
      _setLoading(false);
      return true;
    }

    // ❌ MODE API: Appel réel (commenté pour l'instant)
    /*
    try {
      await _authRepository.forgotPassword(email);
      _setLoading(false);
      return true;
    } catch (e) {
      _setError(_formatErrorMessage(e.toString()));
      _setLoading(false);
      return false;
    }
    */

    _setLoading(false);
    return false;
  }

  // ========== HELPER METHODS ==========

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setError(String message) {
    _errorMessage = message;
    notifyListeners();
  }

  void _clearError() {
    _errorMessage = null;
  }

  String _formatErrorMessage(String error) {
    if (error.startsWith('Exception: ')) {
      return error.substring(11);
    }
    return error;
  }

  void clearError() {
    _clearError();
    notifyListeners();
  }

  void clear() {
    _currentUser = null;
    _isAuthenticated = false;
    _errorMessage = null;
    _isLoading = false;
    notifyListeners();
  }
}
