class UserModel {
  final String id;
  final String nom;
  final String telephone;
  final String ville;
  final String? licenseNumber;
  final String? vehicleId;
  final double accountBalance;
  final double leasingTotal;
  final double leasingPaid;
  final String parcours;
  final int currentScore;
  final int targetScore;
  final int cycleCount;
  final bool bonusFidelite;
  final String referralLink;
  final DateTime dateInscription;
  final String statut;

  UserModel({
    required this.id,
    required this.nom,
    required this.telephone,
    required this.ville,
    this.licenseNumber,
    this.vehicleId,
    this.accountBalance = 0.0,
    this.leasingTotal = 30000.0,
    this.leasingPaid = 0.0,
    required this.parcours,
    required this.currentScore,
    required this.targetScore,
    this.cycleCount = 0,
    this.bonusFidelite = false,
    required this.referralLink,
    required this.dateInscription,
    this.statut = 'actif',
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      nom: json['nom'] ?? '',
      telephone: json['telephone'] ?? '',
      ville: json['ville'] ?? '',
      licenseNumber: json['license_number'],
      vehicleId: json['vehicle_id'],
      accountBalance: (json['account_balance'] ?? 0.0).toDouble(),
      leasingTotal: (json['leasing_total'] ?? 30000.0).toDouble(),
      leasingPaid: (json['leasing_paid'] ?? 0.0).toDouble(),
      parcours: json['parcours'] ?? 'classique',
      currentScore: json['current_score'] ?? 0,
      targetScore: json['target_score'] ?? 30,
      cycleCount: json['cycle_count'] ?? 0,
      bonusFidelite: json['bonus_fidelite'] ?? false,
      referralLink: json['referral_link'] ?? '',
      dateInscription: json['date_inscription'] != null
          ? DateTime.parse(json['date_inscription'])
          : DateTime.now(),
      statut: json['statut'] ?? 'actif',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nom': nom,
      'telephone': telephone,
      'ville': ville,
      'license_number': licenseNumber,
      'vehicle_id': vehicleId,
      'account_balance': accountBalance,
      'leasing_total': leasingTotal,
      'leasing_paid': leasingPaid,
      'parcours': parcours,
      'current_score': currentScore,
      'target_score': targetScore,
      'cycle_count': cycleCount,
      'bonus_fidelite': bonusFidelite,
      'referral_link': referralLink,
      'date_inscription': dateInscription.toIso8601String(),
      'statut': statut,
    };
  }

  UserModel copyWith({
    String? id,
    String? nom,
    String? telephone,
    String? ville,
    String? licenseNumber,
    String? vehicleId,
    double? accountBalance,
    double? leasingTotal,
    double? leasingPaid,
    String? parcours,
    int? currentScore,
    int? targetScore,
    int? cycleCount,
    bool? bonusFidelite,
    String? referralLink,
    DateTime? dateInscription,
    String? statut,
  }) {
    return UserModel(
      id: id ?? this.id,
      nom: nom ?? this.nom,
      telephone: telephone ?? this.telephone,
      ville: ville ?? this.ville,
      licenseNumber: licenseNumber ?? this.licenseNumber,
      vehicleId: vehicleId ?? this.vehicleId,
      accountBalance: accountBalance ?? this.accountBalance,
      leasingTotal: leasingTotal ?? this.leasingTotal,
      leasingPaid: leasingPaid ?? this.leasingPaid,
      parcours: parcours ?? this.parcours,
      currentScore: currentScore ?? this.currentScore,
      targetScore: targetScore ?? this.targetScore,
      cycleCount: cycleCount ?? this.cycleCount,
      bonusFidelite: bonusFidelite ?? this.bonusFidelite,
      referralLink: referralLink ?? this.referralLink,
      dateInscription: dateInscription ?? this.dateInscription,
      statut: statut ?? this.statut,
    );
  }

  double get leasingProgress => (leasingPaid / leasingTotal) * 100;

  double get progressPercentage => (currentScore / targetScore) * 100;

  bool get isWinner => currentScore >= targetScore;

  int get referralsRemaining => targetScore - currentScore;
}
