import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:roshana/src/core/i18n/app_locale.dart';

void main() {
  group('Roshana Locale Resolution Tests', () {
    test('fa_IR resolves to Iranian Persian with RTL directionality and Arabic script', () {
      final locale = RoshanaLocale.fromLocale(const Locale('fa', 'IR'));
      expect(locale, equals(RoshanaLocale.faIR));
      expect(locale.direction, equals(TextDirection.rtl));
      expect(locale.scriptFamily, equals('Arabic'));
    });

    test('fa_AF resolves to Afghan Dari with RTL directionality and Arabic script', () {
      final locale = RoshanaLocale.fromLocale(const Locale('fa', 'AF'));
      expect(locale, equals(RoshanaLocale.faAF));
      expect(locale.direction, equals(TextDirection.rtl));
      expect(locale.scriptFamily, equals('Arabic'));
    });

    test('en_US resolves to English with LTR directionality and Latin script', () {
      final locale = RoshanaLocale.fromLocale(const Locale('en', 'US'));
      expect(locale, equals(RoshanaLocale.enUS));
      expect(locale.direction, equals(TextDirection.ltr));
      expect(locale.scriptFamily, equals('Latin'));
    });

    test('Unsupported locale falls back gracefully to fa_IR', () {
      final locale = RoshanaLocale.fromLocale(const Locale('de', 'DE'));
      expect(locale, equals(RoshanaLocale.faIR));
    });
  });
}
