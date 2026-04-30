import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../shared/constants/app_colors.dart';
import 'address_identity_screen.dart';
import 'faq_screen.dart';
import 'questionnaire_screen.dart';
import 'vehicle_leasing_screen.dart';

class OnboardingStepsScreen extends StatefulWidget {
  const OnboardingStepsScreen({super.key});

  @override
  State<OnboardingStepsScreen> createState() => _OnboardingStepsScreenState();
}

class _OnboardingStepsScreenState extends State<OnboardingStepsScreen> {
  String _clientType = "Particulier"; // "Particulier" or "Entreprise"

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leadingWidth: 160,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: GestureDetector(
            onTap: () {
              _showLogoutConfirmation(context);
            },
            child: Row(
              children: [
                const Icon(Icons.logout,
                    color: AppColors.primaryNavy, size: 20),
                const SizedBox(width: 8),
                const Text(
                  "Déconnexion",
                  style: TextStyle(
                    color: AppColors.primaryNavy,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline, color: AppColors.primaryNavy),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FaqScreen()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.language, color: AppColors.primaryNavy),
            onPressed: () async {
              final Uri url = Uri.parse('https://gbatcar.com/');
              if (!await launchUrl(url)) {
                debugPrint('Could not launch \$url');
              }
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    // Main Title
                    Text(
                      "Devenez propriétaire de véhicule avec GbatCar en ${_clientType == "Particulier" ? "5" : "4"} étapes",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                        color: AppColors.primaryNavy,
                        height: 1.2,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Subtitle
                    const Text(
                      "Suivez les étapes ci-dessous pour activer votre\ncompte",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF94A3B8), // slate-400
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 30),

                    // Client Type Selection (Nouveau design en Cartes)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: const TextSpan(
                            text: "Je suis un",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: AppColors.primaryNavy,
                            ),
                            children: [
                              TextSpan(
                                text: " *",
                                style: TextStyle(color: Colors.red),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            // Carte Particulier
                            Expanded(
                              child: GestureDetector(
                                onTap: () =>
                                    setState(() => _clientType = "Particulier"),
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  decoration: BoxDecoration(
                                    color: _clientType == "Particulier"
                                        ? const Color(
                                            0xFFF1F5F9) // Light Slate/Navy background
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                      color: _clientType == "Particulier"
                                          ? AppColors.primaryNavy
                                          : const Color(0xFFE2E8F0),
                                      width:
                                          _clientType == "Particulier" ? 2 : 1,
                                    ),
                                    boxShadow: _clientType == "Particulier"
                                        ? [
                                            BoxShadow(
                                              color: AppColors.primaryNavy
                                                  .withOpacity(0.15),
                                              blurRadius: 12,
                                              offset: const Offset(0, 4),
                                            )
                                          ]
                                        : [],
                                  ),
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.person_outline,
                                        size: 36,
                                        color: _clientType == "Particulier"
                                            ? AppColors.primaryNavy
                                            : const Color(0xFF94A3B8),
                                      ),
                                      const SizedBox(height: 12),
                                      Text(
                                        "Particulier",
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700,
                                          color: _clientType == "Particulier"
                                              ? AppColors.primaryNavy
                                              : const Color(0xFF64748B),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            // Carte Entreprise
                            Expanded(
                              child: GestureDetector(
                                onTap: () =>
                                    setState(() => _clientType = "Entreprise"),
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  decoration: BoxDecoration(
                                    color: _clientType == "Entreprise"
                                        ? const Color(
                                            0xFFF1F5F9) // Light Slate/Navy background
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                      color: _clientType == "Entreprise"
                                          ? AppColors.primaryNavy
                                          : const Color(0xFFE2E8F0),
                                      width:
                                          _clientType == "Entreprise" ? 2 : 1,
                                    ),
                                    boxShadow: _clientType == "Entreprise"
                                        ? [
                                            BoxShadow(
                                              color: AppColors.primaryNavy
                                                  .withOpacity(0.15),
                                              blurRadius: 12,
                                              offset: const Offset(0, 4),
                                            )
                                          ]
                                        : [],
                                  ),
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.domain,
                                        size: 36,
                                        color: _clientType == "Entreprise"
                                            ? AppColors.primaryNavy
                                            : const Color(0xFF94A3B8),
                                      ),
                                      const SizedBox(height: 12),
                                      Text(
                                        "Entreprise",
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700,
                                          color: _clientType == "Entreprise"
                                              ? AppColors.primaryNavy
                                              : const Color(0xFF64748B),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),

                    // Steps List
                    _buildStepItem(
                      number: "1",
                      title: "Vérifiez votre identité et\nadresse",
                      isPending: true,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                AddressIdentityScreen(clientType: _clientType),
                          ),
                        );
                      },
                    ),
                    if (_clientType == "Particulier")
                      _buildStepItem(
                        number: "2",
                        title: "Répondez au questionnaire",
                        isPending: true,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  QuestionnaireScreen(clientType: _clientType),
                            ),
                          );
                        },
                      ),
                    _buildStepItem(
                      number: _clientType == "Particulier" ? "3" : "2",
                      title: "Choisissez votre véhicule et\nleasing",
                      isPending: true,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                VehicleLeasingScreen(clientType: _clientType),
                          ),
                        );
                      },
                    ),
                    _buildStepItem(
                      number: _clientType == "Particulier" ? "4" : "3",
                      title:
                          "Participez à la formation/test\nau bureau GbatCar",
                      isDisabled: true,
                    ),
                    _buildStepItem(
                      number: _clientType == "Particulier" ? "5" : "4",
                      title: "Signez le contrat et récupérez\nvotre véhicule",
                      showDivider: false,
                      isDisabled: true,
                    ),

                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),

            // Footer text
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: GestureDetector(
                onTap: () async {
                  final Uri launchUri = Uri(
                    scheme: 'tel',
                    path: '+2250719414141',
                  );
                  try {
                    await launchUrl(launchUri);
                  } catch (e) {
                    debugPrint("Could not launch $launchUri: $e");
                  }
                },
                child: RichText(
                  textAlign: TextAlign.center,
                  text: const TextSpan(
                    style: TextStyle(
                      fontSize: 13,
                      color: Color(0xFF94A3B8), // slate-400
                      height: 1.5,
                    ),
                    children: [
                      TextSpan(
                          text:
                              "Besoin d'aide pour créer votre compte ? Appelez\nle support au "),
                      TextSpan(
                        text: "+225 070 245 0202",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: AppColors.primaryNavy,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showLogoutConfirmation(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Drag handle
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 24),
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const Text(
                "Voulez-vous vous\ndéconnecter ?",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryNavy,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "Lorsque vous vous déconnectez, vous devez recommencer la procédure de connexion.",
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.primaryNavy,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 32),
              GestureDetector(
                onTap: () {
                  // User confirms logout
                  Navigator.pop(context); // Close sheet
                  Navigator.popUntil(
                      context, (route) => route.isFirst); // Go to login/splash
                },
                child: Container(
                  height: 52,
                  decoration: BoxDecoration(
                    color: AppColors.primaryNavy,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                    child: Text(
                      "Continuer",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              GestureDetector(
                onTap: () {
                  // Cancel logout
                  Navigator.pop(context);
                },
                child: Container(
                  height: 52,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8FAFC), // Very light grey/blue
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                    child: Text(
                      "Annuler",
                      style: TextStyle(
                        color: AppColors.primaryNavy,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStepItem({
    required String number,
    required String title,
    bool isPending = false,
    bool showDivider = true,
    bool isDisabled = false,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: isDisabled ? null : onTap,
      child: Column(
        children: [
          Row(
            crossAxisAlignment:
                CrossAxisAlignment.start, // Align to top for multi-line titles
            children: [
              // Number Box
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: isDisabled
                      ? const Color(0x80D30018)
                      : const Color(0xFFD30018),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    number,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: AppColors.white, // White text for all steps
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),

              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: isDisabled
                            ? const Color(0xFF94A3B8)
                            : AppColors.primaryNavy,
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 12),
                    // Status Badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: isPending
                            ? const Color(0xFFF3EDFA)
                            : const Color(0xFFF1F5F9),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 6,
                            height: 6,
                            decoration: BoxDecoration(
                              color: isPending
                                  ? const Color(0xFF6346A8)
                                  : const Color(0xFF5A6B87),
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            isPending
                                ? "En attente de validation"
                                : "Pas encore rempli",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: isPending
                                  ? const Color(0xFF6346A8)
                                  : const Color(0xFF5A6B87),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Right Icon
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: isPending
                      ? const Color(0xFFF3EDFA)
                      : const Color(0xFFF8FAFC),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Icon(
                    isPending ? Icons.schedule : Icons.arrow_forward,
                    size: 16,
                    color: isPending
                        ? const Color(0xFF6346A8)
                        : (isDisabled
                            ? const Color(0xFF94A3B8)
                            : AppColors.primaryNavy),
                  ),
                ),
              ),
            ],
          ),
          if (showDivider) ...[
            const SizedBox(height: 20),
            Divider(
              color: Colors.grey[300],
              thickness: 1,
              height: 1,
            ),
            const SizedBox(height: 20),
          ],
        ],
      ),
    );
  }
}
