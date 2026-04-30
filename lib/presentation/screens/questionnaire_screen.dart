import 'package:flutter/material.dart';
import '../../shared/constants/app_colors.dart';

class QuestionnaireScreen extends StatefulWidget {
  final String clientType;
  const QuestionnaireScreen({super.key, required this.clientType});

  @override
  State<QuestionnaireScreen> createState() => _QuestionnaireScreenState();
}

class _QuestionnaireScreenState extends State<QuestionnaireScreen> {
  int _currentStep = 1; 
  final int _totalSteps = 12; // Ajusté pour retirer le téléchargement de documents

  // -- States --
  String? _maritalStatus;
  int _childrenCount = 0;
  String? _educationLevel;
  String? _discoverySource;
  String? _profession;
  String? _incomeBracket;
  bool? _hasFriendsInCompany;
  final TextEditingController _friendNameController = TextEditingController();
  String? _mainBank;
  int _yearsOfExperience = 0;
  String? _housingStatus;
  bool? _hasPreviousCredit;
  String? _fundingSource;



  void _nextStep() {
    if (_currentStep < _totalSteps) {
      setState(() => _currentStep++);
    } else {
      Navigator.pop(context);
    }
  }

  void _prevStep() {
    if (_currentStep > 1) {
      setState(() => _currentStep--);
    } else {
      Navigator.pop(context);
    }
  }

  bool _canContinue() {
    if (_currentStep == 1) return _maritalStatus != null;
    if (_currentStep == 3) return _educationLevel != null;
    if (_currentStep == 4) return _discoverySource != null;
    if (_currentStep == 5) return _profession != null;
    if (_currentStep == 6) return _incomeBracket != null;
    if (_currentStep == 7) return _hasFriendsInCompany != null;
    if (_currentStep == 8) return _mainBank != null;
    return true; 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primaryNavy),
          onPressed: _prevStep,
        ),
        title: Row(
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(_totalSteps, (index) {
                  bool isActive = index < _currentStep;
                  return Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 2),
                      height: 3,
                      decoration: BoxDecoration(
                        color: isActive ? AppColors.primaryNavy : const Color(0xFFE2E8F0),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  );
                }),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              "$_currentStep/$_totalSteps",
              style: const TextStyle(
                color: AppColors.primaryNavy,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                child: _buildCurrentStepContent(),
              ),
            ),
            _buildBottomButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrentStepContent() {
    switch (_currentStep) {
      case 1: return _buildMaritalStatusStep();
      case 2: return _buildChildrenCounterStep();
      case 3: return _buildEducationDropdownStep();
      case 4: return _buildDiscoverySourceStep();
      case 5: return _buildGenericDropdownStep(
          title: "Quelle est votre profession\nprincipale actuelle ?",
          currentValue: _profession,
          options: ["Salarié(e) privé(e)", "Fonctionnaire", "Indépendant(e) / Commerçant(e)", "Chauffeur VTC", "Autre"],
          onSelected: (val) => setState(() => _profession = val),
        );
      case 6: return _buildGenericDropdownStep(
          title: "Quelle est votre tranche de\nrevenus mensuels ?",
          currentValue: _incomeBracket,
          options: ["Moins de 200 000 FCFA", "Entre 200 000 et 500 000 FCFA", "Plus de 500 000 FCFA"],
          onSelected: (val) => setState(() => _incomeBracket = val),
        );
      case 7: return _buildFriendsInCompanyStep();
      case 8: return _buildGenericDropdownStep(
          title: "Quel compte bancaire utilisez-vous\nle plus régulièrement ?",
          currentValue: _mainBank,
          options: ["Ecobank", "SGCI", "NSIA", "Orange Money", "Wave", "Autre / Non bancarisé"],
          onSelected: (val) => setState(() => _mainBank = val),
        );
      case 9: return _buildExperienceCounterStep();
      case 10: return _buildRadioGroupStep(
          title: "Êtes-vous locataire ou\npropriétaire de votre logement\nactuel ?",
          currentValue: _housingStatus,
          options: ["Locataire", "Propriétaire", "Hébergé(e)"],
          onChanged: (val) => setState(() => _housingStatus = val),
        );
      case 11: return _buildRadioGroupStep(
          title: "Avez-vous déjà souscrit à une\nlocation-vente ou un crédit\nautomobile par le passé ?",
          currentValue: _hasPreviousCredit == null ? null : (_hasPreviousCredit! ? "Oui" : "Non"),
          options: ["Oui", "Non"],
          onChanged: (val) => setState(() => _hasPreviousCredit = (val == "Oui")),
        );
      case 12: return _buildGenericDropdownStep(
          title: "D'où proviendra la source principale\nde remboursement du véhicule ?",
          currentValue: _fundingSource,
          options: ["Mon salaire fixe", "Les recettes VTC du véhicule", "Les revenus de mon entreprise", "Autre"],
          onSelected: (val) => setState(() => _fundingSource = val),
        );
      default: return const SizedBox();
    }
  }

  // Document upload step has been moved to AddressIdentityScreen.

  Widget _buildStepDropdown({required String label, String? value, required List<String> options, required Function(String?) onChanged, String? hint}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.primaryNavy)),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: const Color(0xFFF8FAFC),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              isExpanded: true,
              value: value,
              hint: Text(hint ?? "Sélectionner", style: const TextStyle(fontSize: 14, color: Color(0xFF94A3B8))),
              items: options.map((e) => DropdownMenuItem(value: e, child: Text(e, style: const TextStyle(fontSize: 14)))).toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStepInputField({required String label, required TextEditingController controller, required String hintText, TextInputType? keyboardType}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.primaryNavy)),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: const Color(0xFFF8FAFC),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            style: const TextStyle(fontSize: 14, color: AppColors.primaryNavy),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hintText,
              hintStyle: const TextStyle(color: Color(0xFF94A3B8), fontSize: 14),
              contentPadding: const EdgeInsets.symmetric(vertical: 14),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMaritalStatusStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          "Quel est votre statut matrimonial ?",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryNavy,
          ),
        ),
        const SizedBox(height: 32),
        GestureDetector(
          onTap: _showMaritalStatusPicker,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Cliquez pour sélectionner",
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF64748B), // Slate 500
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _maritalStatus ?? "Sélectionner",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: _maritalStatus == null 
                        ? const Color(0xFF94A3B8) // Slate 400
                        : AppColors.primaryNavy,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _showMaritalStatusPicker() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Drag handle
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              ...["Célibataire", "Marié(e)", "Divorcé(e)", "Veuf(ve)"]
                  .map((status) => StatefulBuilder(
                        builder: (context, setModalState) {
                          return InkWell(
                            onTap: () {
                              setState(() {
                                _maritalStatus = status;
                              });
                              Navigator.pop(context);
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                              child: Row(
                                children: [
                                  Icon(
                                    _maritalStatus == status ? Icons.radio_button_checked : Icons.radio_button_off,
                                    color: _maritalStatus == status ? AppColors.primaryNavy : Colors.grey[700],
                                    size: 24,
                                  ),
                                  const SizedBox(width: 20),
                                  Text(
                                    status, 
                                    style: const TextStyle(
                                      fontSize: 16, 
                                      color: AppColors.primaryNavy,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                      )),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  Widget _buildChildrenCounterStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Avez-vous des enfants ? Si oui,\nprécisez le nombre?",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryNavy,
            height: 1.3,
          ),
        ),
        const SizedBox(height: 48),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildCounterButton(Icons.remove, () {
              if (_childrenCount > 0) {
                setState(() => _childrenCount--);
              }
            }),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Text(
                "$_childrenCount",
                style: const TextStyle(
                  fontSize: 56, 
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryNavy,
                ),
              ),
            ),
            _buildCounterButton(Icons.add, () {
              setState(() => _childrenCount++);
            }),
          ],
        )
      ],
    );
  }

  Widget _buildCounterButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 64,
        height: 64,
        decoration: const BoxDecoration(
          color: Color(0xFFF8FAFC),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: AppColors.primaryNavy, size: 28),
      ),
    );
  }

  Widget _buildEducationDropdownStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          "Quel est votre niveau d'étude ?",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryNavy,
          ),
        ),
        const SizedBox(height: 32),
        GestureDetector(
          onTap: _showEducationPicker,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Cliquez pour sélectionner",
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF64748B), // Slate 500
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _educationLevel ?? "Sélectionner",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: _educationLevel == null 
                        ? const Color(0xFF94A3B8) // Slate 400
                        : AppColors.primaryNavy,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _showEducationPicker() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Drag handle
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              ...["Aucun", "Primaire", "Secondaire", "Universitaire", "Professionnel"]
                  .map((level) => StatefulBuilder(
                        builder: (context, setModalState) {
                          return InkWell(
                            onTap: () {
                              setState(() {
                                _educationLevel = level;
                              });
                              Navigator.pop(context);
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                              child: Row(
                                children: [
                                  Icon(
                                    _educationLevel == level ? Icons.radio_button_checked : Icons.radio_button_off,
                                    color: _educationLevel == level ? AppColors.primaryNavy : Colors.grey[700],
                                    size: 24,
                                  ),
                                  const SizedBox(width: 20),
                                  Text(
                                    level, 
                                    style: const TextStyle(
                                      fontSize: 16, 
                                      color: AppColors.primaryNavy,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                      )),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDiscoverySourceStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          "Comment avez-vous connu la\nsociété GBATCAR?",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryNavy,
            height: 1.3,
          ),
        ),
        const SizedBox(height: 32),
        GestureDetector(
          onTap: _showDiscoverySourcePicker,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Cliquez pour sélectionner",
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF64748B), // Slate 500
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _discoverySource ?? "Sélectionner",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: _discoverySource == null 
                        ? const Color(0xFF94A3B8) // Slate 400
                        : AppColors.primaryNavy,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _showDiscoverySourcePicker() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Drag handle
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              ...[
                "Bouche à Oreille",
                "Facebook",
                "WhatsApp",
                "LinkedIn",
                "Google",
                "Bureau GbatCar"
              ].map((source) => StatefulBuilder(
                builder: (context, setModalState) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        _discoverySource = source;
                      });
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                      child: Row(
                        children: [
                          Icon(
                            _discoverySource == source ? Icons.radio_button_checked : Icons.radio_button_off,
                            color: _discoverySource == source ? AppColors.primaryNavy : Colors.grey[700],
                            size: 24,
                          ),
                          const SizedBox(width: 20),
                          Text(
                            source, 
                            style: const TextStyle(
                              fontSize: 16, 
                              color: AppColors.primaryNavy,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
              )),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFriendsInCompanyStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Avez-vous des amis ou des\nconnaissances qui travaillent déjà\navec GBATCAR?",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryNavy,
            height: 1.3,
          ),
        ),
        const SizedBox(height: 32),
        _buildRadioOptionTile(
          title: "Oui",
          isSelected: _hasFriendsInCompany == true,
          onTap: () {
            setState(() {
              _hasFriendsInCompany = true;
            });
          },
        ),
        const SizedBox(height: 16),
        _buildRadioOptionTile(
          title: "Non",
          isSelected: _hasFriendsInCompany == false,
          onTap: () {
            setState(() {
              _hasFriendsInCompany = false;
              _friendNameController.clear(); // Clear if they switch to No
            });
          },
        ),
        if (_hasFriendsInCompany == true) ...[
          const SizedBox(height: 32),
          const Text(
            "Si oui, précisez son nom (Optionnel)",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryNavy,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(12),
            ),
            child: TextField(
              controller: _friendNameController,
              decoration: const InputDecoration(
                hintText: "Nom de votre connaissance",
                hintStyle: TextStyle(
                  color: Color(0xFF94A3B8),
                  fontSize: 16,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              ),
              style: const TextStyle(
                color: AppColors.primaryNavy,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildRadioOptionTile({
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: const Color(0xFFF8FAFC),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColors.primaryNavy.withValues(alpha: 255 * 0.3) : Colors.transparent,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: isSelected ? AppColors.primaryNavy : Colors.grey[600],
              size: 24,
            ),
            const SizedBox(width: 16),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppColors.primaryNavy,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExperienceCounterStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Depuis combien d'années\navez-vous votre permis de\nconduire (ou d'expérience de\nconduite) ?",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryNavy,
            height: 1.3,
          ),
        ),
        const SizedBox(height: 48),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildCounterButton(Icons.remove, () {
              if (_yearsOfExperience > 0) {
                setState(() => _yearsOfExperience--);
              }
            }),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Text(
                "$_yearsOfExperience",
                style: const TextStyle(
                  fontSize: 56, 
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryNavy,
                ),
              ),
            ),
            _buildCounterButton(Icons.add, () {
              setState(() => _yearsOfExperience++);
            }),
          ],
        )
      ],
    );
  }

  Widget _buildBottomButtons() {
    bool isEnabled = _canContinue();
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: _prevStep,
              child: Container(
                height: 52,
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Text(
                    "Retour",
                    style: TextStyle(
                      color: AppColors.primaryNavy,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: GestureDetector(
              onTap: isEnabled ? _nextStep : null,
              child: Container(
                height: 52,
                decoration: BoxDecoration(
                  color: isEnabled ? AppColors.primaryNavy : const Color(0xFFF1F5F9), 
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    "Continuer",
                    style: TextStyle(
                      color: isEnabled ? Colors.white : const Color(0xFF94A3B8), 
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- REUSABLE BUILD WIDGETS ---

  Widget _buildGenericDropdownStep({
    required String title,
    required String? currentValue,
    required List<String> options,
    required ValueChanged<String> onSelected,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryNavy,
            height: 1.3,
          ),
        ),
        const SizedBox(height: 32),
        GestureDetector(
          onTap: () {
            _showGenericPicker(
              title: title.replaceAll('\n', ' '), // Clean up title for the sheet
              currentValue: currentValue,
              options: options,
              onSelected: onSelected,
            );
          },
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Cliquez pour sélectionner",
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF64748B), // Slate 500
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  currentValue ?? "Sélectionner",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: currentValue == null 
                        ? const Color(0xFF94A3B8) // Slate 400
                        : AppColors.primaryNavy,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _showGenericPicker({
    required String title,
    required String? currentValue,
    required List<String> options,
    required ValueChanged<String> onSelected,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Drag handle
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              ...options.map((option) => StatefulBuilder(
                    builder: (context, setModalState) {
                      return InkWell(
                        onTap: () {
                          onSelected(option);
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                          child: Row(
                            children: [
                              Icon(
                                currentValue == option ? Icons.radio_button_checked : Icons.radio_button_off,
                                color: currentValue == option ? AppColors.primaryNavy : Colors.grey[700],
                                size: 24,
                              ),
                              const SizedBox(width: 20),
                              Expanded(
                                child: Text(
                                  option, 
                                  style: const TextStyle(
                                    fontSize: 16, 
                                    color: AppColors.primaryNavy,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  )),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  Widget _buildRadioGroupStep({
    required String title,
    required String? currentValue,
    required List<String> options,
    required ValueChanged<String> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryNavy,
            height: 1.3,
          ),
        ),
        const SizedBox(height: 32),
        ...options.map((option) {
          final bool isSelected = currentValue == option;
          return Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: _buildRadioOptionTile(
              title: option,
              isSelected: isSelected,
              onTap: () => onChanged(option),
            ),
          );
        }),
      ],
    );
  }
}
