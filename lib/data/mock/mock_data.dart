import '../models/user_model.dart';

/// ========================================
/// DONNÉES MOCKÉES POUR DÉVELOPPEMENT
/// À utiliser quand le backend n'est pas prêt
/// ========================================

class MockData {
  // ========== FLAG POUR ACTIVER/DÉSACTIVER LES MOCKS ==========
  static const bool USE_MOCK_DATA =
      true; // ✅ Mettre à false quand l'API est prête

  // ========== UTILISATEUR MOCKÉ ==========

  /// Utilisateur connecté (Parcours Classic)
  static UserModel getMockUserClassic() {
    return UserModel(
      id: 'USER_001',
      nom: 'Ibrahim Traoré',
      telephone: '0712345678',
      ville: 'Abidjan',
      parcours: 'classic',
      licenseNumber: 'PERMIS-123',
      currentScore: 12,
      targetScore: 20,
      cycleCount: 0,
      bonusFidelite: true,
      referralLink: 'https://sellovia.app/join?ref=IBRA123',
      dateInscription: DateTime.now().subtract(const Duration(days: 15)),
    );
  }

  /// Utilisateur Elite
  static UserModel getMockUserElite() {
    return UserModel(
      id: 'USER_002',
      nom: 'Aminata Koné',
      telephone: '0723456789',
      ville: 'Yamoussoukro',
      parcours: 'elite',
      licenseNumber: 'PERMIS-456',
      currentScore: 28,
      targetScore: 35,
      cycleCount: 1,
      bonusFidelite: false,
      referralLink: 'https://sellovia.app/join?ref=AMIN456',
      dateInscription: DateTime.now().subtract(const Duration(days: 30)),
    );
  }

  // ========== LISTE DE PARRAINAGES MOCKÉS ==========

  static List<Map<String, dynamic>> getMockReferrals() {
    return [
      {
        'id': 'REF_001',
        'nom': 'Kouassi Jean',
        'telephone': '0701234567',
        'statut': 'validé',
        'montant': 500,
        'date':
            DateTime.now().subtract(const Duration(days: 1)).toIso8601String(),
      },
      {
        'id': 'REF_002',
        'nom': 'Aya Diallo',
        'telephone': '0712345678',
        'statut': 'validé',
        'montant': 500,
        'date':
            DateTime.now().subtract(const Duration(days: 2)).toIso8601String(),
      },
      {
        'id': 'REF_003',
        'nom': 'Yao Serge',
        'telephone': '0723456789',
        'statut': 'validé',
        'montant': 500,
        'date':
            DateTime.now().subtract(const Duration(days: 3)).toIso8601String(),
      },
      {
        'id': 'REF_004',
        'nom': 'Fatou Bamba',
        'telephone': '0734567890',
        'statut': 'en_attente',
        'montant': 500,
        'date':
            DateTime.now().subtract(const Duration(hours: 5)).toIso8601String(),
      },
      {
        'id': 'REF_005',
        'nom': 'Koné Moussa',
        'telephone': '0745678901',
        'statut': 'validé',
        'montant': 500,
        'date':
            DateTime.now().subtract(const Duration(days: 5)).toIso8601String(),
      },
      {
        'id': 'REF_006',
        'nom': 'Marie-Claire',
        'telephone': '0756789012',
        'statut': 'validé',
        'montant': 500,
        'date':
            DateTime.now().subtract(const Duration(days: 6)).toIso8601String(),
      },
      {
        'id': 'REF_007',
        'nom': 'Bakayoko Ali',
        'telephone': '0767890123',
        'statut': 'validé',
        'montant': 500,
        'date':
            DateTime.now().subtract(const Duration(days: 7)).toIso8601String(),
      },
      {
        'id': 'REF_008',
        'nom': 'Adjoua Nathalie',
        'telephone': '0778901234',
        'statut': 'rejeté',
        'montant': 0,
        'date':
            DateTime.now().subtract(const Duration(days: 8)).toIso8601String(),
      },
      {
        'id': 'REF_009',
        'nom': 'Soro Ibrahim',
        'telephone': '0789012345',
        'statut': 'validé',
        'montant': 500,
        'date':
            DateTime.now().subtract(const Duration(days: 9)).toIso8601String(),
      },
      {
        'id': 'REF_010',
        'nom': 'Fofana Mariam',
        'telephone': '0790123456',
        'statut': 'validé',
        'montant': 500,
        'date':
            DateTime.now().subtract(const Duration(days: 10)).toIso8601String(),
      },
      {
        'id': 'REF_011',
        'nom': 'Touré Abdoul',
        'telephone': '0701234568',
        'statut': 'validé',
        'montant': 500,
        'date':
            DateTime.now().subtract(const Duration(days: 11)).toIso8601String(),
      },
      {
        'id': 'REF_012',
        'nom': 'Gnon Patricia',
        'telephone': '0712345679',
        'statut': 'validé',
        'montant': 500,
        'date':
            DateTime.now().subtract(const Duration(days: 12)).toIso8601String(),
      },
    ];
  }

  // ========== STATISTIQUES DE PARRAINAGE ==========

  static Map<String, dynamic> getMockReferralStats() {
    return {
      'total_parrainages': 12,
      'parrainages_valides': 10,
      'parrainages_en_attente': 1,
      'parrainages_rejetes': 1,
      'gains_totaux': 5000,
    };
  }

  // ========== CLASSEMENT MOCKÉ ==========

  static List<Map<String, dynamic>> getMockLeaderboard() {
    return [
      {
        'rang': 1,
        'nom': 'Aminata Koné',
        'score': 35,
        'ville': 'Yamoussoukro',
        'parcours': 'elite',
        'badges': ['🏆', '⭐'],
      },
      {
        'rang': 2,
        'nom': 'Kouadio Marc',
        'score': 28,
        'ville': 'Abidjan',
        'parcours': 'elite',
        'badges': ['⭐'],
      },
      {
        'rang': 3,
        'nom': 'Bamba Issouf',
        'score': 22,
        'ville': 'Bouaké',
        'parcours': 'classic',
        'badges': ['🔥'],
      },
      {
        'rang': 4,
        'nom': 'Aya Diallo',
        'score': 20,
        'ville': 'Abidjan',
        'parcours': 'classic',
        'badges': ['✅'],
      },
      {
        'rang': 5,
        'nom': 'Traoré Seydou',
        'score': 18,
        'ville': 'San Pedro',
        'parcours': 'classic',
        'badges': [],
      },
      {
        'rang': 6,
        'nom': 'Koné Fatoumata',
        'score': 16,
        'ville': 'Korhogo',
        'parcours': 'classic',
        'badges': [],
      },
      {
        'rang': 7,
        'nom': 'Yao Brigitte',
        'score': 15,
        'ville': 'Abidjan',
        'parcours': 'classic',
        'badges': [],
      },
      {
        'rang': 8,
        'nom': 'N\'Guessan Paul',
        'score': 14,
        'ville': 'Daloa',
        'parcours': 'classic',
        'badges': [],
      },
      {
        'rang': 9,
        'nom': 'Ouattara Ali',
        'score': 13,
        'ville': 'Man',
        'parcours': 'classic',
        'badges': [],
      },
      {
        'rang': 10,
        'nom': 'Ibrahim Traoré',
        'score': 12,
        'ville': 'Abidjan',
        'parcours': 'classic',
        'badges': [],
      },
    ];
  }

  // ========== DONNÉES AMBASSADEUR MOCKÉES ==========

  static Map<String, dynamic> getMockAmbassadorData() {
    return {
      'id': 'AMB_001',
      'user_id': 'USER_001',
      'code_promo': 'IBRA100',
      'solde_disponible': 8500.0,
      'gains_cumules': 12000.0,
      'nb_filleuls': 85,
      'taux_commission': 100.0,
      'date_creation':
          DateTime.now().subtract(const Duration(days: 45)).toIso8601String(),
      'charte_acceptee': true,
      'numero_retrait': '0712345678',
      'operateur': 'orange',
    };
  }

  static List<Map<String, dynamic>> getMockAmbassadorReferrals() {
    return List.generate(15, (index) {
      return {
        'id': 'AMB_REF_${index + 1}',
        'filleul_nom': 'Filleul ${index + 1}',
        'date_parrainage':
            DateTime.now().subtract(Duration(days: index)).toIso8601String(),
        'statut': index % 4 == 0 ? 'en_attente' : 'valide',
        'montant_gain': index % 4 == 0 ? 0.0 : 100.0,
      };
    });
  }

  static List<Map<String, dynamic>> getMockAmbassadorWithdrawals() {
    return [
      {
        'id': 'WITHD_001',
        'montant': 5000.0,
        'date_demande':
            DateTime.now().subtract(const Duration(days: 10)).toIso8601String(),
        'statut': 'complété',
        'numero_destination': '0712345678',
        'operateur': 'orange',
      },
      {
        'id': 'WITHD_002',
        'montant': 3500.0,
        'date_demande':
            DateTime.now().subtract(const Duration(days: 5)).toIso8601String(),
        'statut': 'en_cours',
        'numero_destination': '0712345678',
        'operateur': 'orange',
      },
    ];
  }

  // ========== HISTORIQUE DES GAINS DE LA ROUE ==========

  static List<Map<String, dynamic>> getMockWheelHistory() {
    return [
      {
        'id': 'WHEEL_001',
        'prize': '+1 BOOST',
        'date':
            DateTime.now().subtract(const Duration(days: 2)).toIso8601String(),
      },
      {
        'id': 'WHEEL_002',
        'prize': 'REBOND',
        'date':
            DateTime.now().subtract(const Duration(days: 5)).toIso8601String(),
      },
      {
        'id': 'WHEEL_003',
        'prize': '3 TICKETS',
        'date':
            DateTime.now().subtract(const Duration(days: 8)).toIso8601String(),
      },
    ];
  }

  // ========== GAGNANTS RÉCENTS ==========

  static List<Map<String, dynamic>> getMockWinners() {
    return [
      {
        'id': 'WIN_001',
        'nom': 'Aminata K.',
        'ville': 'Yamoussoukro',
        'prix': 'Montre Luxury + Tecno Camon 20',
        'date':
            DateTime.now().subtract(const Duration(days: 5)).toIso8601String(),
        'parcours': 'elite',
        'image': 'https://via.placeholder.com/150',
      },
      {
        'id': 'WIN_002',
        'nom': 'Kouadio M.',
        'ville': 'Abidjan',
        'prix': 'Montre Luxury',
        'date':
            DateTime.now().subtract(const Duration(days: 12)).toIso8601String(),
        'parcours': 'classic',
        'image': 'https://via.placeholder.com/150',
      },
      {
        'id': 'WIN_003',
        'nom': 'Bamba I.',
        'ville': 'Bouaké',
        'prix': 'Montre Luxury',
        'date':
            DateTime.now().subtract(const Duration(days: 20)).toIso8601String(),
        'parcours': 'classic',
        'image': 'https://via.placeholder.com/150',
      },
    ];
  }

  // ========== HISTORIQUE DE PAIEMENT ==========

  static List<Map<String, dynamic>> getMockPaymentHistory() {
    return [
      {
        'id': 'PAY_001',
        'montant': 500,
        'methode': 'Orange Money',
        'statut': 'complété',
        'date':
            DateTime.now().subtract(const Duration(days: 15)).toIso8601String(),
      },
    ];
  }

  // ========== MÉTHODES UTILITAIRES ==========

  /// Simuler un délai réseau (comme un vrai appel API)
  static Future<void> simulateNetworkDelay() async {
    await Future.delayed(const Duration(milliseconds: 500));
  }

  /// Simuler une réponse API réussie
  static Map<String, dynamic> successResponse({
    required dynamic data,
    String message = 'Succès',
  }) {
    return {
      'success': true,
      'message': message,
      'data': data,
    };
  }

  /// Simuler une réponse API d'erreur
  static Map<String, dynamic> errorResponse({
    required String message,
  }) {
    return {
      'success': false,
      'message': message,
      'data': null,
    };
  }
}
