import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../shared/constants/app_colors.dart';

class AddressIdentityScreen extends StatefulWidget {
  const AddressIdentityScreen({super.key});

  @override
  State<AddressIdentityScreen> createState() => _AddressIdentityScreenState();
}

class _AddressIdentityScreenState extends State<AddressIdentityScreen> {
  final TextEditingController _paysController = TextEditingController(text: "Cote d'Ivoire");
  final TextEditingController _lieuNaissanceController = TextEditingController();
  final TextEditingController _villeController = TextEditingController();
  final TextEditingController _quartierController = TextEditingController();
  final TextEditingController _cniController = TextEditingController();
  final TextEditingController _dateEmissionController = TextEditingController();

  final List<Map<String, String>> _countries = [
    {'name': "Cote d'Ivoire", 'emoji': "🇨🇮"},
    {'name': "United Arab Emirates", 'emoji': "🇦🇪"},
    {'name': "Chile", 'emoji': "🇨🇱"},
    {'name': "Morocco", 'emoji': "🇲🇦"},
    {'name': "Congo", 'emoji': "🇨🇬"},
  ];
  
  List<Map<String, String>> _filteredCountries = [];
  
  @override
  void initState() {
    super.initState();
    _filteredCountries = List.from(_countries);
  }

  void _filterCountries(String query, void Function(void Function()) setModalState) {
    if (query.isEmpty) {
      setModalState(() {
        _filteredCountries = List.from(_countries);
      });
    } else {
      setModalState(() {
        _filteredCountries = _countries
            .where((country) => country['name']!.toLowerCase().contains(query.toLowerCase()))
            .toList();
      });
    }
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primaryNavy,
              onPrimary: Colors.white,
              onSurface: AppColors.primaryNavy,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: AppColors.primaryNavy,
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _dateEmissionController.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

  void _showCountryPicker() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.75,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                ),
                child: Column(
                children: [
                  const SizedBox(height: 12),
                  Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    "Sélectionnez votre pays",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primaryNavy,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8FAFC),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TextField(
                        onChanged: (value) => _filterCountries(value, setModalState),
                        decoration: const InputDecoration(
                          hintText: "Rechercher",
                          hintStyle: TextStyle(
                            color: Color(0xFF94A3B8),
                            fontWeight: FontWeight.w500,
                          ),
                          prefixIcon: null, // As per screenshot, icon is on the right
                          suffixIcon: Icon(Icons.search, color: Color(0xFF94A3B8)),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      itemCount: _filteredCountries.length,
                      separatorBuilder: (context, index) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final country = _filteredCountries[index];
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _paysController.text = country['name']!;
                            });
                            // Reset filter for next time
                            _filteredCountries = List.from(_countries);
                            Navigator.pop(context);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF8FAFC),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Row(
                              children: [
                                // Rounded rectangle flag representation
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(4),
                                  child: Container(
                                    width: 32,
                                    height: 24,
                                    color: Colors.white,
                                    alignment: Alignment.center,
                                    child: Text(
                                      country['emoji']!,
                                      style: const TextStyle(fontSize: 24),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Text(
                                  country['name']!,
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
                      },
                    ),
                  ),
                  const SizedBox(height: 24),
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
  void dispose() {
    _paysController.dispose();
    _lieuNaissanceController.dispose();
    _villeController.dispose();
    _quartierController.dispose();
    _cniController.dispose();
    _dateEmissionController.dispose();
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
          "Votre identité et votre adresse",
          style: TextStyle(
            color: Color(0xFF5A6B87), // Muted dark blue
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
                child: Column(
                  children: [
                    _buildCustomTextField(
                      label: "Pays de nationalité",
                      controller: _paysController,
                      readOnly: true, // Assuming this is fixed or selected from a modal later
                      onTap: _showCountryPicker,
                    ),
                    const SizedBox(height: 16),
                    _buildCustomTextField(
                      label: "Lieu de naissance",
                      hint: "Saisissez votre lieu de naissa...",
                      controller: _lieuNaissanceController,
                    ),
                    const SizedBox(height: 16),
                    _buildCustomTextField(
                      label: "Ville de résidence",
                      hint: "Saisissez votre ville",
                      controller: _villeController,
                    ),
                    const SizedBox(height: 16),
                    _buildCustomTextField(
                      label: "Quartier de résidence",
                      hint: "Saisissez votre quartier",
                      controller: _quartierController,
                    ),
                    const SizedBox(height: 16),
                    _buildCustomTextField(
                      label: "Numéro de carte d'identité",
                      hint: "Saisissez le numéro ici",
                      controller: _cniController,
                    ),
                    const SizedBox(height: 16),
                    _buildCustomTextField(
                      label: "Date d'émission de la carte d'identité",
                      hint: "JJ/MM/AAAA",
                      controller: _dateEmissionController,
                      readOnly: true,
                      onTap: _selectDate,
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    // TODO: Implement save logic
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF1F5F9), // Light greyish background for disabled state in the screenshot
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
                      color: AppColors.primaryNavy,
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

  Widget _buildCustomTextField({
    required String label,
    String? hint,
    required TextEditingController controller,
    bool readOnly = false,
    VoidCallback? onTap,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC), // Light grey/blue background
        borderRadius: BorderRadius.circular(16), // Rounded edges
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF5A6B87), // Muted dark blue
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          TextField(
            controller: controller,
            readOnly: readOnly,
            onTap: onTap,
            style: const TextStyle(
              fontSize: 16,
              color: AppColors.primaryNavy,
              fontWeight: FontWeight.w600,
            ),
            decoration: InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.zero,
              border: InputBorder.none,
              hintText: hint,
              hintStyle: const TextStyle(
                fontSize: 16,
                color: Color(0xFF94A3B8), // Slate 400
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
