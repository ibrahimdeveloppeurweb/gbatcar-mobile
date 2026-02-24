import 'package:flutter/material.dart';
import 'package:project/shared/constants/app_colors.dart';
import 'package:project/presentation/screens/settings/personal_details_screen.dart';
import 'package:project/presentation/screens/settings/vehicle_events_screen.dart';
import 'package:project/presentation/screens/settings/security_settings_screen.dart';
import 'package:project/presentation/screens/settings/legal_documents_screen.dart';
import 'package:project/presentation/screens/settings/support_contact_screen.dart';
import 'package:project/presentation/screens/settings/report_problem_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F9), // Light blue-grey background
      appBar: AppBar(
        backgroundColor: const Color(0xFFF4F6F9),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primaryNavy),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Paramètres",
          style: TextStyle(
            color: AppColors.primaryNavy,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            // First group of settings
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  _buildSettingsCard([
                    _buildSettingsItem(
                        Icons.person, "Détails personnels", context, onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PersonalDetailsScreen(),
                        ),
                      );
                    }),
                    _buildSettingsItem(
                        Icons.directions_car, "Evènements du véhicule", context,
                        onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const VehicleEventsScreen(),
                        ),
                      );
                    }),
                    _buildSettingsItem(
                        Icons.security, "Paramètres de sécurité", context,
                        onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SecuritySettingsScreen(),
                        ),
                      );
                    }),
                    _buildSettingsItem(
                        Icons.bug_report, "Signaler un problème", context,
                        onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ReportProblemScreen(),
                        ),
                      );
                    }),
                    _buildSettingsItem(
                        Icons.description, "Documents juridiques", context,
                        onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LegalDocumentsScreen(),
                        ),
                      );
                    }),
                  ]),
                  const SizedBox(height: 20),
                  // Support section
                  _buildSettingsCard([
                    _buildSettingsItem(
                        Icons.phone, "Contacter le support", context,
                        onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SupportContactScreen(),
                        ),
                      );
                    }),
                  ]),
                  const SizedBox(height: 40),
                ],
              ),
            ),
            // Footer section
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const Text(
                    "Version 24.12.18+110",
                    style: TextStyle(
                      color: Color(0xFFB0BAC9),
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // Logout logic placeholder
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: AppColors.primaryNavy,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        "Se déconnecter",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsCard(List<Widget> children) {
    return Container(
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
        children: children,
      ),
    );
  }

  Widget _buildSettingsItem(IconData icon, String title, BuildContext context,
      {VoidCallback? onTap}) {
    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: const Color(0xFFF7F9FC),
          borderRadius: BorderRadius.circular(10),
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
      trailing: const Icon(Icons.chevron_right, color: AppColors.primaryNavy),
    );
  }
}
