import 'package:flutter/material.dart';
import 'package:project/presentation/screens/fines_screen.dart';
import 'package:project/presentation/screens/payment_calendar_screen.dart';
import '../../shared/constants/app_colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 80, // Increased height for avatar
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.blue[100],
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.person, color: AppColors.primaryNavy),
            ),
            const SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Bonjour",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                Text(
                  "REINE",
                  style: TextStyle(
                    color: AppColors.primaryNavy,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              _buildVehicleProgressCard(),
              const SizedBox(height: 20),
              _buildStatusCard(
                "200 000 F",
                "Caution",
                const Color(0xFFEF5350), // Red
                Colors.white,
                action: _buildActionButton("Payer"),
                icon: Icons.info_outline,
              ),
              const SizedBox(height: 15),
              _buildStatusCard(
                "30 000 F",
                "Traites impayées",
                const Color(0xFFEF5350), // Red
                Colors.white,
                action: _buildActionButton("Voir"),
                icon: Icons.info_outline,
              ),
              const SizedBox(height: 15),
              _buildStatusCard(
                "0 F",
                "Factures à payer",
                const Color(0xFFF5F5F5), // Light Grey
                AppColors.primaryNavy,
                isArrowAction: true,
                icon: Icons.receipt,
                onTap: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          const PaymentCalendarScreen(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        const begin = Offset(1.0, 0.0);
                        const end = Offset.zero;
                        const curve = Curves.easeInOut;
                        var tween = Tween(begin: begin, end: end)
                            .chain(CurveTween(curve: curve));
                        return SlideTransition(
                          position: animation.drive(tween),
                          child: child,
                        );
                      },
                    ),
                  );
                },
              ),
              const SizedBox(height: 15),
              _buildStatusCard(
                "36 000 F",
                "Amendes à payer",
                const Color(0xFFEF5350), // Red
                Colors.white,
                isArrowAction: true,
                icon: Icons.flag,
                onTap: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          const FinesScreen(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        const begin = Offset(1.0, 0.0);
                        const end = Offset.zero;
                        const curve = Curves.easeInOut;
                        var tween = Tween(begin: begin, end: end)
                            .chain(CurveTween(curve: curve));
                        return SlideTransition(
                          position: animation.drive(tween),
                          child: child,
                        );
                      },
                    ),
                  );
                },
              ),
              const SizedBox(height: 80), // Bottom padding for nav bar
            ],
          ),
        ),
      ),
    );
  }



  Widget _buildVehicleProgressCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F7FA), // Light Blue/Grey background
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Bestune T55",
            style: TextStyle(
              color: AppColors.primaryNavy,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.primaryNavy),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              "AA-280-TN-01",
              style: TextStyle(
                color: AppColors.primaryNavy,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(height: 25),
          const Text(
            "12.88%",
            style: TextStyle(
              color: AppColors.primaryNavy,
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Text(
            "de votre location",
            style: TextStyle(color: AppColors.primaryNavy, fontSize: 14),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text("987 000 F", style: TextStyle(color: AppColors.textGrey)),
              Text("7 665 000 F", style: TextStyle(color: AppColors.textGrey)),
            ],
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: 0.1288,
              minHeight: 12,
              backgroundColor: Colors.grey[300],
              valueColor:
                  const AlwaysStoppedAnimation<Color>(AppColors.primaryNavy),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFEFEFEF), // Light grey button
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: AppColors.primaryNavy,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildStatusCard(
      String amount, String label, Color bgColor, Color textColor,
      {Widget? action,
      bool isArrowAction = false,
      required IconData icon,
      VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: textColor, size: 20),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    amount,
                    style: TextStyle(
                      color: textColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    label,
                    style: TextStyle(
                      color: textColor.withOpacity(0.9),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            if (action != null) action,
            if (isArrowAction)
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.arrow_forward, color: textColor, size: 20),
              ),
          ],
        ),
      ),
    );
  }
}
