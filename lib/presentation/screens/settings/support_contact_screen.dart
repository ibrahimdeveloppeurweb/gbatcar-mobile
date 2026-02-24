import 'package:flutter/material.dart';
import 'package:project/shared/constants/app_colors.dart';

class SupportContactScreen extends StatelessWidget {
  const SupportContactScreen({super.key});

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
          "Contacter le support",
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
              // Illustration or Header (Placeholder Icon)
              Center(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE6F0FA),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.support_agent_rounded,
                    size: 80,
                    color: AppColors.primaryNavy,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              const Center(
                child: Text(
                  "Comment pouvons-nous vous aider ?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.primaryNavy,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Center(
                child: Text(
                  "Notre équipe de support est disponible 24/7 pour répondre à vos questions et résoudre vos problèmes en un rien de temps.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF7A8999),
                    fontSize: 14,
                    height: 1.5,
                  ),
                ),
              ),
              const SizedBox(height: 40),

              // Contact Options
              const Text(
                "MÉTHODES DE CONTACT",
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
                    _buildContactOption(
                      icon: Icons.phone_in_talk,
                      iconColor: const Color(0xFF2EAA5B),
                      iconBgColor: const Color(0xFFE6F4EA),
                      title: "Appeler le service client",
                      subtitle: "Assistance immédiate par voix",
                      onTap: () {},
                    ),
                    const Divider(height: 1, color: Color(0xFFF1F3F5)),
                    _buildContactOption(
                      icon: Icons.chat_bubble_outline,
                      iconColor: const Color(0xFF005ADB),
                      iconBgColor: const Color(0xFFE6F0FA),
                      title: "Discuter sur WhatsApp",
                      subtitle: "Réponse habituelle en moins de 5 min",
                      onTap: () {},
                    ),
                    const Divider(height: 1, color: Color(0xFFF1F3F5)),
                    _buildContactOption(
                      icon: Icons.email_outlined,
                      iconColor: const Color(0xFFF09819),
                      iconBgColor: const Color(0xFFFFF4E5),
                      title: "Envoyer un e-mail",
                      subtitle: "support@gocab.ci",
                      onTap: () {},
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),

              // FAQ Link
              Center(
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    "Consulter la Foire Aux Questions (FAQ)",
                    style: TextStyle(
                      color: AppColors.primaryNavy,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContactOption({
    required IconData icon,
    required Color iconColor,
    required Color iconBgColor,
    required String title,
    required String subtitle,
    VoidCallback? onTap,
  }) {
    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      leading: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: iconBgColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Icon(icon, color: iconColor, size: 24),
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: AppColors.primaryNavy,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 4),
        child: Text(
          subtitle,
          style: const TextStyle(
            color: Color(0xFF7A8999),
            fontSize: 13,
          ),
        ),
      ),
      trailing: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: const Color(0xFFF7F9FC),
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.arrow_forward_ios,
            size: 14, color: AppColors.primaryNavy),
      ),
    );
  }
}
