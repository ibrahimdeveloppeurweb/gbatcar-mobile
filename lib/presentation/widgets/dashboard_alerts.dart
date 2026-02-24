import 'package:flutter/material.dart';
import '../../shared/constants/app_colors.dart';

/// Widget d'alerte quand quelqu'un est proche de l'objectif
class ProximityAlert extends StatelessWidget {
  final String leaderName;
  final int currentScore;
  final int targetScore;

  const ProximityAlert({
    Key? key,
    required this.leaderName,
    required this.currentScore,
    required this.targetScore,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final remaining = targetScore - currentScore;

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.error.withOpacity(0.3),
            Colors.orange.withOpacity(0.3),
          ],
        ),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: AppColors.error, width: 2),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: AppColors.error,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Center(
              child: Icon(Icons.warning, color: Colors.white, size: 28),
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '⚠️ ALERTE CYCLE',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  '$leaderName est à $currentScore/$targetScore !',
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: AppColors.error,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  remaining <= 2
                      ? 'Le cycle va se terminer dans quelques heures !'
                      : 'Le cycle va bientôt se terminer.',
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'Dépêchez-vous ! 🔥',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Widget de compte à rebours avant le reset
class ResetCountdown extends StatelessWidget {
  final String leaderName;
  final int leaderScore;
  final int targetScore;

  const ResetCountdown({
    Key? key,
    required this.leaderName,
    required this.leaderScore,
    required this.targetScore,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final remaining = targetScore - leaderScore;

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.error,
            Colors.orange,
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.error.withOpacity(0.4),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Center(
                  child: Icon(Icons.timer, color: Colors.white, size: 32),
                ),
              ),
              const SizedBox(width: 15),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '⏰ FIN DU CYCLE IMMINENTE',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      'Dernière chance !',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Text(
                  'Le leader $leaderName est à $leaderScore/$targetScore !',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        '🚨',
                        style: TextStyle(fontSize: 24),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        children: [
                          const Text(
                            'Plus que',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.error,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '$remaining',
                            style: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.w900,
                              color: AppColors.error,
                              height: 1,
                            ),
                          ),
                          Text(
                            remaining == 1 ? 'parrainage' : 'parrainages',
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColors.error,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'avant le RESET GLOBAL',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'Terminez MAINTENANT ou votre progression sera perdue ! 🔥',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Widget pour la card info paiement lundi
class PaymentScheduleCard extends StatelessWidget {
  final DateTime nextPaymentDate;
  final int pendingRequests;
  final int pendingAmount;

  const PaymentScheduleCard({
    Key? key,
    required this.nextPaymentDate,
    this.pendingRequests = 0,
    this.pendingAmount = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final daysUntilPayment = nextPaymentDate.difference(now).inDays;
    final formattedDate =
        '${nextPaymentDate.day}/${nextPaymentDate.month}/${nextPaymentDate.year}';

    // Trouver le prochain lundi
    final nextMonday = _getNextMonday();
    final daysUntilMonday = nextMonday.difference(now).inDays;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primaryBlue.withOpacity(0.3),
            AppColors.primaryGreen.withOpacity(0.3),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.primaryGreen, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  gradient: AppColors.greenGradient,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(
                  child:
                      Icon(Icons.calendar_today, color: Colors.white, size: 24),
                ),
              ),
              const SizedBox(width: 15),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '📅 CALENDRIER DES RETRAITS',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      'Paiements groupés',
                      style: TextStyle(fontSize: 11, color: Colors.white70),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.info_outline,
                        color: AppColors.primaryGreen, size: 16),
                    SizedBox(width: 8),
                    Text(
                      'Les paiements sont effectués',
                      style: TextStyle(fontSize: 12, color: Colors.white70),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                const Text(
                  'CHAQUE LUNDI',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryGreen,
                  ),
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    const Icon(Icons.event, color: Colors.white54, size: 16),
                    const SizedBox(width: 8),
                    Text(
                      'Prochain paiement :',
                      style: TextStyle(
                          fontSize: 12, color: Colors.white.withOpacity(0.7)),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Text(
                  'Lundi ${_formatDate(nextMonday)}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  'Dans $daysUntilMonday jour${daysUntilMonday > 1 ? 's' : ''}',
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.primaryGreen,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (pendingRequests > 0) ...[
                  const SizedBox(height: 15),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.primaryGreen.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.pending_actions,
                            color: AppColors.primaryGreen, size: 20),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Demandes en attente : $pendingRequests',
                                style: const TextStyle(
                                  fontSize: 11,
                                  color: Colors.white70,
                                ),
                              ),
                              Text(
                                'Montant total : ${pendingAmount.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]} ')} XOF',
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primaryGreen,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  DateTime _getNextMonday() {
    final now = DateTime.now();
    int daysUntilMonday = (DateTime.monday - now.weekday) % 7;
    if (daysUntilMonday == 0)
      daysUntilMonday = 7; // Si aujourd'hui est lundi, aller au prochain
    return DateTime(now.year, now.month, now.day + daysUntilMonday);
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
