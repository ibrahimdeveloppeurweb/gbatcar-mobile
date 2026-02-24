import 'package:flutter/material.dart';
import '../../shared/constants/app_colors.dart';

class FinesScreen extends StatelessWidget {
  const FinesScreen({super.key});

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
          "AMENDES À PAYER",
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
          // Header Summary
          Container(
            padding: const EdgeInsets.all(20),
            color: const Color(0xFFFDECEE), // Light Red background
            width: double.infinity,
            child: Column(
              children: const [
                Text(
                  "Total à payer",
                  style: TextStyle(color: AppColors.primaryNavy, fontSize: 14),
                ),
                SizedBox(height: 5),
                Text(
                  "36.000 FCFA",
                  style: TextStyle(
                    color: Color(0xFFEF5350),
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          // List
          Expanded(
            child: ListView.separated(
              itemCount: 3,
              separatorBuilder: (context, index) => const Divider(height: 1),
              itemBuilder: (context, index) {
                return _buildFineRow(index);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFineRow(int index) {
    // Mock data
    final List<Map<String, String>> fines = [
      {
        "date": "10/12/2024",
        "motif": "Stationnement interdit",
        "amount": "10.000 F",
        "location": "Plateau, Abidjan"
      },
      {
        "date": "12/12/2024",
        "motif": "Excès de vitesse",
        "amount": "20.000 F",
        "location": "Cocody, Riviéra 2"
      },
      {
        "date": "14/12/2024",
        "motif": "Feu rouge grillé",
        "amount": "6.000 F",
        "location": "Marcory, Zone 4"
      },
    ];

    final fine = fines[index];

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFFDECEE),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.receipt_long, color: Color(0xFFEF5350)),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  fine["motif"]!,
                  style: const TextStyle(
                    color: AppColors.primaryNavy,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  "${fine["date"]} • ${fine["location"]}",
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  fine["amount"]!,
                  style: const TextStyle(
                    color: Color(0xFFEF5350),
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFEF5350),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
            ),
            child: const Text("Payer",
                style: TextStyle(color: Colors.white, fontSize: 12)),
          ),
        ],
      ),
    );
  }
}
