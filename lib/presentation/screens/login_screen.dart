import 'package:flutter/material.dart';
import '../../shared/constants/app_colors.dart';
import 'verification_screen.dart'; // Import VerificationScreen

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _selectedCountryCode = '+225';
  String _selectedCountryFlag = '🇨🇮'; // Default flag
  final TextEditingController _phoneController = TextEditingController();

  final List<Map<String, String>> _countries = [
    {'name': 'Cote d\'Ivoire', 'code': '+225', 'flag': '🇨🇮'},
    {'name': 'Senegal', 'code': '+221', 'flag': '🇸🇳'},
    {'name': 'Mali', 'code': '+223', 'flag': '🇲🇱'},
    {'name': 'Burkina Faso', 'code': '+226', 'flag': '🇧🇫'},
    {'name': 'Ghana', 'code': '+233', 'flag': '🇬🇭'},
  ];

  void _showCountryPicker() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Sélectionnez votre pays",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryNavy,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              // Search bar placeholder
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Rechercher",
                    prefixIcon: const Icon(Icons.search, color: Colors.grey),
                    filled: true,
                    fillColor: const Color(0xFFF7F9FC),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Expanded(
                child: ListView.builder(
                  itemCount: _countries.length,
                  itemBuilder: (context, index) {
                    final country = _countries[index];
                    final isSelected = country['code'] == _selectedCountryCode;
                    return ListTile(
                      leading: Text(
                        country['flag']!,
                        style: const TextStyle(fontSize: 24),
                      ),
                      title: Text(
                        country['name']!,
                        style: const TextStyle(
                          fontSize: 16,
                          color: AppColors.primaryNavy,
                        ),
                      ),
                      trailing: isSelected
                          ? const Icon(Icons.check_circle,
                              color: AppColors.success)
                          : null,
                      onTap: () {
                        setState(() {
                          _selectedCountryCode = country['code']!;
                          _selectedCountryFlag = country['flag']!;
                        });
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Comment ça marche ?",
          style: TextStyle(color: AppColors.primaryNavy, fontSize: 16),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.language, color: AppColors.primaryNavy),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            const Text(
              "Saisissez votre numéro\nde téléphone",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryNavy,
                height: 1.3,
              ),
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                // Country Code Selector
                GestureDetector(
                  onTap: _showCountryPicker,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 15),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF7F9FC),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        // Flag placeholder
                        Text(
                          _selectedCountryFlag,
                          style: const TextStyle(fontSize: 24),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          _selectedCountryCode,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryNavy,
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Icon(Icons.arrow_drop_down,
                            color: AppColors.primaryNavy),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                // Phone Input
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF7F9FC),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "00 00 00 0000",
                        hintStyle: TextStyle(color: Color(0xFFB0BAC9)),
                      ),
                      style: const TextStyle(
                        fontSize: 16,
                        color: AppColors.primaryNavy,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
            // Validate Button
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to VerificationScreen
                  String fullNumber =
                      "$_selectedCountryCode ${_phoneController.text}";
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          VerificationScreen(phoneNumber: fullNumber),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryNavy,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  "Valider",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            RichText(
              textAlign: TextAlign.center,
              text: const TextSpan(
                style: TextStyle(color: Color(0xFFB0BAC9), fontSize: 13),
                children: [
                  TextSpan(
                      text:
                          "En saisissant votre numéro, vous acceptez notre\n"),
                  TextSpan(
                    text: "Politique de confidentialité",
                    style: TextStyle(
                      color: AppColors.primaryNavy,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
