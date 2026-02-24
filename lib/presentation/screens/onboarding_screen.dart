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
      "title": "Devenez propriétaire\nd'un véhicule",
      "description":
          "GoCab est le partenaire financier idéal pour\nles entrepreneurs de la mobilité souhaitant\nacquérir un véhicule.",
      "color": "lime", // Background color hint
    },
    {
      "image": "assets/images/pub-2.jpg",
      "title": "Boostez vos revenus\navec GoCab",
      "description":
          "Profitez de nos offres exceptionnelles et\ngérez votre activité en toute simplicité.",
      "color": "blue", // Background color hint
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemCount: _onboardingData.length,
            itemBuilder: (context, index) {
              return _buildPage(
                _onboardingData[index],
                index == 0
                    ? const Color(0xFFEAFF81)
                    : AppColors.brandBlue, // Updated to brand color
                // Lime for 1st, Navy for 2nd
              );
            },
          ),
          // Bottom controls
          Positioned(
            bottom: 40,
            left: 20,
            right: 20,
            child: Column(
              children: [
                // Indicators
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    _onboardingData.length,
                    (index) => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: _currentPage == index ? 24 : 12,
                      height: 4,
                      decoration: BoxDecoration(
                        color: _currentPage == index
                            ? AppColors.brandBlue
                            : Colors.grey[300],
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                // Button
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_currentPage < _onboardingData.length - 1) {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeIn,
                        );
                      } else {
                        // Navigate to LoginScreen
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.brandBlue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
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
        ],
      ),
    );
  }

  Widget _buildPage(Map<String, String> data, Color bgColor) {
    return Stack(
      children: [
        // Background Color
        Container(
          color: bgColor,
          height: MediaQuery.of(context).size.height *
              0.70, // Slightly more to cover overlap
        ),
        // Image background (top part)
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          height: MediaQuery.of(context).size.height *
              0.65, // Adjust height as needed
          child: Image.asset(
            data["image"]!,
            fit: BoxFit.contain, // Show full image without clipping
            alignment: Alignment
                .bottomCenter, // Align bottom so it sits on the white card
          ),
        ),
        // Content with rounded corners
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            height: MediaQuery.of(context).size.height *
                0.40, // Adjust height overlap
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
            ),
            child: Column(
              children: [
                const SizedBox(height: 10),
                Text(
                  data["title"]!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: AppColors.brandBlue,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  data["description"]!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Color(0xFF9098B1),
                    fontSize: 16,
                    height: 1.5,
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
