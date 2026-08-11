import 'package:flutter/material.dart';

enum RoshanaLocale {
  faIR(Locale('fa', 'IR'), TextDirection.rtl, 'Arabic', 'Persian (Iran)'),
  faAF(Locale('fa', 'AF'), TextDirection.rtl, 'Arabic', 'Persian (Dari)'),
  enUS(Locale('en', 'US'), TextDirection.ltr, 'Latin', 'English (US)');

  final Locale locale;
  final TextDirection direction;
  final String scriptFamily;
  final String label;

  const RoshanaLocale(this.locale, this.direction, this.scriptFamily, this.label);

  static RoshanaLocale fromLocale(Locale locale) {
    for (final rLocale in RoshanaLocale.values) {
      if (rLocale.locale.languageCode == locale.languageCode &&
          (locale.countryCode == null || rLocale.locale.countryCode == locale.countryCode)) {
        return rLocale;
      }
    }
    return RoshanaLocale.faIR;
  }
}
