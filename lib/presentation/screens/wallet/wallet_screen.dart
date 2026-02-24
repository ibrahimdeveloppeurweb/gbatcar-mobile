import 'package:flutter/material.dart';
import 'package:project/shared/constants/app_colors.dart';
import '../deposit_screen.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA), // Off-white background
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8F9FA),
        elevation: 0,
        title: const Text(
          "MON PORTEFEUILLE",
          style: TextStyle(
            color: AppColors.primaryNavy,
            fontSize: 18,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.2,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            _buildWalletCard(context),
            const SizedBox(height: 30),
            _buildHistoryHeader(),
            const SizedBox(height: 15),
            _buildFilters(),
            const SizedBox(height: 20),
            _buildTransactionList(),
          ],
        ),
      ),
    );
  }

  Widget _buildWalletCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: AppColors.primaryNavy,
        borderRadius: BorderRadius.circular(30),
        gradient: const LinearGradient(
          colors: [Color(0xFF1A2847), Color(0xFF111A2E)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "SOLDE TOTAL",
            style: TextStyle(
              color: Colors.white70,
              fontSize: 11,
              letterSpacing: 1.5,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 10),
          RichText(
            text: TextSpan(
              children: [
                const TextSpan(
                  text: "697 ",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 48,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -1,
                  ),
                ),
                TextSpan(
                  text: "XOF",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            "Mis à jour à l'instant",
            style: TextStyle(
              color: Colors.white54,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 25),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "ENTRÉES",
                        style: TextStyle(
                          color: Colors.white54,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "+5.000 XOF",
                        style: TextStyle(
                          color: Color(0xFF2EAA5B),
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "SORTIES",
                        style: TextStyle(
                          color: Colors.white54,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "-700 XOF",
                        style: TextStyle(
                          color: Color(0xFFE53E3E), // Red
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 25),
          Center(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const DepositScreen()),
                );
              },
              child: Column(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Icon(Icons.add, color: Colors.white, size: 24),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Dépôt",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "Historique",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w900,
            color: AppColors.primaryNavy,
            letterSpacing: -0.5,
          ),
        ),
        Row(
          children: const [
            Text(
              "Voir tout ",
              style: TextStyle(
                color: Color(0xFF7A8999),
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
            Icon(Icons.arrow_forward, color: Color(0xFF7A8999), size: 14),
          ],
        ),
      ],
    );
  }

  Widget _buildFilters() {
    return Row(
      children: [
        _buildFilterChip("Tout", true),
        const SizedBox(width: 8),
        _buildFilterChip("Entrées", false),
        const SizedBox(width: 8),
        _buildFilterChip("Sorties", false),
      ],
    );
  }

  Widget _buildFilterChip(String label, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primaryNavy : const Color(0xFFE2E8F0),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.white : const Color(0xFF7A8999),
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget _buildTransactionList() {
    return Column(
      children: [
        _buildTransactionItem(
          icon: Icons.south_west,
          iconColor: AppColors.primaryNavy,
          iconBgColor: const Color(0xFFF3F6FB),
          title: "Rechargement Wave",
          titleColor: AppColors.primaryNavy,
          badgeText: "WAVE",
          date: "Aujourd'hui, 14:30",
          amount: "+1.000 XOF",
          amountColor: const Color(0xFF2EAA5B),
        ),
        _buildTransactionItem(
          icon: Icons.remove,
          iconColor: const Color(0xFFE53E3E),
          iconBgColor: const Color(0xFFFCE8E8),
          title: "Paiement rejeté",
          titleColor: const Color(0xFFE53E3E),
          badgeText: "WAVE",
          date: "26 décembre, 16:21",
          amount: "+200 XOF",
          amountColor: const Color(0xFF2EAA5B),
        ),
        _buildTransactionItem(
          icon: Icons.south_west,
          iconColor: AppColors.primaryNavy,
          iconBgColor: const Color(0xFFF3F6FB),
          title: "Paiement validé",
          titleColor: AppColors.primaryNavy,
          badgeText: "WAVE",
          date: "Hier, 09:12",
          amount: "-500 XOF",
          amountColor: AppColors.primaryNavy,
          showDivider: false,
        ),
      ],
    );
  }

  Widget _buildTransactionItem({
    required IconData icon,
    required Color iconColor,
    required Color iconBgColor,
    required String title,
    required Color titleColor,
    required String badgeText,
    required String date,
    required String amount,
    required Color amountColor,
    bool showDivider = true,
  }) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: iconBgColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Icon(
                  icon,
                  color: iconColor,
                  size: 24,
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: titleColor,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE6F0FA),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        badgeText,
                        style: const TextStyle(
                          color: Color(0xFF005ADB),
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      date,
                      style: const TextStyle(
                        color: Color(0xFF7A8999),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Text(
                amount,
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 16,
                  color: amountColor,
                  letterSpacing: -0.5,
                ),
              ),
            ],
          ),
        ),
        if (showDivider)
          const Divider(
            height: 1,
            thickness: 1,
            color: Color(0xFFE2E8F0),
          ),
      ],
    );
  }
}
