import 'package:flutter/material.dart';
import '../../shared/constants/app_colors.dart';

class VehicleLeasingScreen extends StatefulWidget {
  final String clientType;
  const VehicleLeasingScreen({super.key, required this.clientType});

  @override
  State<VehicleLeasingScreen> createState() => _VehicleLeasingScreenState();
}

class _VehicleLeasingScreenState extends State<VehicleLeasingScreen> {
  String? _vehicleBrand;
  String? _vehicleModel;
  final TextEditingController _vehicleCountController = TextEditingController(text: "1");
  String? _leaseContractType;
  String? _paymentMode;

  @override
  void dispose() {
    _vehicleCountController.dispose();
    super.dispose();
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
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Véhicule et Leasing",
          style: TextStyle(
            color: Color(0xFF5A6B87),
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
                child: _buildForm(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryNavy,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    "Continuer",
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
    );
  }

  Widget _buildForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Choisissez votre véhicule *",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.primaryNavy),
        ),
        const SizedBox(height: 24),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDropdownField(
              label: "Marque *",
              value: _vehicleBrand,
              options: ["Toyota", "Suzuki", "Hyundai", "Kia", "Autre"],
              onChanged: (val) => setState(() => _vehicleBrand = val),
            ),
            const SizedBox(height: 20),
            _buildDropdownField(
              label: "Modèle *",
              value: _vehicleModel,
              options: ["Starlet", "Dzire", "Accent", "Rio", "Autre"],
              onChanged: (val) => setState(() => _vehicleModel = val),
            ),
          ],
        ),
        const SizedBox(height: 20),
        _buildInputField(
          label: "Nombre de véhicules *",
          controller: _vehicleCountController,
          hintText: "1",
        ),
        
        const SizedBox(height: 48), // Espace comme sur la maquette
        
        const Text(
          "Condition de leasing *",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.primaryNavy),
        ),
        const SizedBox(height: 24),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Type de contrat *", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF334155))),
            const SizedBox(height: 12),
            ...["Location à longue durée", "Location à courte durée", "Location avec option d'achat", "Partenariat"].map((type) {
              return SizedBox(
                height: 40,
                child: RadioListTile<String>(
                  title: Text(type, style: const TextStyle(fontSize: 13)),
                  value: type,
                  groupValue: _leaseContractType,
                  activeColor: const Color(0xFF334155), // Amber
                  contentPadding: EdgeInsets.zero,
                  onChanged: (val) => setState(() => _leaseContractType = val),
                ),
              );
            }).toList(),
            const SizedBox(height: 24),
            _buildDropdownField(
              label: "Mode paiement *",
              value: _paymentMode,
              options: ["Hebdomadaire", "Mensuel"],
              onChanged: (val) => setState(() => _paymentMode = val),
              hint: "Sélectionnez votre mode de paiement",
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    required String hintText,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: label.replaceAll(" *", ""),
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Color(0xFF334155),
            ),
            children: const [
              TextSpan(
                text: " *",
                style: TextStyle(color: Colors.red),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: const Color(0xFFF8FAFC),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: TextField(
            controller: controller,
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

  Widget _buildDropdownField({required String label, String? value, required List<String> options, required Function(String?) onChanged, String? hint}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: label.replaceAll(" *", ""),
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Color(0xFF334155),
            ),
            children: [
              if (label.contains(" *"))
                const TextSpan(
                  text: " *",
                  style: TextStyle(color: Colors.red),
                ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: const Color(0xFFF8FAFC),
            borderRadius: BorderRadius.circular(8),
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
}
