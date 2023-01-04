import 'package:flutter/material.dart';
import 'package:nooow/ui/screens/bottom_navigation_screen.dart';
import 'package:nooow/ui/screens/home/home_screen.dart';
import 'package:nooow/ui/screens/hot_offers/hot_offer_details_screen.dart';
import 'package:nooow/ui/screens/hot_offers/hot_offers_screen.dart';
import 'package:nooow/ui/screens/my_list/my_list_screen.dart';
import 'package:nooow/ui/screens/near_by/nearby_screens.dart';
import 'package:nooow/ui/screens/profile/profile_screen.dart';
import 'package:nooow/ui/screens/stores/stores_screen.dart';
import 'package:nooow/ui/screens/on_boarding/enter_otp_forgot_password_screen.dart';
import 'package:nooow/ui/screens/on_boarding/enter_otp_sign_up_screen.dart';
import 'package:nooow/ui/screens/on_boarding/forgot_password_screen.dart';
import 'package:nooow/ui/screens/on_boarding/reset_password_screen.dart';
import 'package:nooow/ui/screens/on_boarding/sign_in_screen.dart';
import 'package:nooow/ui/screens/on_boarding/sign_up_screen.dart';

abstract class AppRoutes {
  static const String signInScreen = '/signInScreen';
  static const String signUpScreen = '/signUpScreen';
  static const String enterOtpForgotPasswordScreen =
      '/enterOtpForgotPasswordScreen';
  static const String enterOtpSignUpScreen = '/enterOtpSignUpScreen';
  static const String resetPasswordScreen = '/resetPasswordScreen';
  static const String forgotPasswordScreen = '/forgotPasswordScreen';
  static const String homeScreen = '/homeScreen';
  static const String nearByScreen = '/nearByScreen';
  static const String hotDealsScreen = '/hotDealsScreen';
  static const String storesScreen = '/storesScreen';
  static const String profileScreen = '/profileScreen';
  static const String hotOfferDetailsScreen = '/hotOfferDetailsScreen';
  static const String myListScreen = '/myListScreen';

  // static const String / = '/splashScreen';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (context) => const BottomNavigationBarScreen(),
        );

      case signInScreen:
        return MaterialPageRoute(
          builder: (context) => const SignInScreen(),
        );

      case signUpScreen:
        return MaterialPageRoute(
          builder: (context) => const SignUpScreen(),
        );

      case enterOtpForgotPasswordScreen:
        Map<String, dynamic> args = settings.arguments as Map<String, dynamic>;
        String email = args["email"] as String;
        String otp = args["otp"] as String;
        return MaterialPageRoute(
          builder: (context) => EnterOtpForgotPasswordScreen(
            email: email,
            otp: otp,
          ),
        );

      case enterOtpSignUpScreen:
        Map<String, dynamic> args = settings.arguments as Map<String, dynamic>;
        String email = args["email"] as String;
        String otp = args["otp"] as String;
        return MaterialPageRoute(
          builder: (context) => EnterOtpSignUpScreen(
            email: email,
            otp: otp,
          ),
        );

      case AppRoutes.forgotPasswordScreen:
        return MaterialPageRoute(
          builder: (context) => const ForgotPasswordScreen(),
        );

      case AppRoutes.resetPasswordScreen:
        String arg = settings.arguments as String;
        return MaterialPageRoute(
          builder: (context) => ResetPasswordScreen(
            email: arg,
          ),
        );

      case homeScreen:
        return MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        );

      case nearByScreen:
        return MaterialPageRoute(
          builder: (context) => const NearByScreen(),
        );

      case hotDealsScreen:
        return MaterialPageRoute(
          builder: (context) => const HotDealsScreen(),
        );

      case storesScreen:
        return MaterialPageRoute(
          builder: (context) => const StoresScreen(),
        );

      case profileScreen:
        return MaterialPageRoute(
          builder: (context) => const ProfileScreens(),
        );

      case hotOfferDetailsScreen:
        return MaterialPageRoute(
          builder: (context) => const HotOfferDetailScreen(),
        );

      case myListScreen:
        return MaterialPageRoute(
          builder: (context) => const MyListScreen(),
        );

      default:
        return MaterialPageRoute(
          builder: (context) {
            return const SignInScreen();
          },
        );
    }
  }
}
