import 'package:flutter/material.dart';
import '../../shared/constants/app_colors.dart';

class AmbassadorCharterDialog extends StatefulWidget {
  final VoidCallback onAccept;

  const AmbassadorCharterDialog({
    Key? key,
    required this.onAccept,
  }) : super(key: key);

  static Future<bool> show(BuildContext context, VoidCallback onAccept) async {
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => AmbassadorCharterDialog(onAccept: onAccept),
    );
    return result ?? false;
  }

  @override
  State<AmbassadorCharterDialog> createState() => _AmbassadorCharterDialogState();
}

class _AmbassadorCharterDialogState extends State<AmbassadorCharterDialog> {
  bool _accepted = false;
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        constraints: const BoxConstraints(maxHeight: 600),
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
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: AppColors.primaryGreen, width: 3),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
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
                    child: Text('📜', style: TextStyle(fontSize: 24)),
                  ),
                ),
                const SizedBox(width: 15),
                const Expanded(
                  child: Text(
                    'CHARTE AMBASSADEUR',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Contenu scrollable
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: AppColors.white.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Scrollbar(
                  controller: _scrollController,
                  thumbVisibility: true,
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'En activant mon lien de parrainage et en devenant Ambassadeur Sellovia, je m\'engage à respecter les principes suivants :',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.white.withOpacity(0.9),
                            height: 1.5,
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Règle 1
                        _buildRule(
                          icon: Icons.storefront,
                          title: '1. Présentation honnête',
                          description:
                              'Je présenterai toujours Sellovia comme une plateforme e-commerce participative avec programme de parrainage gamifié.',
                        ),

                        // Règle 2
                        _buildRule(
                          icon: Icons.block,
                          title: '2. Vocabulaire interdit',
                          description:
                              'Je m\'engage à NE JAMAIS utiliser les termes suivants :\n• "Investissement"\n• "Multiplication de capital"\n• "Rendement garanti"\n• "Système pyramidal"\n• "MLM" ou "Marketing de réseau"',
                        ),

                        // Règle 3
                        _buildRule(
                          icon: Icons.visibility,
                          title: '3. Transparence des gains',
                          description:
                              'Je serai transparent sur :\n• Le coût d\'inscription (500F ou 1000F)\n• Le nombre de parrainages requis (20 ou 35)\n• Les récompenses possibles\n• La commission ambassadeur (100F par filleul actif)',
                        ),

                        // Règle 4
                        _buildRule(
                          icon: Icons.security,
                          title: '4. Interdiction de fraude',
                          description:
                              'Je m\'engage à ne pas :\n• Créer de faux comptes\n• Manipuler les parrainages\n• Utiliser des méthodes trompeuses\n• Spammer ou harceler les prospects',
                        ),

                        // Règle 5
                        _buildRule(
                          icon: Icons.warning_amber,
                          title: '5. Pas de garantie de victoire',
                          description:
                              'Je reconnais que :\n• Le succès dépend des efforts personnels\n• Aucune victoire n\'est garantie\n• Les cycles peuvent se terminer rapidement\n• Je dois respecter les règles du jeu',
                        ),

                        const SizedBox(height: 20),

                        // Avertissement
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppColors.error.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: AppColors.error, width: 2),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(Icons.warning, color: AppColors.error, size: 20),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  'Toute violation de cette charte entraînera la suspension immédiate du compte et la perte des gains accumulés.',
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.white.withOpacity(0.9),
                                    height: 1.4,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Checkbox acceptation
            GestureDetector(
              onTap: () => setState(() => _accepted = !_accepted),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _accepted
                      ? AppColors.primaryGreen.withOpacity(0.2)
                      : AppColors.white.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: _accepted ? AppColors.primaryGreen : AppColors.white.withOpacity(0.2),
                    width: 2,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: _accepted ? AppColors.primaryGreen : Colors.transparent,
                        border: Border.all(
                          color: _accepted ? AppColors.primaryGreen : Colors.white54,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: _accepted
                          ? const Icon(Icons.check, color: Colors.white, size: 16)
                          : null,
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Text(
                        'J\'ai lu et j\'accepte la charte ambassadeur',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 15),

            // Boutons
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => Navigator.pop(context, false),
                    child: const Text(
                      'Annuler',
                      style: TextStyle(color: Colors.white54),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: _accepted
                        ? () {
                            widget.onAccept();
                            Navigator.pop(context, true);
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _accepted ? AppColors.primaryGreen : AppColors.grey,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Activer mon statut',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
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

  Widget _buildRule({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              gradient: AppColors.greenGradient,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: Colors.white, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryGreen,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white.withOpacity(0.8),
                    height: 1.4,
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
