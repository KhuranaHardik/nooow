// ignore_for_file: use_build_context_synchronously

import 'package:nooow/utils/app_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPrefrence {
  static final AppSharedPrefrence _singleton = AppSharedPrefrence._internal();
  factory AppSharedPrefrence() {
    return _singleton;
  }
  AppSharedPrefrence._internal();

  // List of visited screens
  Future<Map<String, bool?>> _visitedScreen() async {
    return {
      AppRoutes.signInScreen: await _getScreen(AppRoutes.signInScreen),
      AppRoutes.homeScreen: await _getScreen(AppRoutes.homeScreen),
    };
  }

  // Check whether the screen is visited or not.
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

  // Setting user as signed in.
  Future<void> setUserSignedIn(bool isUserSignedIn) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool("userSignedIn", isUserSignedIn);
  }

  // Getting if user is signed in.
  Future<bool?> getUserSignedIn() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getBool("userSignedIn");
  }

  List<String>? userData;

  // Setting User Details
  Future<void> saveUserData(
      {required String userId,
      required String userName,
      required String userProfile,
      required String mobileNumber,
      required String email}) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setStringList(
        'userData', [userId, userName, userProfile, mobileNumber, email]);
  }

  // Getting User Details
  Future<void> getUserData() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    userData = pref.getStringList('userData');
  }

  static const isDarkMode = "isDarkMode";

  // Saving theme
  Future<void> setTheme(bool value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool(isDarkMode, value);
  }

  // Getting theme
  Future<bool> getTheme() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool(isDarkMode) ?? false;
  }
}
