import 'package:flutter/material.dart';

class FinzeeColors {
  static const primary = Color(0xFF075C63);
  static const primaryDark = Color(0xFF043F45);
  static const primarySoft = Color(0xFFE2F5F2);
  static const background = Color(0xFFF7F8F8);
  static const surface = Color(0xFFFFFFFF);
  static const textPrimary = Color(0xFF111827);
  static const textSecondary = Color(0xFF667085);
  static const border = Color(0xFFE5E7EB);
  static const income = Color(0xFF16B87A);
  static const expense = Color(0xFFF05D5E);
  static const warning = Color(0xFFF5A623);
  static const info = Color(0xFF4A8DFF);
  static const savings = Color(0xFF20B486);
  static const investment = Color(0xFF8B6CF6);
}

ThemeData buildFinzeeTheme() {
  const text = TextTheme(
    displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.w700, color: FinzeeColors.textPrimary),
    headlineLarge: TextStyle(fontSize: 28, fontWeight: FontWeight.w700, color: FinzeeColors.textPrimary),
    headlineMedium: TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: FinzeeColors.textPrimary),
    titleLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: FinzeeColors.textPrimary),
    bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: FinzeeColors.textPrimary),
    bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: FinzeeColors.textPrimary),
    bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: FinzeeColors.textSecondary),
  );

  return ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: FinzeeColors.primary,
      primary: FinzeeColors.primary,
      surface: FinzeeColors.surface,
    ),
    scaffoldBackgroundColor: FinzeeColors.background,
    textTheme: text,
    appBarTheme: const AppBarTheme(
      backgroundColor: FinzeeColors.background,
      foregroundColor: FinzeeColors.textPrimary,
      elevation: 0,
      centerTitle: false,
    ),
    cardTheme: CardThemeData(
      color: FinzeeColors.surface,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: FinzeeColors.primaryDark,
        foregroundColor: Colors.white,
        minimumSize: const Size.fromHeight(52),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: FinzeeColors.primaryDark,
        side: const BorderSide(color: FinzeeColors.border),
        minimumSize: const Size.fromHeight(52),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: FinzeeColors.surface,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: FinzeeColors.border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: FinzeeColors.border),
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: FinzeeColors.surface,
      selectedItemColor: FinzeeColors.primaryDark,
      unselectedItemColor: FinzeeColors.textSecondary,
      type: BottomNavigationBarType.fixed,
      elevation: 8,
    ),
  );
}
