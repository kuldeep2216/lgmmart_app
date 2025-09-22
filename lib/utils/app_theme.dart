import 'package:flutter/material.dart';

// Your CSS variables translated to Flutter
class AppColors {
  static const primary = Color(0xFF4CAF50); // --primary
  static const secondary = Color(0xFFFF6D00); // --secondary
  static const dark = Color(0xFF333333); // --dark
  static const light = Color(0xFFF8F9FA); // --light
  static const gray = Color(0xFF6C757D); // --gray
  static const background = Color(0xFFF0FFF0); // Custom light green background
}

// The main theme data for your app
class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.background,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 1,
      iconTheme: IconThemeData(color: AppColors.dark),
      titleTextStyle: TextStyle(
        color: AppColors.primary,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50), // rounded-pill
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        textStyle: const TextStyle(fontWeight: FontWeight.bold),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(50),
        borderSide: const BorderSide(color: AppColors.primary),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(50),
        borderSide: const BorderSide(color: AppColors.secondary, width: 2),
      ),
    ),
  );
}
