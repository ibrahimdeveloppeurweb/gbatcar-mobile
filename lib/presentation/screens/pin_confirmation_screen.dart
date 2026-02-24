import 'package:flutter/material.dart';
import '../../shared/constants/app_colors.dart';
import 'personal_info_screen.dart';

class PinConfirmationScreen extends StatefulWidget {
  final String correctPin;

  const PinConfirmationScreen({super.key, required this.correctPin});

  @override
  State<PinConfirmationScreen> createState() => _PinConfirmationScreenState();
}

class _PinConfirmationScreenState extends State<PinConfirmationScreen> {
  final TextEditingController _pinController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    // Auto-focus the hidden field to show keyboard immediately
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _pinController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onPinChanged(String value) {
    if (_hasError) {
      setState(() {
        _hasError = false;
      });
    } else {
      setState(() {}); // Rebuild to update dots
    }

    if (value.length == 4) {
      FocusScope.of(context).unfocus();
      if (value == widget.correctPin) {
        // PIN matches -> Success
        Future.delayed(const Duration(milliseconds: 300), () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const PersonalInfoScreen()),
            (route) => false,
          );
        });
      } else {
        // PIN doesn't match -> Error
        setState(() {
          _hasError = true;
          _pinController.clear();
        });
        
        // Request focus again to retry
        Future.delayed(const Duration(milliseconds: 500), () {
          _focusNode.requestFocus();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primaryNavy),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const Text(
              "Confirmez votre PIN",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryNavy,
              ),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                _hasError ? "Les codes PIN ne correspondent pas. Veuillez réessayer." : "Veuillez saisir à nouveau votre code PIN pour confirmer",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: _hasError ? Colors.red : const Color(0xFFB0BAC9),
                  height: 1.4,
                ),
              ),
            ),
            const SizedBox(height: 50),
            // Dots Visualization
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(4, (index) {
                bool isFilled = index < _pinController.text.length;
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _hasError 
                        ? Colors.red 
                        : (isFilled ? AppColors.brandBlue : const Color(0xFFE2E8F0)),
                  ),
                );
              }),
            ),
            // Hidden TextField for input
            Opacity(
              opacity: 0,
              child: TextField(
                controller: _pinController,
                focusNode: _focusNode,
                keyboardType: TextInputType.number,
                maxLength: 4,
                onChanged: _onPinChanged,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
