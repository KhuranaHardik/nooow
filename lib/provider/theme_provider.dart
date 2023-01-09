import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:nooow/services/local_db.dart';

class ThemeProvider with ChangeNotifier {
  final ThemeData darkTheme = ThemeData(
    primaryColor: Colors.black,
    backgroundColor: const Color(0xFF212121),
    dividerColor: Colors.black12,
    colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.grey).copyWith(
      secondary: Colors.white,
      brightness: Brightness.dark,
    ),
  );

  final lightTheme = ThemeData(
    primaryColor: Colors.white,
    backgroundColor: const Color(0xFFE5E5E5),
    dividerColor: Colors.white54,
    colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.grey).copyWith(
      secondary: Colors.black,
      brightness: Brightness.light,
    ),
  );

  ThemeData _themeData = ThemeData();
  ThemeData getTheme() => _themeData;

  ThemeProvider() {
    AppSharedPrefrence().getTheme().then((value) {
      log('value read from storage: $value');
      // _themeData = lightTheme;
      String themeMode = value ?? 'light';
      if (themeMode == 'light') {
        _themeData = lightTheme;
      } else {
        log('setting dark theme');
        _themeData = darkTheme;
      }
      notifyListeners();
    });
  }

  void setDarkMode() async {
    _themeData = darkTheme;
    AppSharedPrefrence().saveTheme('dark');
    notifyListeners();
  }

  void setLightMode() async {
    _themeData = lightTheme;
    AppSharedPrefrence().saveTheme('light');
    notifyListeners();
  }
}
