class AppConstants {
  // API Configuration
  static const String baseUrl = 'https://api.sellovia.app';
  static const String apiVersion = '/v1';

  // Endpoints
  static const String loginEndpoint = '/auth/login';
  static const String registerEndpoint = '/auth/register';
  static const String userEndpoint = '/users';
  static const String referralEndpoint = '/referrals';
  static const String paymentEndpoint = '/payments';
  static const String leaderboardEndpoint = '/leaderboard';

  // Storage Keys
  static const String tokenKey = 'auth_token';
  static const String userKey = 'user_data';
  static const String onboardingKey = 'onboarding_completed';

  // Parcours
  static const String parcoursClassique = 'classique';
  static const String parcoursElite = 'elite';

  // Pricing
  static const int prixClassique = 500;
  static const int prixElite = 1000;
  static const int targetClassique = 20;
  static const int targetElite = 35;
  static const int rewardClassique = 25000;

  // Commission
  static const int commissionAmbassadeur = 100;
  static const int minimumRetrait = 5000;

  // Wheel
  static const int wheelMinReferrals = 2;

  // Payment methods
  static const String orangeMoney = 'orange_money';
  static const String wave = 'wave';
  static const String mtnMoney = 'mtn_money';

  // App Info
  static const String appName = 'Sellovia';
  static const String appVersion = '1.0.0';
  static const String supportEmail = 'support@sellovia.app';
  static const String supportPhone = '+225 07 XX XX XX XX';
}