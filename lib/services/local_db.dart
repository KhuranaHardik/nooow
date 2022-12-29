// ignore_for_file: use_build_context_synchronously

import 'package:nooow/utils/app_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPrefrence {
  static final AppSharedPrefrence _singleton = AppSharedPrefrence._internal();

  factory AppSharedPrefrence() {
    return _singleton;
  }

  AppSharedPrefrence._internal();

  Future<Map<String, bool?>> _visitedScreen() async {
    return {
      AppRoutes.signInScreen: await _getScreen(AppRoutes.signInScreen),
      AppRoutes.homeScreen: await _getScreen(AppRoutes.homeScreen),
    };
  }

  Future<bool?> _getScreen(String screen) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getBool(screen);
  }

  Future<void> getInitialRoute() async {
    initialRoute = AppSharedPrefrence().checkInitRoute(await _visitedScreen());
  }

  String? initialRoute;
  String? checkInitRoute(Map<String, bool?> screenVisitied) {
    for (MapEntry e in screenVisitied.entries) {
      if (e.value == false || e.value == null) {
        return e.key;
      }
    }
    return null;
  }

  Future<void> saveScreen(String screen) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool(screen, true);
  }
}
