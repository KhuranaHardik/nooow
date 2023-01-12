import 'package:flutter/material.dart';
import 'package:nooow/services/local_db.dart';

class ThemeProvider with ChangeNotifier {
  bool _isDark = false;
  final AppSharedPrefrence _preferences = AppSharedPrefrence();
  bool get isDark => _isDark;

  themeMode() {
    getPreferences();
  }

  setDarkMode(bool value) {
    _isDark = value;
    _preferences.setTheme(value);
    notifyListeners();
  }

  getPreferences() async {
    _isDark = await _preferences.getTheme();
    notifyListeners();
  }
}
