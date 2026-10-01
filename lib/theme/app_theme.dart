import 'package:flutter/material.dart';

class AppTheme {
  static const Color coffeeDark = Color(0xFF3E2723);
  static const Color coffee = Color(0xFF6F4E37);
  static const Color coffeeLight = Color(0xFFA67B5B);
  static const Color cream = Color(0xFFF8F3ED);
  static const Color white = Colors.white;
  static const Color black = Color(0xFF222222);
  static const Color grey = Color(0xFF777777);

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,

    scaffoldBackgroundColor: cream,

    colorScheme: ColorScheme.fromSeed(
      seedColor: coffee,
      primary: coffee,
      secondary: coffeeLight,
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: cream,
      foregroundColor: coffeeDark,
      elevation: 0,
      centerTitle: false,
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: coffee, width: 1.5),
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: coffeeDark,
        foregroundColor: white,
        minimumSize: const Size(double.infinity, 52),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
    ),

    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
        color: coffeeDark,
      ),
      headlineMedium: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold,
        color: coffeeDark,
      ),
      titleLarge: TextStyle(
        fontSize: 21,
        fontWeight: FontWeight.bold,
        color: coffeeDark,
      ),
      titleMedium: TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.w600,
        color: coffeeDark,
      ),
      bodyLarge: TextStyle(fontSize: 16, color: black),
      bodyMedium: TextStyle(fontSize: 14, color: grey),
    ),
  );
}
