import 'package:flutter/material.dart';
import '../i18n/app_locale.dart';
import '../i18n/font_resolver.dart';

class RoshanaTheme {
  static const Color darkBackground = Color(0xFF0F172A); // Slate 900
  static const Color cardBackground = Color(0xFF1E293B); // Slate 800
  static const Color primaryGold = Color(0xFFF59E0B);    // Amber 500
  static const Color secondaryEmerald = Color(0xFF10B981); // Emerald 500
  static const Color accentIndigo = Color(0xFF6366F1);   // Indigo 500

  static ThemeData getDarkTheme(RoshanaLocale locale) {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: darkBackground,
      colorScheme: const ColorScheme.dark(
        primary: primaryGold,
        secondary: secondaryEmerald,
        surface: cardBackground,
      ),
      textTheme: RoshanaTypography.getTextTheme(locale),
      appBarTheme: const AppBarTheme(
        backgroundColor: darkBackground,
        elevation: 0,
        centerTitle: true,
      ),
    );
  }
}
