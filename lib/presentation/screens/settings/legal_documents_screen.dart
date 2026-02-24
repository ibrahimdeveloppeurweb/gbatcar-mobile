import 'package:flutter/material.dart';
import 'package:project/shared/constants/app_colors.dart';

class LegalDocumentsScreen extends StatelessWidget {
  const LegalDocumentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F9),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF4F6F9),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primaryNavy),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Documents juridiques",
          style: TextStyle(
            color: AppColors.primaryNavy,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "CONDITIONS ET POLITIQUES",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF7A8999),
                  letterSpacing: 1.5,
                ),
              ),
              const SizedBox(height: 15),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.02),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    _buildDocumentOption(
                      icon: Icons.description_outlined,
                      title: "Conditions Générales d'Utilisation",
                      onTap: () {},
                    ),
                    const Divider(height: 1, color: Color(0xFFF1F3F5)),
                    _buildDocumentOption(
                      icon: Icons.privacy_tip_outlined,
                      title: "Politique de Confidentialité",
                      onTap: () {},
                    ),
                    const Divider(height: 1, color: Color(0xFFF1F3F5)),
                    _buildDocumentOption(
                      icon: Icons.gavel_outlined,
                      title: "Règles d'utilisation du véhicule",
                      onTap: () {},
                    ),
                    const Divider(height: 1, color: Color(0xFFF1F3F5)),
                    _buildDocumentOption(
                      icon: Icons.handshake_outlined,
                      title: "Contrat de location-vente",
                      onTap: () {},
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                "MENTIONS LÉGALES",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF7A8999),
                  letterSpacing: 1.5,
                ),
              ),
              const SizedBox(height: 15),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.02),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: _buildDocumentOption(
                  icon: Icons.info_outline,
                  title: "Mentions légales et informations de l'entreprise",
                  onTap: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDocumentOption({
    required IconData icon,
    required String title,
    VoidCallback? onTap,
  }) {
    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: const Color(0xFFF3F6FB),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: AppColors.primaryNavy, size: 22),
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: AppColors.primaryNavy,
          fontWeight: FontWeight.w600,
          fontSize: 15,
        ),
      ),
      trailing:
          const Icon(Icons.download_rounded, color: AppColors.primaryNavy),
    );
  }
}
