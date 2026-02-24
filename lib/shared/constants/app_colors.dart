import 'package:flutter/material.dart';

class AppColors {
  // GoCab Pro Brand Colors
  static const Color primaryLime = Color(0xFFD80010);
  static const Color primaryNavy =  Color(0xFF0A1B42);
  static const Color brandBlue = primaryNavy; // New branding color
  static const Color accentGreen =  Color(0xFFD80010);

  // Backgrounds
  static const Color background = primaryNavy; // ← Modifié de primaryLime à primaryNavy
  static const Color surfaceWhite = Colors.white;
  static const Color surfaceNavy = primaryNavy;

  // Text Colors
  static const Color textNavy = primaryNavy;
  static const Color textWhite = Colors.white;
  static const Color textGrey = Color(0xFFA0AEC0);

  // Status & Badges
  static const Color success = Color(0xFF48BB78);
  static const Color error = Color(0xFFE53E3E);
  static const Color purple = Color(0xFF6B46C1);
  static const Color black = Color(0xFF1A1A1A);

  // Semantics (compatibilité Sellovia existante)
  static const Color primaryBlue = primaryNavy;
  static const Color darkBlue = primaryNavy;
  static const Color primaryGreen = success;
  static const Color darkGreen = success;
  static const Color cardBackground = surfaceWhite;
  static const Color white = Colors.white;
  static const Color grey = textGrey;

  // Gradients (Mise à jour pour le nouveau style)
  static LinearGradient get navyGradient => const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [primaryNavy, Color(0xFF2A3C7B)],
      );

  static LinearGradient get limeGradient => const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [primaryLime, accentGreen],
      );

  // Added missing gradients
  static LinearGradient get blueGradient => navyGradient;

  static LinearGradient get greenGradient => const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [primaryGreen, Color(0xFF2F855A)],
      );
}
