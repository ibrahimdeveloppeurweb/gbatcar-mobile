import 'package:flutter/material.dart';
import 'package:project/shared/constants/app_colors.dart';

class ReportProblemScreen extends StatefulWidget {
  const ReportProblemScreen({super.key});

  @override
  State<ReportProblemScreen> createState() => _ReportProblemScreenState();
}

class _ReportProblemScreenState extends State<ReportProblemScreen> {
  String? _selectedCategory;
  final TextEditingController _descriptionController = TextEditingController();

  final List<String> _categories = [
    "Problème avec le véhicule",
    "Problème de paiement",
    "Problème avec l'application",
    "Signalement d'un accident",
    "Autre"
  ];

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F9),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF4F6F9),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primaryNavy),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Signaler un problème",
          style: TextStyle(
            color: AppColors.primaryNavy,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Aidez-nous à améliorer votre expérience en nous signalant tout problème rencontré.",
                style: TextStyle(
                  color: Color(0xFF7A8999),
                  fontSize: 14,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 30),

              // Category Dropdown
              const Text(
                "Catégorie du problème*",
                style: TextStyle(
                  color: AppColors.primaryNavy,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.02),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    hint: const Text(
                      "Sélectionnez une catégorie",
                      style: TextStyle(color: Color(0xFFB0BAC9), fontSize: 14),
                    ),
                    value: _selectedCategory,
                    icon: const Icon(Icons.keyboard_arrow_down,
                        color: AppColors.primaryNavy),
                    items: _categories.map((String category) {
                      return DropdownMenuItem<String>(
                        value: category,
                        child: Text(
                          category,
                          style: const TextStyle(
                            color: AppColors.primaryNavy,
                            fontSize: 15,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedCategory = newValue;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 25),

              // Description TextField
              const Text(
                "Description détaillée*",
                style: TextStyle(
                  color: AppColors.primaryNavy,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.02),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: TextField(
                  controller: _descriptionController,
                  maxLines: 6,
                  style: const TextStyle(color: AppColors.primaryNavy),
                  decoration: InputDecoration(
                    hintText:
                        "Décrivez la situation en détail pour nous aider à comprendre le problème...",
                    hintStyle:
                        const TextStyle(color: Color(0xFFB0BAC9), fontSize: 14),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.all(15),
                  ),
                ),
              ),
              const SizedBox(height: 25),

              // Attachment Option
              const Text(
                "Pièce jointe (Optionnel)",
                style: TextStyle(
                  color: AppColors.primaryNavy,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  // Logique d'ajout de pièce jointe
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                        color: const Color(0xFFE2E8F0),
                        width: 1,
                        style: BorderStyle.solid),
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF3F6FB),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.cloud_upload_outlined,
                            color: AppColors.primaryNavy),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Appuyez pour ajouter une photo",
                        style:
                            TextStyle(color: Color(0xFF7A8999), fontSize: 13),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),

              // Submit Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Logique d'envoi du signalement
                    if (_selectedCategory != null &&
                        _descriptionController.text.isNotEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Signalement envoyé avec succès !')),
                      );
                      Navigator.pop(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text(
                                'Veuillez remplir tous les champs obligatoires.')),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        AppColors.primaryLime, // Red color for actions
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    "Envoyer le signalement",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
