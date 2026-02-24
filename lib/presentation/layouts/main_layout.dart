import 'package:flutter/material.dart';
import 'package:project/presentation/screens/wallet/wallet_screen.dart';
import 'package:project/presentation/screens/vehicle/vehicle_screen.dart';
import 'package:project/presentation/screens/profile_screen.dart';
import 'package:project/presentation/screens/dashboard_screen.dart';
import '../navigation/bottom_nav_bar.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({Key? key}) : super(key: key);

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _currentIndex = 0;

  void _onNavTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          const DashboardScreen(),
          const WalletScreen(),
          const VehicleScreen(),
          const ProfileScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onNavTap,
      ),
    );
  }
}
