import 'package:flutter/material.dart';

class AppColors {
  // Deep forest green primary
  static const Color forestGreen = Color(0xFF1B4332);
  static const Color darkForest = Color(0xFF0D2818);
  
  // Fresh leaf green secondary & accents
  static const Color leafGreen = Color(0xFF2D6A4F);
  static const Color brightGreen = Color(0xFF40916C);
  static const Color accentGreen = Color(0xFF52B788);
  static const Color mintGreen = Color(0xFF74C69D);
  static const Color lightGreenBg = Color(0xFFD8F3DC);

  // Soft cream & neutral backgrounds
  static const Color softCream = Color(0xFFF7F9F5);
  static const Color cardBg = Color(0xFFFFFFFF);
  static const Color darkBg = Color(0xFF121B16);
  
  // Accent colors
  static const Color goldenGrain = Color(0xFFE9C46A);
  static const Color warmAmber = Color(0xFFF4A261);
  static const Color alertRed = Color(0xFFE63946);
  
  // Text colors
  static const Color textDark = Color(0xFF1C2826);
  static const Color textMuted = Color(0xFF52615B);
  static const Color textLight = Color(0xFFF8F9FA);
  
  // Border & Dividers
  static const Color borderLight = Color(0xFFE2E8E0);
}

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.leafGreen,
        primary: AppColors.leafGreen,
        secondary: AppColors.brightGreen,
        surface: AppColors.softCream,
        error: AppColors.alertRed,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: AppColors.textDark,
      ),
      scaffoldBackgroundColor: AppColors.softCream,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.forestGreen,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          letterSpacing: 0.5,
        ),
      ),
      cardTheme: CardThemeData(
        color: AppColors.cardBg,
        elevation: 2,
        shadowColor: AppColors.forestGreen.withValues(alpha: 0.08),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: AppColors.borderLight, width: 0.8),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.leafGreen,
          foregroundColor: Colors.white,
          elevation: 3,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.3,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.forestGreen,
          side: const BorderSide(color: AppColors.leafGreen, width: 1.5),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          textStyle: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        selectedItemColor: AppColors.forestGreen,
        unselectedItemColor: AppColors.textMuted,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
        unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal, fontSize: 12),
        type: BottomNavigationBarType.fixed,
        elevation: 10,
      ),
    );
  }
}
