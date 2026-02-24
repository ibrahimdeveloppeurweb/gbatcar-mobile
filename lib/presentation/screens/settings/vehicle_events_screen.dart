import 'package:flutter/material.dart';
import 'package:project/shared/constants/app_colors.dart';

class VehicleEventsScreen extends StatelessWidget {
  const VehicleEventsScreen({super.key});

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
          "Évènements du véhicule",
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
                "À VENIR",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF7A8999),
                  letterSpacing: 1.5,
                ),
              ),
              const SizedBox(height: 15),
              _buildEventCard(
                icon: Icons.build_outlined,
                iconColor: const Color(0xFFF09819),
                iconBgColor: const Color(0xFFFFF4E5),
                title: "Prochaine Vidange",
                date: "Prévue dans 2 500 km",
                description: "Changement d'huile moteur et filtre.",
                status: "À planifier",
                statusColor: const Color(0xFFF09819),
                statusBgColor: const Color(0xFFFFF4E5),
              ),
              const SizedBox(height: 15),
              _buildEventCard(
                icon: Icons.receipt_long,
                iconColor: const Color(0xFFE53E3E),
                iconBgColor: const Color(0xFFFCE8E8),
                title: "Vignette Automobile",
                date: "Échéance : 15 Mars 2026",
                description: "Renouvellement de la vignette annuelle.",
                status: "Urgent",
                statusColor: const Color(0xFFE53E3E),
                statusBgColor: const Color(0xFFFCE8E8),
              ),
              const SizedBox(height: 30),
              const Text(
                "HISTORIQUE RÉCENT",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF7A8999),
                  letterSpacing: 1.5,
                ),
              ),
              const SizedBox(height: 15),
              _buildEventCard(
                icon: Icons.tire_repair,
                iconColor: AppColors.primaryNavy,
                iconBgColor: const Color(0xFFE6F0FA),
                title: "Pression des pneus",
                date: "Effectué le 10 Fév 2026",
                description: "Vérification et ajustement à 2.3 bar.",
                status: "Terminé",
                statusColor: const Color(0xFF2EAA5B),
                statusBgColor: const Color(0xFFE6F4EA),
              ),
              const SizedBox(height: 15),
              _buildEventCard(
                icon: Icons.verified_user_outlined,
                iconColor: AppColors.primaryNavy,
                iconBgColor: const Color(0xFFE6F0FA),
                title: "Assurance Santé",
                date: "Effectué le 05 Jan 2026",
                description: "Paiement de la prime d'assurance annuelle.",
                status: "Terminé",
                statusColor: const Color(0xFF2EAA5B),
                statusBgColor: const Color(0xFFE6F4EA),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Action pour ajouter un nouvel événement
        },
        backgroundColor: AppColors.primaryNavy,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildEventCard({
    required IconData icon,
    required Color iconColor,
    required Color iconBgColor,
    required String title,
    required String date,
    required String description,
    required String status,
    required Color statusColor,
    required Color statusBgColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: iconBgColor,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(icon, color: iconColor, size: 24),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: const TextStyle(
                          color: AppColors.primaryNavy,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: statusBgColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        status,
                        style: TextStyle(
                          color: statusColor,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Text(
                  date,
                  style: const TextStyle(
                    color: Color(0xFF7A8999),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: const TextStyle(
                    color: Color(0xFF7A8999),
                    fontSize: 13,
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
