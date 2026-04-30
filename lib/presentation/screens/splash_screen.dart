import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:project/data/providers/auth_provider.dart';
import 'package:project/presentation/screens/onboarding_screen.dart';
import 'package:project/presentation/layouts/main_layout.dart';
import 'package:project/shared/constants/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String _loadingMessage = 'Initialisation...';

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    try {
      await Future.delayed(const Duration(milliseconds: 1000));

      if (!mounted) return;

      final authProvider = context.read<AuthProvider>();
      final isAuthenticated = await authProvider.checkAuthStatus();

      if (!mounted) return;

      if (isAuthenticated) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const OnboardingScreen()));
        // Navigator.of(context).pushReplacement(
        //     MaterialPageRoute(builder: (_) => const OnboardingScreen()));
      } else {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const OnboardingScreen()));
      }
    } catch (e) {
      debugPrint('Error: $e');
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const OnboardingScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.brandRose1,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo1.png',
              width: 300, // Ajustez la largeur selon vos besoins
              errorBuilder: (context, error, stackTrace) {
                // Securité au cas où l'image n'est pas encore enregistrée dans pubspec.yaml
                return const Text(
                  'GbatCar',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w900,
                    color: AppColors.surfaceWhite,
                    letterSpacing: 2,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
