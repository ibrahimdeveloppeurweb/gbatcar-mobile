import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../shared/constants/app_colors.dart';
import '../layouts/main_layout.dart'; // For Dashboard navigation
import 'onboarding_steps_screen.dart'; // New onboarding screen

class PersonalInfoScreen extends StatefulWidget {
  const PersonalInfoScreen({super.key});

  @override
  State<PersonalInfoScreen> createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends State<PersonalInfoScreen> {
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _prenomController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _genreController = TextEditingController();

  @override
  void dispose() {
    _nomController.dispose();
    _prenomController.dispose();
    _dateController.dispose();
    _genreController.dispose();
    super.dispose();
  }

  void _onCommencerPressed() {
    // Navigate to onboarding steps
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const OnboardingStepsScreen()),
    );
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2008, 2, 28),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primaryNavy, // header background color
              onPrimary: Colors.white, // header text color
              onSurface: AppColors.primaryNavy, // body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: AppColors.primaryNavy, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _dateController.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

  void _selectGenre() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 40,
                      height: 4,
                      margin: const EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                        color: Colors.grey[400],
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    RadioListTile<String>(
                      title: const Text('Homme'),
                      value: 'Homme',
                      groupValue: _genreController.text.isNotEmpty ? _genreController.text : null,
                      activeColor: AppColors.primaryNavy,
                      onChanged: (String? value) {
                        setModalState(() {
                          _genreController.text = value!;
                        });
                        setState(() {});
                        Future.delayed(const Duration(milliseconds: 200), () {
                          if (mounted) Navigator.pop(context);
                        });
                      },
                    ),
                    RadioListTile<String>(
                      title: const Text('Femme'),
                      value: 'Femme',
                      groupValue: _genreController.text.isNotEmpty ? _genreController.text : null,
                      activeColor: AppColors.primaryNavy,
                      onChanged: (String? value) {
                        setModalState(() {
                          _genreController.text = value!;
                        });
                        setState(() {});
                        Future.delayed(const Duration(milliseconds: 200), () {
                          if (mounted) Navigator.pop(context);
                        });
                      },
                    ),
                  ],
                ),
              ),
            );
          }
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
        centerTitle: true,
        title: const Text(
          "CRÉEZ UN COMPTE GBATCAR",
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Color(0xFF8A98A8), // Greyish color
            letterSpacing: 1.0,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Text(
                "Complétez vos\ninformations\npersonnelles",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  color: AppColors.primaryNavy,
                  height: 1.2, // Line height
                ),
              ),
              const SizedBox(height: 30),
              
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildInfoField(
                        label: "Nom", 
                        controller: _nomController, 
                        hintText: "Saisissez votre nom",
                      ),
                      const SizedBox(height: 20),
                      _buildInfoField(
                        label: "Prénom", 
                        controller: _prenomController, 
                        hintText: "Saisissez votre prénom",
                      ),
                      const SizedBox(height: 20),
                      _buildInfoField(
                        label: "Date de naissance", 
                        controller: _dateController, 
                        hintText: "JJ/MM/AAAA",
                        onTap: _selectDate,
                      ),
                      const SizedBox(height: 20),
                      _buildInfoField(
                        label: "Genre", 
                        controller: _genreController, 
                        hintText: "Cliquez pour sélectionner",
                        onTap: _selectGenre,
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),

              // Commencer Button
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: _onCommencerPressed,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2C4472), // Dark blue from the image
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      "Commencer",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoField({
    required String label, 
    required TextEditingController controller,
    required String hintText,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: const Color(0xFFF7F9FC), // Very light grayish blue
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 13,
                color: Color(0xFF5A6B87), // Slightly dark gray-blue
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            TextField(
              controller: controller,
              readOnly: onTap != null,
              onTap: onTap,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryNavy,
              ),
              decoration: InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.zero,
                border: InputBorder.none,
                hintText: hintText,
                hintStyle: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF94A3B8), // Placeholder gray
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
