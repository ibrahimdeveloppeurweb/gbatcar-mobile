import 'package:flutter/material.dart';
import 'package:project/shared/constants/app_colors.dart';

class VehicleScreen extends StatelessWidget {
  const VehicleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Background bi-colore (Overscroll)
          Column(
            children: [
              Expanded(flex: 1, child: Container(color: Colors.white)),
              Expanded(
                  flex: 2, child: Container(color: const Color(0xFFF8F9FA))),
            ],
          ),
          CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              _buildAppBar(),
              SliverToBoxAdapter(
                child: Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      _buildTopVehicleCard(),
                      const SizedBox(height: 25),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFFF8F9FA),
                  ),
                  child: Column(
                    children: [
                      _buildProgressSection(),
                      const SizedBox(height: 30),
                      _buildTechnicalDetailsSection(),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  SliverAppBar _buildAppBar() {
    return SliverAppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      pinned: true,
      title: const Text(
        "MON VÉHICULE",
        style: TextStyle(
          color: AppColors.primaryNavy,
          fontSize: 18,
          fontWeight: FontWeight.w900,
          letterSpacing: 1.2,
        ),
      ),
      centerTitle: true,
    );
  }

  Widget _buildTopVehicleCard() {
    return Container(
      height: 220,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: AppColors.primaryNavy,
        borderRadius: BorderRadius.circular(30),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Image.network(
          "https://static.wixstatic.com/media/7f4bae_63e33e29b7c94590adc7bdc2e98d35ba~mv2.png/v1/fill/w_634,h_423,al_c,q_85,usm_0.66_1.00_0.01,enc_avif,quality_auto/bestunet77.png",
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return const Center(
              child:
                  Icon(Icons.directions_car, color: Colors.white54, size: 50),
            );
          },
        ),
      ),
    );
  }

  Widget _buildProgressSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "PROGRÈS VERS LA PROPRIÉTÉ",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Color(0xFF7A8999),
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 15),
          Container(
            padding: const EdgeInsets.all(25),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.02),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Mois 12 / 36",
                          style: TextStyle(
                            color: AppColors.primaryNavy,
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                            letterSpacing: -0.5,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Location-vente en cours",
                          style: TextStyle(
                            color: Color(0xFF7A8999),
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                    const Text(
                      "33%",
                      style: TextStyle(
                        color: Color(0xFFE53E3E), // Red
                        fontSize: 26,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -1,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 25),
                // Progress Bar with dots
                Stack(
                  alignment: Alignment.centerLeft,
                  children: [
                    Container(
                      height: 8,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE2E8F0),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    FractionallySizedBox(
                      widthFactor: 0.33,
                      child: Container(
                        height: 8,
                        decoration: BoxDecoration(
                          color: const Color(0xFF2EAA5B),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                    // Adding a white knob at 33% (approximate positioning using Align)
                    Align(
                      alignment: const Alignment(-0.34, 0),
                      child: Container(
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: const Color(0xFF2EAA5B), width: 3),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                // Timeline markers
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildTimelineDot("M6", true),
                    _buildTimelineDot("M12", true, isCurrent: true),
                    _buildTimelineDot("M18", false),
                    _buildTimelineDot("M24", false),
                    _buildTimelineDot("M30", false),
                    _buildTimelineDot("M36 🏁", false),
                  ],
                ),
                const SizedBox(height: 25),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3F6FB),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: RichText(
                          text: const TextSpan(
                            style: TextStyle(
                              color: AppColors.primaryNavy,
                              fontSize: 13,
                              height: 1.4,
                            ),
                            children: [
                              TextSpan(text: "Encore "),
                              TextSpan(
                                text: "24 mois",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              TextSpan(
                                  text:
                                      " de conduite prudente avant que ce véhicule ne soit à vous !"),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineDot(String label, bool isPassed,
      {bool isCurrent = false}) {
    return Column(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: isCurrent
                ? const Color(0xFFE53E3E)
                : (isPassed
                    ? const Color(0xFF2EAA5B)
                    : const Color(0xFFE2E8F0)),
            shape: BoxShape.circle,
            boxShadow: isCurrent
                ? [
                    BoxShadow(
                      color: const Color(0xFFE53E3E).withOpacity(0.4),
                      spreadRadius: 4,
                      blurRadius: 4,
                    )
                  ]
                : [],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            color: const Color(0xFF7A8999),
            fontSize: 10,
            fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  Widget _buildTechnicalDetailsSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "DÉTAILS TECHNIQUES",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Color(0xFF7A8999),
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 15),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.02),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              children: [
                _buildTechRow(
                  icon: Icons.directions_car,
                  iconBgColor: const Color(0xFFF3F6FB),
                  iconColor: AppColors.primaryNavy,
                  title: "Modèle",
                  subtitle: "Berline • 2020 • Automatique",
                  value: "Toyota Corolla",
                  valueColor: AppColors.primaryNavy,
                ),
                const Divider(
                    height: 1,
                    indent: 70,
                    endIndent: 20,
                    color: Color(0xFFF1F3F5)),
                _buildTechRow(
                  icon: Icons.pin_outlined,
                  iconBgColor: const Color(0xFFE6F4EA),
                  iconColor: const Color(0xFF2EAA5B),
                  title: "Immatriculation",
                  subtitle: "Statut: Actif",
                  value: "AB 1234 CI",
                  valueColor: const Color(0xFF2EAA5B),
                ),
                const Divider(
                    height: 1,
                    indent: 70,
                    endIndent: 20,
                    color: Color(0xFFF1F3F5)),
                _buildTechRow(
                  icon: Icons.speed_outlined,
                  iconBgColor: const Color(0xFFE8F0FE),
                  iconColor: const Color(0xFF1A73E8),
                  title: "Kilométrage",
                  subtitle: "Mis à jour aujourd'hui",
                  value: "42 500 km",
                  valueColor: AppColors.primaryNavy,
                ),
                const Divider(
                    height: 1,
                    indent: 70,
                    endIndent: 20,
                    color: Color(0xFFF1F3F5)),
                _buildTechRow(
                  icon: Icons.tire_repair,
                  iconBgColor: const Color(0xFFFFF4E5),
                  iconColor: const Color(0xFFF09819),
                  title: "État des Pneus",
                  subtitle: "Pression moyenne: 2.3 bar",
                  value: "À vérifier",
                  valueColor: const Color(0xFFF09819),
                ),
                const Divider(
                    height: 1,
                    indent: 70,
                    endIndent: 20,
                    color: Color(0xFFF1F3F5)),
                _buildTechRow(
                  icon: Icons.verified_user_outlined,
                  iconBgColor: const Color(0xFFE6F4EA),
                  iconColor: const Color(0xFF2EAA5B),
                  title: "Assurance Santé",
                  subtitle: "Expire le 31 Déc 2026",
                  value: "Active",
                  valueColor: const Color(0xFF2EAA5B),
                ),
                const Divider(
                    height: 1,
                    indent: 70,
                    endIndent: 20,
                    color: Color(0xFFF1F3F5)),
                _buildTechRow(
                  icon: Icons.receipt_long,
                  iconBgColor: const Color(0xFFFCE8E8),
                  iconColor: const Color(0xFFE53E3E),
                  title: "Vignette Automobile",
                  subtitle: "Échéance dépassée de 5 jours",
                  value: "À payer",
                  valueColor: const Color(0xFFE53E3E),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTechRow({
    required IconData icon,
    required Color iconBgColor,
    required Color iconColor,
    required String title,
    required String subtitle,
    required String value,
    required Color valueColor,
  }) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: iconBgColor,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(icon, color: iconColor, size: 24),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryNavy,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Color(0xFF7A8999),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 16,
              color: valueColor,
              letterSpacing: -0.5,
            ),
          ),
        ],
      ),
    );
  }
}
