import 'package:flutter/material.dart';
import '../../shared/constants/app_colors.dart';
import 'login_screen.dart'; // Import LoginScreen

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> _onboardingData = [
    {
      "image": "assets/images/pub-1.jpg",
      "title": "Devenez propriétaire en toute simplicité",
      "description":
          "GbatCar transforme votre projet de mobilité en réalité grâce à nos solutions de leasing adaptées.",
      "color": "rose",
    },
    {
      "image": "assets/images/pub-2.jpg",
      "title": "Un leasing conçu pour votre réussite",
      "description":
          "Accédez à votre véhicule dès aujourd'hui et payez à votre rythme pour devenir propriétaire demain.",
      "color": "blue",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: PageView.builder(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentPage = index;
          });
        },
        itemCount: _onboardingData.length,
        itemBuilder: (context, index) {
          return _buildPage(_onboardingData[index], index);
        },
      ),
    );
  }

  Widget _buildPage(Map<String, String> data, int index) {
    final Color bgColor =
        index == 0 ? AppColors.brandRose : AppColors.brandBlue;

    return Stack(
      children: [
        // 1. Background Color (Comme avant)
        Container(
          color: bgColor,
          height: MediaQuery.of(context).size.height * 0.70,
        ),
        // 2. Image (Comme avant, posée sur la carte)
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          height: MediaQuery.of(context).size.height * 0.65,
          child: SafeArea(
            child:  Image.asset(
              data["image"]!,
              fit: BoxFit.cover,
              alignment: Alignment.bottomCenter,
            ),
          ),
        ),
        // 3. White Card (Harmonisée et flexible)
        Positioned(
          bottom: 30,
          left: 0,
          right: 0,
          child: Container(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height * 0.35,
            ),
            padding: const EdgeInsets.fromLTRB(30, 25, 30, 15),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Indicators
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    _onboardingData.length,
                    (idx) => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: _currentPage == idx ? 24 : 12,
                      height: 4,
                      decoration: BoxDecoration(
                        color: _currentPage == idx
                            ? AppColors.brandBlue
                            : Colors.grey[300],
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                // Title
                Text(
                  data["title"]!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: AppColors.brandBlue,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 15),
                // Description
                Text(
                  data["description"]!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Color(0xFF9098B1),
                    fontSize: 15,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 30),
                // Button
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_currentPage < _onboardingData.length - 1) {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeIn,
                        );
                      } else {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.brandBlue,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Text(
                      _currentPage == 0 ? "Commencer" : "Continuer",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
