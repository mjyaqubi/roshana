import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_locale.dart';

class RoshanaTypography {
  static TextStyle getTextStyle({
    required RoshanaLocale currentLocale,
    double fontSize = 16.0,
    FontWeight fontWeight = FontWeight.normal,
    Color? color,
  }) {
    if (currentLocale.scriptFamily == 'Arabic') {
      // Vazirmatn font for Persian (fa_IR) & Dari (fa_AF)
      return GoogleFonts.vazirmatn(
        fontSize: fontSize,
        fontWeight: fontWeight,
        height: 1.65, // Enhanced line height for Arabic diacritics
        color: color ?? Colors.white,
      );
    } else {
      // Inter font for English (en_US)
      return GoogleFonts.inter(
        fontSize: fontSize,
        fontWeight: fontWeight,
        height: 1.3,
        letterSpacing: 0.2,
        color: color ?? Colors.white,
      );
    }
  }

  static TextTheme getTextTheme(RoshanaLocale locale) {
    final baseTheme = ThemeData.dark().textTheme;
    if (locale.scriptFamily == 'Arabic') {
      return GoogleFonts.vazirmatnTextTheme(baseTheme);
    } else {
      return GoogleFonts.interTextTheme(baseTheme);
    }
  }
}
