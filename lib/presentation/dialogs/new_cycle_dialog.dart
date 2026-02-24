import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import '../../shared/constants/app_colors.dart';

class NewCycleDialog extends StatelessWidget {
  final String winnerName;
  final String winnerCity;
  final String reward;
  final int cycleNumber;
  final bool hasBonus;
  final String referralLink;

  const NewCycleDialog({
    Key? key,
    required this.winnerName,
    required this.winnerCity,
    required this.reward,
    required this.cycleNumber,
    this.hasBonus = false,
    required this.referralLink,
  }) : super(key: key);

  static Future<void> show(
    BuildContext context, {
    required String winnerName,
    required String winnerCity,
    required String reward,
    required int cycleNumber,
    bool hasBonus = false,
    required String referralLink,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => NewCycleDialog(
        winnerName: winnerName,
        winnerCity: winnerCity,
        reward: reward,
        cycleNumber: cycleNumber,
        hasBonus: hasBonus,
        referralLink: referralLink,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(25),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.background,
              AppColors.cardBackground,
            ],
          ),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: AppColors.primaryGreen, width: 3),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icône trophée
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                gradient: AppColors.greenGradient,
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Icon(
                  Icons.emoji_events,
                  color: Colors.white,
                  size: 60,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Titre
            const Text(
              'Le Cycle est bouclé !',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 20),

            // Info gagnant
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: AppColors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: AppColors.primaryGreen, width: 2),
              ),
              child: Column(
                children: [
                  const Text(
                    'Félicitations à',
                    style: TextStyle(fontSize: 14, color: Colors.white70),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    winnerName,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryGreen,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.location_on, color: Colors.white60, size: 14),
                      const SizedBox(width: 5),
                      Text(
                        winnerCity,
                        style: const TextStyle(fontSize: 12, color: Colors.white60),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Divider(color: Colors.white24, height: 1),
                  const SizedBox(height: 10),
                  const Text(
                    'Récompense :',
                    style: TextStyle(fontSize: 12, color: Colors.white70),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        reward.contains('Tecno') ? '📱' : '⌚',
                        style: const TextStyle(fontSize: 24),
                      ),
                      const SizedBox(width: 8),
                      Flexible(
                        child: Text(
                          reward,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Séparateur
            Row(
              children: [
                Expanded(child: Container(height: 2, color: AppColors.white.withOpacity(0.2))),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    'Cycle $cycleNumber',
                    style: TextStyle(fontSize: 12, color: Colors.white.withOpacity(0.6)),
                  ),
                ),
                Expanded(child: Container(height: 2, color: AppColors.white.withOpacity(0.2))),
              ],
            ),

            const SizedBox(height: 20),

            // Nouveau cycle
            const Text(
              'Nouveau cycle commence !',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              'Tous les compteurs repartent à zéro.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.white70),
            ),

            // Message bonus fidélité
            if (hasBonus)
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFFFD700), Color(0xFFFFA500)],
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      const Text('⭐', style: TextStyle(fontSize: 24)),
                      const SizedBox(width: 10),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'BONUS FIDÉLITÉ !',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 3),
                            Text(
                              'Vous commencez avec 1 point d\'avance !',
                              style: TextStyle(fontSize: 10, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            const SizedBox(height: 20),

            const Text(
              'À vos liens ! 🚀',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryGreen,
              ),
            ),

            const SizedBox(height: 25),

            // Boutons
            Column(
              children: [
                // Bouton Partager
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      _shareReferralLink();
                    },
                    icon: const Icon(Icons.share, color: Colors.white),
                    label: const Text(
                      'Partager mon lien',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryGreen,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                // Bouton OK
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      'OK, compris',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white70,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _shareReferralLink() {
    final message = '''
🎉 NOUVEAU CYCLE SELLOVIA ! 🎉

Le cycle $cycleNumber vient de commencer !

Félicitations à $winnerName de $winnerCity qui a remporté $reward ! 🏆

C'est ton tour maintenant ! Rejoins l'aventure et gagne ta montre de luxe en parrainant 20 amis.

👉 Commence maintenant :
$referralLink

À bientôt ! 🚀
''';
    Share.share(message);
  }
}
