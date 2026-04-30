import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../shared/constants/app_colors.dart';
import '../layouts/main_layout.dart'; // For Dashboard navigation
import 'onboarding_steps_screen.dart'; // New onboarding screen

class PersonalInfoScreen extends StatefulWidget {
  const PersonalInfoScreen({super.key});

  @override
  State<PersonalInfoScreen> createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends State<PersonalInfoScreen> {
  String _clientType = "Particulier"; // "Particulier" or "Entreprise"

  // Controllers for Particulier
  final TextEditingController _nomCompletController = TextEditingController();
  final TextEditingController _telController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _habitationController = TextEditingController();
  final TextEditingController _professionController = TextEditingController();
  final TextEditingController _revenuController = TextEditingController();

  // Controllers for Entreprise
  final TextEditingController _raisonSocialeController = TextEditingController();
  final TextEditingController _gerantController = TextEditingController();
  final TextEditingController _siegeController = TextEditingController();
  final TextEditingController _compteContribuableController = TextEditingController();

  @override
  void dispose() {
    _nomCompletController.dispose();
    _telController.dispose();
    _emailController.dispose();
    _habitationController.dispose();
    _professionController.dispose();
    _revenuController.dispose();
    _raisonSocialeController.dispose();
    _gerantController.dispose();
    _siegeController.dispose();
    _compteContribuableController.dispose();
    super.dispose();
  }

  void _onCommencerPressed() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const OnboardingStepsScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primaryNavy),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [



            ],
          ),
        ),
      ),
    );
  }

  Widget _buildParticulierForm() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildInputField(
                label: "Nom complet *",
                controller: _nomCompletController,
                hintText: "Nom et prénoms",
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildInputField(
                label: "Téléphone *",
                controller: _telController,
                hintText: "Numéro de Téléphone",
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: _buildInputField(
                label: "E-mail *",
                controller: _emailController,
                hintText: "Adresse e-mail",
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildInputField(
                label: "Lieu d'habitation *",
                controller: _habitationController,
                hintText: "Lieu d'habitation",
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: _buildInputField(
                label: "Profession *",
                controller: _professionController,
                hintText: "Votre profession",
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildInputField(
                label: "Revenu mensuel *",
                controller: _revenuController,
                hintText: "Votre revenu par mois",
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildEntrepriseForm() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildInputField(
                label: "Raison sociale *",
                controller: _raisonSocialeController,
                hintText: "Nom de l'entreprise",
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildInputField(
                label: "Nom du gérant *",
                controller: _gerantController,
                hintText: "Nom et prénoms",
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: _buildInputField(
                label: "Téléphone *",
                controller: _telController,
                hintText: "Numéro de Téléphone",
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildInputField(
                label: "E-mail *",
                controller: _emailController,
                hintText: "Adresse e-mail",
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: _buildInputField(
                label: "Siège de l'entreprise *",
                controller: _siegeController,
                hintText: "Siège de l'entreprise",
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildInputField(
                label: "N° Compte contribuable *",
                controller: _compteContribuableController,
                hintText: "Numéro de compte",
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    required String hintText,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: label.replaceAll(" *", ""),
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Color(0xFF334155), // Slate 700
            ),
            children: const [
              TextSpan(
                text: " *",
                style: TextStyle(color: Colors.red),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: const Color(0xFFF8FAFC), // Slate 50
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFFE2E8F0)), // Slate 200
          ),
          child: TextField(
            controller: controller,
            style: const TextStyle(fontSize: 14, color: AppColors.primaryNavy),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hintText,
              hintStyle: const TextStyle(color: Color(0xFF94A3B8), fontSize: 14), // Slate 400
              contentPadding: const EdgeInsets.symmetric(vertical: 14),
            ),
          ),
        ),
      ],
    );
  }
}
