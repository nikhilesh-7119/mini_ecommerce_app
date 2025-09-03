import 'package:flutter/material.dart';

class Lighttheme {
  static const Color _brandBlue = Color(0xFF1F74BA); // Flipkart blue [3]
  static const Color _brandYellow = Color(0xFFF7E200); // Flipkart yellow [3]
  static const Color _brandOrange = Color(0xFFF09120); // Accent [3]

  static final ThemeData theme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(
      seedColor: _brandBlue,
      brightness: Brightness.light,
    ).copyWith(
      primary: _brandBlue,
      onPrimary: Colors.white,
      secondary: _brandYellow,
      onSecondary: Colors.black,
      tertiary: _brandOrange,
      surface: const Color(0xFFFFFFFF),
      onSurface: const Color(0xFF1A1A1A),
      background: const Color(0xFFFAFAFA),
      onBackground: const Color(0xFF121212),
      primaryContainer: const Color(0xFFE5F0FA),
      onPrimaryContainer: const Color(0xFF0B3554),
      secondaryContainer: const Color(0xFFFFF7B3),
      onSecondaryContainer: const Color(0xFF403800),
      outline: const Color(0xFFDEE2E6),
    ),
    scaffoldBackgroundColor: const Color(0xFFFAFAFA),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      centerTitle: false,
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      surfaceTintColor: Colors.transparent,
    ),
    cardTheme: CardThemeData(
      elevation: 1,
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: _brandBlue,
        foregroundColor: Colors.white,
        textStyle: const TextStyle(fontWeight: FontWeight.w600),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: _brandYellow,
        foregroundColor: Colors.black,
        textStyle: const TextStyle(fontWeight: FontWeight.w600),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: const Color(0xFFF5F7FA),
      selectedColor: _brandBlue.withOpacity(0.12),
      side: const BorderSide(color: Color(0xFFE6E8EC)),
      labelStyle: const TextStyle(color: Color(0xFF1A1A1A)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFFF5F7FA),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Color(0xFFE6E8EC)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Color(0xFFE6E8EC)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Color(0xFF1F74BA)),
      ),
    ),
    textTheme: const TextTheme(
      titleMedium: TextStyle(fontWeight: FontWeight.w600), // for product titles
      bodyMedium: TextStyle(color: Color(0xFF1A1A1A)),
      labelLarge: TextStyle(fontWeight: FontWeight.w600),
    ),
    dividerColor: const Color(0xFFE6E8EC),
    iconTheme: const IconThemeData(color: Color(0xFF1A1A1A)),
  );
}