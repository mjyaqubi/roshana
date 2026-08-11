import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app_locale.dart';

class LocaleNotifier extends ChangeNotifier {
  static const String _localePrefKey = 'roshana_selected_locale';
  Locale _currentLocale = const Locale('fa', 'IR');

  Locale get currentLocale => _currentLocale;
  RoshanaLocale get roshanaLocale => RoshanaLocale.fromLocale(_currentLocale);

  LocaleNotifier() {
    _loadSavedLocale();
  }

  Future<void> _loadSavedLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final savedCode = prefs.getString(_localePrefKey);
    if (savedCode != null) {
      final parts = savedCode.split('_');
      if (parts.length == 2) {
        _currentLocale = Locale(parts[0], parts[1]);
      } else {
        _currentLocale = Locale(savedCode);
      }
      notifyListeners();
    }
  }

  Future<void> setLocale(RoshanaLocale newRoshanaLocale) async {
    _currentLocale = newRoshanaLocale.locale;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    final code = '${newRoshanaLocale.locale.languageCode}_${newRoshanaLocale.locale.countryCode}';
    await prefs.setString(_localePrefKey, code);
  }
}
