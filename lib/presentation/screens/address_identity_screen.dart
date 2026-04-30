import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../shared/constants/app_colors.dart';

class AddressIdentityScreen extends StatefulWidget {
  final String clientType;
  const AddressIdentityScreen({super.key, required this.clientType});

  @override
  State<AddressIdentityScreen> createState() => _AddressIdentityScreenState();
}

class _AddressIdentityScreenState extends State<AddressIdentityScreen> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primaryNavy),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.clientType == "Particulier" 
              ? "Informations personnelles" 
              : "Informations de l'entreprise",
          style: const TextStyle(
            color: Color(0xFF5A6B87),
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
                child: widget.clientType == "Particulier" 
                    ? _buildParticulierForm() 
                    : _buildEntrepriseForm(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryNavy,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    "Continuer",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildParticulierForm() {
    return Column(
      children: [
        _buildCustomTextField(
          label: "Nom complet *",
          controller: _nomCompletController,
          hint: "Nom et prénoms",
        ),
        const SizedBox(height: 20),
        _buildCustomTextField(
          label: "Téléphone *",
          controller: _telController,
          hint: "Numéro de Téléphone",
        ),
        const SizedBox(height: 20),
        _buildCustomTextField(
          label: "E-mail *",
          controller: _emailController,
          hint: "Adresse e-mail",
        ),
        const SizedBox(height: 20),
        _buildCustomTextField(
          label: "Lieu d'habitation *",
          controller: _habitationController,
          hint: "Lieu d'habitation",
        ),
        const SizedBox(height: 20),
        _buildCustomTextField(
          label: "Profession *",
          controller: _professionController,
          hint: "Votre profession",
        ),
        const SizedBox(height: 20),
        _buildCustomTextField(
          label: "Revenu mensuel *",
          controller: _revenuController,
          hint: "Votre revenu par mois",
        ),
        const SizedBox(height: 32),
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Téléchargez vos documents *",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.primaryNavy),
          ),
        ),
        const SizedBox(height: 24),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 1.4,
          children: [
            _buildUploadCard("Permis de conduire", true),
            _buildUploadCard("Pièce d'identité / Attestation / Passeport", true),
            _buildUploadCard("Casier judiciaire de moins de 3 mois", true),
            _buildUploadCard("04 photos identité", true, subtitle: "JPG, PNG (plusieurs fichiers)"),
            _buildUploadCard("Certificat de résidence de moins de 3 mois", true),
            _buildUploadCard("Bulletin de salaire", false),
          ],
        ),
      ],
    );
  }

  Widget _buildEntrepriseForm() {
    return Column(
      children: [
        _buildCustomTextField(
          label: "Raison sociale *",
          controller: _raisonSocialeController,
          hint: "Nom de l'entreprise",
        ),
        const SizedBox(height: 20),
        _buildCustomTextField(
          label: "Nom du gérant *",
          controller: _gerantController,
          hint: "Nom et prénoms",
        ),
        const SizedBox(height: 20),
        _buildCustomTextField(
          label: "Téléphone *",
          controller: _telController,
          hint: "Numéro de Téléphone",
        ),
        const SizedBox(height: 20),
        _buildCustomTextField(
          label: "E-mail *",
          controller: _emailController,
          hint: "Adresse e-mail",
        ),
        const SizedBox(height: 20),
        _buildCustomTextField(
          label: "Siège de l'entreprise *",
          controller: _siegeController,
          hint: "Siège de l'entreprise",
        ),
        const SizedBox(height: 20),
        _buildCustomTextField(
          label: "N° Compte contribuable *",
          controller: _compteContribuableController,
          hint: "Numéro de compte",
        ),
        const SizedBox(height: 32),
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Téléchargez vos documents *",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.primaryNavy),
          ),
        ),
        const SizedBox(height: 24),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 1.4,
          children: [
            _buildUploadCard("Registre de commerce", true),
            _buildUploadCard("DFE", true),
            _buildUploadCard("Pièce d'identité du gérant", true),
            _buildUploadCard("Casier judiciaire du gérant", true),
            _buildUploadCard("Statut de l'entreprise", true),
            _buildUploadCard("Relevé bancaire (6 derniers mois)", true),
          ],
        ),
      ],
    );
  }

  Widget _buildUploadCard(String label, bool isRequired, {String? subtitle}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          text: TextSpan(
            text: label,
            style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xFF334155)),
            children: [
              if (isRequired) const TextSpan(text: " *", style: TextStyle(color: Colors.red)),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Expanded(
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFF3B82F6), style: BorderStyle.solid),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.cloud_upload_outlined, color: Color(0xFF3B82F6), size: 28),
                const SizedBox(height: 4),
                const Text("Cliquez pour télécharger", style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500, color: Color(0xFF1E293B))),
                Text(subtitle ?? "PDF, JPG, PNG", style: TextStyle(fontSize: 9, color: Colors.grey[500])),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCustomTextField({
    required String label,
    String? hint,
    required TextEditingController controller,
    bool readOnly = false,
    VoidCallback? onTap,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC), // Light grey/blue background
        borderRadius: BorderRadius.circular(16), // Rounded edges
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              text: label.replaceAll(" *", ""),
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF5A6B87), // Muted dark blue
                fontWeight: FontWeight.w500,
              ),
              children: [
                if (label.contains(" *"))
                  const TextSpan(
                    text: " *",
                    style: TextStyle(color: Colors.red),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 4),
          TextField(
            controller: controller,
            readOnly: readOnly,
            onTap: onTap,
            style: const TextStyle(
              fontSize: 16,
              color: AppColors.primaryNavy,
              fontWeight: FontWeight.w600,
            ),
            decoration: InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.zero,
              border: InputBorder.none,
              hintText: hint,
              hintStyle: const TextStyle(
                fontSize: 16,
                color: Color(0xFF94A3B8), // Slate 400
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
