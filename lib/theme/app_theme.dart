import 'package:flutter/material.dart';

class AppTheme {
  static const _background = Color(0xFF101114);
  static const _surface = Color(0xFF1A1C22);
  static const _accent = Color(0xFFFFC857);
  static const _cyan = Color(0xFF45C4B0);

  static ThemeData get dark {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: _accent,
      brightness: Brightness.dark,
      surface: _surface,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: _background,
      colorScheme: colorScheme.copyWith(
        primary: _accent,
        secondary: _cyan,
        surface: _surface,
      ),
      appBarTheme: const AppBarTheme(
        centerTitle: false,
        backgroundColor: _background,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: _surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: const Color(0xFF242732),
        selectedColor: _accent.withValues(alpha: 0.22),
        labelStyle: const TextStyle(color: Colors.white),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
