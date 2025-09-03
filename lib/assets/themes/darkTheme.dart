
import 'dart:ui';

import 'package:flutter/material.dart';

class Darktheme {
  static const Color _brandBlue = Color(0xFF1F74BA); // Flipkart blue [3]
  static const Color _brandYellow = Color(0xFFF7E200); // Flipkart yellow [3]
  static const Color _brandOrange = Color(0xFFF09120); // Accent [3]

  static final ThemeData theme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSeed(
      seedColor: _brandBlue,
      brightness: Brightness.dark,
    ).copyWith(
      primary: _brandBlue,
      onPrimary: Colors.white,
      secondary: _brandYellow,
      onSecondary: Colors.black,
      tertiary: _brandOrange,
      surface: const Color(0xFF121212),
      onSurface: const Color(0xFFE6E6E6),
      background: const Color(0xFF0F1113),
      onBackground: const Color(0xFFEDEDED),
      primaryContainer: const Color(0xFF0F2E49),
      onPrimaryContainer: const Color(0xFFE0F0FF),
      secondaryContainer: const Color(0xFF4A4300),
      onSecondaryContainer: const Color(0xFFFFF3A0),
      outline: const Color(0xFF2E3338),
    ),
    scaffoldBackgroundColor: const Color(0xFF0F1113),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      centerTitle: false,
      backgroundColor: Color(0xFF121212),
      foregroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
    ),
    cardTheme: CardThemeData(
      elevation: 1,
      color: const Color(0xFF15181B),
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
      backgroundColor: const Color(0xFF1A1E22),
      selectedColor: _brandBlue.withOpacity(0.25),
      side: const BorderSide(color: Color(0xFF2A2F34)),
      labelStyle: const TextStyle(color: Color(0xFFE6E6E6)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFF1A1E22),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Color(0xFF2A2F34)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Color(0xFF2A2F34)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Color(0xFF1F74BA)),
      ),
    ),
    textTheme: const TextTheme(
      titleMedium: TextStyle(fontWeight: FontWeight.w600),
      bodyMedium: TextStyle(color: Color(0xFFE6E6E6)),
      labelLarge: TextStyle(fontWeight: FontWeight.w600),
    ),
    dividerColor: const Color(0xFF2A2F34),
    iconTheme: const IconThemeData(color: Colors.white),
  );
}