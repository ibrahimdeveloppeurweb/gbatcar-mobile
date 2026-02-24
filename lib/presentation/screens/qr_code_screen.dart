import 'package:flutter/material.dart';
import '../../shared/constants/app_colors.dart';

class QrCodeScreen extends StatelessWidget {
  const QrCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryLime,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              const SizedBox(height: 10),
              // Close Button
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: const Icon(Icons.close,
                      color: AppColors.primaryNavy, size: 30),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              const Spacer(),
              // Title
              const Text(
                "Scanner pour payer\nvotre voyage",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.primaryNavy,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 40),
              // QR Code Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Stylized QR Code placeholder
                        Opacity(
                          opacity: 0.8,
                          child: Icon(
                            Icons.qr_code_2,
                            size: 200,
                            color: AppColors.primaryNavy.withOpacity(0.8),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const Spacer(),
              // Driver ID
              const Text(
                "ID du conducteur: DGJMSIM1YMP2D",
                style: TextStyle(
                  color: AppColors.primaryNavy,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
