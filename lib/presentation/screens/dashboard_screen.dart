import 'package:flutter/material.dart';
import 'package:project/presentation/screens/payment_calendar_screen.dart';
import 'package:project/presentation/screens/fines_screen.dart';
import 'package:project/presentation/screens/deposit_screen.dart';
import 'package:project/presentation/screens/notifications_screen.dart';
import 'package:project/presentation/screens/settings_screen.dart';
import 'package:project/shared/constants/app_colors.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool _isBalanceVisible = true; // State for balance visibility

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(context),
      body: _buildDashboardContent(),
    );
  }

  Widget _buildDashboardContent() {
    return Stack(
      children: [
        // Fond arrière-plan bicolore pour gérer le rebond de défilement (overscroll iOS/Android)
        Column(
          children: [
            Expanded(child: Container(color: AppColors.background)),
            Expanded(child: Container(color: const Color(0xFFF8F9FA))),
          ],
        ),
        CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            // Partie supérieure : Tout est fond bleu
            SliverToBoxAdapter(
              child: Container(
                color: AppColors.background,
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    _RevealAnimation(child: _buildUserBalance()),
                    const SizedBox(height: 5),
                    _RevealAnimation(
                      delay: const Duration(milliseconds: 200),
                      child: _buildActionGrid(),
                    ),
                    const SizedBox(height: 35),
                  ],
                ),
              ),
            ),

            // Partie inférieure : Sur fond blanc avec coins arrondis en haut
            SliverToBoxAdapter(
              child: Container(
                color: AppColors.background, // Fond derrière les coins arrondis
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFFF8F9FA), // Fond très clair
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(30)),
                  ),
                  padding: const EdgeInsets.only(top: 25, bottom: 20),
                  child: Column(
                    children: [
                      _RevealAnimation(
                        delay: const Duration(milliseconds: 400),
                        child: _buildLeasingCard(),
                      ),
                      const SizedBox(height: 20),
                      _RevealAnimation(
                        delay: const Duration(milliseconds: 600),
                        child: _buildBottomStats(),
                      ),
                      const SizedBox(height: 25),
                      _buildTransactionsSection(),
                    ],
                  ),
                ),
              ),
            ),

            // S'assure de combler tout reste de l'écran avec la couleur claire
            SliverFillRemaining(
              hasScrollBody: false,
              child: Container(
                color: const Color(0xFFF8F9FA),
              ),
            ),
          ],
        ),
      ],
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.background,
      elevation: 0,
      title: Text(
        "NEHEMIE K.",
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
      centerTitle: true,
      leading: Padding(
        padding: const EdgeInsets.only(left: 20, top: 8, bottom: 8),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: IconButton(
            icon: const Icon(Icons.menu, color: Colors.white, size: 24),
            onPressed: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      const SettingsScreen(),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    const begin = Offset(1.0, 0.0);
                    const end = Offset.zero;
                    const curve = Curves.easeInOut;

                    var tween = Tween(begin: begin, end: end)
                        .chain(CurveTween(curve: curve));

                    return SlideTransition(
                      position: animation.drive(tween),
                      child: child,
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: Center(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        const NotificationsScreen(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      const begin = Offset(1.0, 0.0);
                      const end = Offset.zero;
                      const curve = Curves.easeInOut;
                      var tween = Tween(begin: begin, end: end)
                          .chain(CurveTween(curve: curve));
                      return SlideTransition(
                        position: animation.drive(tween),
                        child: child,
                      );
                    },
                  ),
                );
              },
              child: Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    const Icon(Icons.notifications,
                        color: Colors.white, size: 24),
                    Positioned(
                      right: 8,
                      top: 8,
                      child: Container(
                        padding: const EdgeInsets.all(3),
                        decoration: const BoxDecoration(
                          color: AppColors.primaryLime,
                          shape: BoxShape.circle,
                        ),
                        child: const Text(
                          "8",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTransactionsSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Transactions",
                style: const TextStyle(
                  color: AppColors.primaryNavy,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: const [
                  Text(
                    "Voir tout ",
                    style: TextStyle(
                        color: AppColors.primaryLime,
                        fontSize: 13,
                        fontWeight: FontWeight.w600),
                  ),
                  Icon(Icons.arrow_forward,
                      color: AppColors.primaryLime, size: 14),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          ...List.generate(4, (index) {
            // Afficher seulement 4 pour la démo fluide, le reste est scrollable
            if (index == 0) {
              return _RevealAnimation(
                delay: Duration(milliseconds: 800 + (index * 100)),
                child: _buildTransactionItem(
                  Icons.remove,
                  "Paiement rejeté",
                  "26 décembre, 16:21",
                  "+200 XOF",
                  Colors.red,
                  isError: true,
                  isNegative: false,
                ),
              );
            }
            bool isNegative = index % 3 == 0;
            return _RevealAnimation(
              delay: Duration(milliseconds: 800 + (index * 100)),
              child: _buildTransactionItem(
                isNegative ? Icons.remove : Icons.call_received,
                isNegative ? "Paiement de 200 F" : "Recherche passager 200 XOF",
                "24 décembre, 11:03",
                isNegative ? "-200 XOF" : "+200 XOF",
                AppColors.primaryNavy,
                isNegative: isNegative,
              ),
            );
          }),
        ],
      ),
    );
  }

  void _showTransactionDetail(
      IconData icon, String title, String date, String amount, Color iconColor,
      {bool isError = false}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.75,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Align(
                alignment: Alignment.center,
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Align(
                alignment: Alignment.center,
                child: Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF7F9FC),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Icon(icon, color: iconColor, size: 32),
                ),
              ),
              const SizedBox(height: 25),
              Align(
                alignment: Alignment.center,
                child: Text(
                  amount,
                  style: const TextStyle(
                    color: AppColors.primaryNavy,
                    fontSize: 38,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.center,
                child: Text(
                  "Dépôt de ${amount.replaceAll(' ', '')} du +2250556987000 via Wave",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: AppColors.primaryNavy,
                    fontSize: 15,
                    height: 1.4,
                  ),
                ),
              ),
              const SizedBox(height: 25),
              Align(
                alignment: Alignment.center,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8F5E9),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.check_circle,
                          color: Color(0xFF4CAF50), size: 18),
                      SizedBox(width: 8),
                      Text(
                        "Succès",
                        style: TextStyle(
                          color: Color(0xFF4CAF50),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              const Divider(height: 1, thickness: 1),
              const SizedBox(height: 30),
              _buildDetailRow("Récipiendaire", "+225 05 56 98 70 00"),
              _buildDetailRow("Émetteur", "Wave"),
              _buildDetailRow("Date", date),
              _buildDetailRow("ID de transaction", "TCLD8SFTYBJXHVKCU"),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Color(0xFFB0BAC9),
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              color: AppColors.primaryNavy,
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionItem(
      IconData icon, String title, String date, String amount, Color iconColor,
      {bool isError = false, bool isNegative = false}) {
    return GestureDetector(
      onTap: () => _showTransactionDetail(icon, title, date, amount, iconColor,
          isError: isError),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Container(
          decoration: BoxDecoration(
            border:
                Border(bottom: BorderSide(color: Colors.grey.withOpacity(0.1))),
          ),
          padding: const EdgeInsets.only(bottom: 15),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: isError || isNegative
                      ? AppColors.primaryLime.withOpacity(0.1)
                      : const Color(0xFFF0F5FA),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Icon(icon,
                      color: isError || isNegative
                          ? AppColors.primaryLime
                          : AppColors.primaryNavy,
                      size: 22),
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: isError
                            ? AppColors.primaryLime
                            : AppColors.primaryNavy,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 3),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE4F3FF),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text(
                            "WAVE",
                            style: TextStyle(
                              color: Color(0xFF0078D4),
                              fontSize: 10,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      date,
                      style: const TextStyle(
                          color: Color(0xFF8A98A8), fontSize: 13),
                    ),
                  ],
                ),
              ),
              Text(
                amount,
                style: TextStyle(
                  color: isError || !isNegative
                      ? const Color(0xFF2EAA5B)
                      : AppColors.primaryLime,
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserBalance() {
    return Column(
      children: [
        const Text(
          "SOLDE DISPONIBLE",
          style: TextStyle(
            color: Colors.white70,
            fontSize: 11,
            letterSpacing: 2,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              _isBalanceVisible ? "697 XOF" : "•••••• XOF",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 48,
                fontWeight: FontWeight.w900,
                letterSpacing: -1,
              ),
            ),
            const SizedBox(width: 15),
            GestureDetector(
              onTap: () {
                setState(() {
                  _isBalanceVisible = !_isBalanceVisible;
                });
              },
              child: Icon(
                _isBalanceVisible
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                color: Colors.white70,
                size: 28,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionGrid() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          _buildActionItem(Icons.check_box, "DÉPÔT", onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const DepositScreen()),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildActionItem(IconData icon, String label, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 75,
            height: 75,
            decoration: BoxDecoration(
              color: AppColors.primaryLime,
              borderRadius: BorderRadius.circular(22),
            ),
            child: Icon(icon, color: Colors.white, size: 32),
          ),
          const SizedBox(height: 12),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white70,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.5,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLeasingCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("À verser",
                  style: TextStyle(
                      color: AppColors.textGrey,
                      fontSize: 14,
                      fontWeight: FontWeight.w500)),
              Text("30.000 XOF",
                  style: const TextStyle(
                      color: AppColors.primaryNavy,
                      fontSize: 18,
                      fontWeight: FontWeight.w800)),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("0 XOF",
                  style: TextStyle(color: AppColors.textGrey, fontSize: 13)),
              Text("30.000 XOF",
                  style: TextStyle(color: AppColors.textGrey, fontSize: 13)),
            ],
          ),
          const SizedBox(height: 10),
          Stack(
            children: [
              Container(
                height: 8,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFFE2E8F0),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Container(
                height: 8,
                width: MediaQuery.of(context).size.width * 0.6, // Exemple 60%
                decoration: BoxDecoration(
                  color: AppColors.primaryLime,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ],
          ),
          const SizedBox(height: 25),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              color: AppColors.primaryLime,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Center(
              child: Text(
                "Payer ma traite",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomStats() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            child: _buildStatCard(
              "Factures\nà payer",
              "0 XOF",
              Icons.receipt_long,
              const Color(0xFFFFF2F2), // Light Pink background
              const Color(0xFFE57373), // Red/Pink icon color
              onTap: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        const PaymentCalendarScreen(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      const begin = Offset(1.0, 0.0);
                      const end = Offset.zero;
                      const curve = Curves.easeInOut;
                      var tween = Tween(begin: begin, end: end)
                          .chain(CurveTween(curve: curve));
                      return SlideTransition(
                        position: animation.drive(tween),
                        child: child,
                      );
                    },
                  ),
                );
              },
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: _buildStatCard(
              "Amendes\nà payer",
              "0 XOF",
              Icons.flag,
              const Color(0xFFF3F6FB), // Light Blue background
              const Color(0xFF7B8BB2), // Blue/Purple icon
              onTap: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        const FinesScreen(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      const begin = Offset(1.0, 0.0);
                      const end = Offset.zero;
                      const curve = Curves.easeInOut;
                      var tween = Tween(begin: begin, end: end)
                          .chain(CurveTween(curve: curve));
                      return SlideTransition(
                        position: animation.drive(tween),
                        child: child,
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String amount, IconData icon,
      Color bgColor, Color iconColor,
      {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(15),
        height: 150,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(icon, color: iconColor, size: 24),
                const SizedBox(width: 8),
                Text(
                  amount,
                  style: const TextStyle(
                    color: AppColors.primaryNavy,
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -0.5,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: AppColors.primaryNavy,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      height: 1.2,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  width: 32,
                  height: 32,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.arrow_forward,
                    color: AppColors.primaryNavy,
                    size: 16,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _RevealAnimation extends StatefulWidget {
  final Widget child;
  final Duration delay;

  const _RevealAnimation({required this.child, this.delay = Duration.zero});

  @override
  State<_RevealAnimation> createState() => _RevealAnimationState();
}

class _RevealAnimationState extends State<_RevealAnimation> {
  bool _visible = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(widget.delay, () {
      if (mounted) {
        setState(() {
          _visible = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _visible ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeOutCubic,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeOutCubic,
        transform: Matrix4.translationValues(
          0,
          _visible ? 0 : 30,
          0,
        ),
        child: widget.child,
      ),
    );
  }
}
