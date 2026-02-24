import 'package:flutter/material.dart';
import '../../shared/constants/app_colors.dart';

class PaymentCalendarScreen extends StatelessWidget {
  const PaymentCalendarScreen({super.key});

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
        title: const Text(
          "CALENDRIER DE PAIEMENT",
          style: TextStyle(
            color: AppColors.primaryNavy,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Month Selector
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios,
                      size: 16, color: AppColors.primaryNavy),
                  onPressed: () {},
                ),
                const SizedBox(width: 20),
                const Text(
                  "Décembre 2024",
                  style: TextStyle(
                    color: AppColors.primaryNavy,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 20),
                IconButton(
                  icon: const Icon(Icons.arrow_forward_ios,
                      size: 16, color: AppColors.primaryNavy),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          // Table Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            color: const Color(0xFFF4F6F9),
            child: Row(
              children: const [
                SizedBox(
                    width: 50,
                    child: Text("Date",
                        style: TextStyle(
                            color: AppColors.primaryNavy,
                            fontWeight: FontWeight.bold))),
                Expanded(
                    child: Text("Payé",
                        style: TextStyle(
                            color: AppColors.primaryNavy,
                            fontWeight: FontWeight.bold))),
                Expanded(
                    child: Text("Restant",
                        style: TextStyle(
                            color: AppColors.primaryNavy,
                            fontWeight: FontWeight.bold))),
                SizedBox(
                    width: 50,
                    child: Text("Statut",
                        style: TextStyle(
                            color: AppColors.primaryNavy,
                            fontWeight: FontWeight.bold))),
                SizedBox(width: 60), // Space for button
              ],
            ),
          ),
          // List
          Expanded(
            child: ListView.separated(
              itemCount: 10,
              separatorBuilder: (context, index) => const Divider(height: 1),
              itemBuilder: (context, index) {
                return _buildPaymentRow(index);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentRow(int index) {
    // Generate dates starting from 03/12
    final int day = 3 + index;
    final String date = "${day.toString().padLeft(2, '0')}/12";

    // Based on screenshot, mostly "Retard" and "Payer" button
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Row(
        children: [
          SizedBox(
            width: 50,
            child: Text(
              date,
              style: const TextStyle(
                color: AppColors.primaryNavy,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const Expanded(
            child: Text(
              "28.000 F",
              style: TextStyle(color: AppColors.primaryNavy),
            ),
          ),
          const Expanded(
            child: Text(
              "28.000 F",
              style: TextStyle(color: AppColors.primaryNavy),
            ),
          ),
          const SizedBox(
            width: 50,
            child: Text(
              "Retard",
              style: TextStyle(
                color: Color(0xFFE57373), // Red
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
          SizedBox(
            width: 70,
            height: 30,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryNavy,
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text(
                "Payer",
                style: TextStyle(fontSize: 12, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
