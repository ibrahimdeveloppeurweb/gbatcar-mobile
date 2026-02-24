import 'package:flutter/material.dart';
import '../../../shared/constants/app_colors.dart';

class DepositScreen extends StatefulWidget {
  const DepositScreen({super.key});

  @override
  State<DepositScreen> createState() => _DepositScreenState();
}

class _DepositScreenState extends State<DepositScreen> {
  final TextEditingController _amountController = TextEditingController();
  String _selectedMethod = 'wave'; // Default method

  final List<int> _quickAmounts = [1000, 2000, 5000, 10000];

  void _selectAmount(int amount) {
    _amountController.text = amount.toString();
  }

  void _showPaymentMethodSelector() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
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
              const Text(
                "Choisir la méthode de dépôt",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryNavy,
                ),
              ),
              const SizedBox(height: 20),
              _buildMethodOption(
                id: 'wave',
                name: 'Wave',
                assetPath: 'assets/images/wave.png', // User provided image name
              ),
              const SizedBox(height: 10),
              _buildMethodOption(
                id: 'orange',
                name: 'Orange Money',
                assetPath:
                    'assets/images/orange-money.png', // User provided image name
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMethodOption({
    required String id,
    required String name,
    required String assetPath,
  }) {
    final isSelected = _selectedMethod == id;

    return ListTile(
      onTap: () {
        setState(() => _selectedMethod = id);
        Navigator.pop(context);
      },
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: AssetImage(assetPath),
            fit: BoxFit.cover,
          ),
          // Fallback color if image missing
          color:
              id == 'wave' ? const Color(0xFF00BBFF) : const Color(0xFFFF7900),
        ),
        // Child to handle missing image gracefully if needed, but BoxDecoration handles background
      ),
      title: Text(
        name,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: AppColors.primaryNavy,
        ),
      ),
      trailing: isSelected
          ? const Icon(Icons.check_circle, color: AppColors.success)
          : const Icon(Icons.circle_outlined, color: Colors.grey),
      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: isSelected
            ? const BorderSide(color: AppColors.success, width: 2)
            : BorderSide.none,
      ),
      tileColor: isSelected ? AppColors.success.withOpacity(0.1) : null,
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
          "DÉPÔT",
          style: TextStyle(
              color: AppColors.primaryNavy, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primaryNavy),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User info card placeholder (simulating capture)
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: const Color(0xFFF7F9FC),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    backgroundColor: AppColors.brandBlue,
                    child: Icon(Icons.water_drop,
                        color: Colors.white), // Logo placeholder
                  ),
                  const SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Numéro de téléphone",
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      const Text(
                        "+225 05 56 98 70 00",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryNavy,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 30),

            const Text(
              "Montant à déposer",
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryNavy,
              ),
              decoration: const InputDecoration(
                suffixText: "F CFA",
                border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: AppColors.primaryNavy, width: 2),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Chips
            Wrap(
              spacing: 10,
              children: _quickAmounts.map((amount) {
                return ActionChip(
                  label: Text("${amount} F"),
                  backgroundColor: Colors.transparent,
                  shape: const StadiumBorder(
                    side: BorderSide(color: Colors.grey),
                  ),
                  onPressed: () => _selectAmount(amount),
                );
              }).toList(),
            ),

            const SizedBox(height: 40),

            // Method Selector Trigger
            const Text(
              "Méthode de paiement",
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: _showPaymentMethodSelector,
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    // Selected Method Icon
                    Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        //  color: _selectedMethod == 'wave' ? const Color(0xFF00BBFF) : const Color(0xFFFF7900),
                        image: DecorationImage(
                          image: AssetImage(
                              'assets/images/${_selectedMethod == 'wave' ? 'wave.png' : 'orange-money.png'}'), // Use images
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Text(
                      _selectedMethod == 'wave' ? 'Wave' : 'Orange Money',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryNavy,
                        fontSize: 16,
                      ),
                    ),
                    const Spacer(),
                    const Icon(Icons.arrow_drop_down,
                        color: AppColors.primaryNavy),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 50),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  // Process Deposit
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryNavy,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: const Text(
                  "Confirmer le dépôt",
                  style: TextStyle(
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
    );
  }
}
