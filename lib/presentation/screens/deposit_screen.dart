import 'package:flutter/material.dart';
import '../../shared/constants/app_colors.dart';

class DepositScreen extends StatefulWidget {
  const DepositScreen({super.key});

  @override
  State<DepositScreen> createState() => _DepositScreenState();
}

class _DepositScreenState extends State<DepositScreen> {
  final TextEditingController _amountController = TextEditingController();
  String _selectedMethod = "Wave";

  @override
  void initState() {
    super.initState();
    // Show the payment method selector immediately after the build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showPaymentMethodSelector();
    });
  }

  void _showPaymentMethodSelector() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      backgroundColor: Colors.white,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Choisir la méthode de dépôt",
                    style: TextStyle(
                      color: AppColors.primaryNavy,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildMethodItem("Wave", "assets/images/wave.png",
                      _selectedMethod == "Wave", () {
                    setModalState(() {
                      setState(() {
                        _selectedMethod = "Wave";
                      });
                    });
                    Navigator.pop(context); // Close modal
                  }),
                  const SizedBox(height: 15),
                  _buildMethodItem("Orange", "assets/images/orange-money.png",
                      _selectedMethod == "Orange", () {
                    setModalState(() {
                      setState(() {
                        _selectedMethod = "Orange";
                      });
                    });
                    Navigator.pop(context); // Close modal
                  }),
                  const SizedBox(height: 20),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildMethodItem(
      String name, String assetPath, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage(assetPath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 15),
            Text(
              name,
              style: const TextStyle(
                color: AppColors.primaryNavy,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            if (isSelected)
              const Icon(Icons.check_circle, color: Colors.green, size: 24),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String assetPath = _selectedMethod == "Wave"
        ? "assets/images/wave.png"
        : "assets/images/orange-money.png";

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
          "DÉPÔT",
          style: TextStyle(
            color: AppColors.primaryNavy,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Phone Number Input Area
            GestureDetector(
              onTap: _showPaymentMethodSelector,
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F7FA), // Light Blue/Grey
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage(assetPath),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(2),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.unfold_more,
                              size: 14, color: AppColors.primaryNavy),
                        )
                      ],
                    ),
                    const SizedBox(width: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Numéro de téléphone",
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "+225 05 56 98 70 00",
                          style: TextStyle(
                            color: AppColors.primaryNavy,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),

            // Amount Label and Fee
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "Montant à déposer",
                  style: TextStyle(color: Color(0xFF9098B1), fontSize: 14),
                ),
                Text(
                  "Frais: 0 F",
                  style: TextStyle(
                      color: AppColors.primaryNavy,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Big Amount Input
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: TextField(
                    controller: _amountController,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(
                      color: AppColors.primaryNavy,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "F",
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Quick Amount Chips
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildAmountChip("1.000 F"),
                  _buildAmountChip("2.000 F"),
                  _buildAmountChip("5.000 F"),
                  _buildAmountChip("10.000 F"),
                ],
              ),
            ),

            const Spacer(),

            // Continue Button
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(
                      0xFFEBEBF5), // Disabled/Light state as per screenshot
                  foregroundColor: AppColors.primaryNavy,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: const Text(
                  "Continuer",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildAmountChip(String label) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: ActionChip(
        label: Text(label),
        labelStyle: const TextStyle(
          color: AppColors.primaryNavy,
          fontWeight: FontWeight.bold,
        ),
        backgroundColor: const Color(0xFFF5F7FA),
        onPressed: () {
          // Logic to start editing amount or set it
          _amountController.text =
              label.replaceAll(" F", "").replaceAll(".", "");
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide.none,
        ),
      ),
    );
  }
}
