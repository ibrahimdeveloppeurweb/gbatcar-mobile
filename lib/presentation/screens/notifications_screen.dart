import 'package:flutter/material.dart';
import '../../shared/constants/app_colors.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

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
        actions: [
          IconButton(
            icon: const Icon(Icons.done_all, color: AppColors.primaryNavy),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Notifications",
              style: TextStyle(
                color: AppColors.primaryNavy,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
            _buildDateHeader("27 décembre"),
            _buildNotificationCard(
              "😱 Retard de paiement",
              "Vous devez effectuer le paiement de 30000f pour votre recette du 27/12/2024 sinon vous serez",
              "16:30",
              isUnread: true,
            ),
            _buildNotificationCard(
              "💵 Rappel de paiement recette",
              "Vous devez effectuer le paiement de 30000f pour votre recette du 27/12/2024",
              "16:00",
              isUnread: true,
            ),
            const SizedBox(height: 30),
            _buildDateHeader("26 décembre"),
            _buildNotificationCard(
              "😱 Dépôt échoué",
              "Dépôt de 200f échoué",
              "16:55",
              isUnread: true,
            ),
            _buildNotificationCard(
              "😱 Retard de paiement",
              "Vous devez effectuer le paiement de 30000f pour votre recette du 26/12/2024 sinon vous serez",
              "16:30",
              isUnread: true,
            ),
            _buildNotificationCard(
              "😱 Dépôt échoué",
              "Dépôt de 200f échoué",
              "16:00",
              isUnread: false,
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildDateHeader(String date) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Text(
        date,
        style: const TextStyle(
          color: Color(0xFFB0BAC9),
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildNotificationCard(String title, String description, String time,
      {bool isUnread = false}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F9FC),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (isUnread)
                Container(
                  width: 8,
                  height: 8,
                  margin: const EdgeInsets.only(right: 10),
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.primaryNavy,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            description,
            style: const TextStyle(
              color: Color(0xFF9098B1),
              fontSize: 14,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 5),
          Align(
            alignment: Alignment.bottomRight,
            child: Text(
              time,
              style: const TextStyle(
                color: Color(0xFFB0BAC9),
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
