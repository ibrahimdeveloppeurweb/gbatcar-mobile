import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/models/user_model.dart';

/// Service centralisé pour gérer le stockage local avec SharedPreferences
class StorageService {
  SharedPreferences? _prefs;

  // ========== INITIALIZATION ==========
  
  /// Initialise le service au démarrage de l'app
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  /// Récupère l'instance de SharedPreferences
  Future<SharedPreferences> get _instance async {
    if (_prefs == null) {
      _prefs = await SharedPreferences.getInstance();
    }
    return _prefs!;
  }

  // ========== TOKEN MANAGEMENT ==========

  Future<bool> saveToken(String token) async {
    final prefs = await _instance;
    return prefs.setString('auth_token', token);
  }

  Future<String?> getToken() async {
    final prefs = await _instance;
    return prefs.getString('auth_token');
  }

  Future<bool> clearToken() async {
    final prefs = await _instance;
    return prefs.remove('auth_token');
  }

  // ========== REFRESH TOKEN ==========

  Future<bool> saveRefreshToken(String refreshToken) async {
    final prefs = await _instance;
    return prefs.setString('refresh_token', refreshToken);
  }

  Future<String?> getRefreshToken() async {
    final prefs = await _instance;
    return prefs.getString('refresh_token');
  }

  Future<bool> clearRefreshToken() async {
    final prefs = await _instance;
    return prefs.remove('refresh_token');
  }

  // ========== USER MANAGEMENT ==========

  Future<bool> saveUser(UserModel user) async {
    final prefs = await _instance;
    return prefs.setString('user_data', jsonEncode(user.toJson()));
  }

  Future<UserModel?> getUser() async {
    final prefs = await _instance;
    final data = prefs.getString('user_data');
    if (data != null) {
      try {
        return UserModel.fromJson(jsonDecode(data));
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  Future<bool> clearUser() async {
    final prefs = await _instance;
    return prefs.remove('user_data');
  }

  Future<bool> saveUserId(String userId) async {
    final prefs = await _instance;
    return prefs.setString('user_id', userId);
  }

  Future<String?> getUserId() async {
    final prefs = await _instance;
    return prefs.getString('user_id');
  }

  Future<bool> saveUserData(Map<String, dynamic> userData) async {
    final prefs = await _instance;
    return prefs.setString('user_data_json', jsonEncode(userData));
  }

  Future<Map<String, dynamic>?> getUserData() async {
    final prefs = await _instance;
    final data = prefs.getString('user_data_json');
    if (data != null) {
      try {
        return jsonDecode(data) as Map<String, dynamic>;
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  // ========== SESSION MANAGEMENT ==========

  Future<bool> isLoggedIn() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }

  Future<bool> saveAuthData({
    required String token,
    String? refreshToken,
    required UserModel user,
  }) async {
    try {
      await saveToken(token);
      if (refreshToken != null) {
        await saveRefreshToken(refreshToken);
      }
      await saveUser(user);
      await saveUserId(user.id);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> clearAuthData() async {
    try {
      await clearToken();
      await clearRefreshToken();
      await clearUser();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> clearAll() async {
    final prefs = await _instance;
    return prefs.clear();
  }

  // ========== APP SETTINGS ==========

  Future<bool> saveThemeMode(String theme) async {
    final prefs = await _instance;
    return prefs.setString('theme_mode', theme);
  }

  Future<String?> getThemeMode() async {
    final prefs = await _instance;
    return prefs.getString('theme_mode');
  }

  Future<bool> saveLanguage(String language) async {
    final prefs = await _instance;
    return prefs.setString('language', language);
  }

  Future<String?> getLanguage() async {
    final prefs = await _instance;
    return prefs.getString('language');
  }

  Future<bool> setFirstTime(bool isFirstTime) async {
    final prefs = await _instance;
    return prefs.setBool('is_first_time', isFirstTime);
  }

  Future<bool> isFirstTime() async {
    final prefs = await _instance;
    return prefs.getBool('is_first_time') ?? true;
  }
}