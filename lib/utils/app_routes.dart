import 'package:flutter/material.dart';
import 'package:nooow/ui/screens/home/home_screen.dart';
import 'package:nooow/ui/screens/on_boarding/enter_otp_screen.dart';
import 'package:nooow/ui/screens/on_boarding/reset_password_screen.dart';
import 'package:nooow/ui/screens/on_boarding/sign_in_screen.dart';
import 'package:nooow/ui/screens/on_boarding/sign_up_screen.dart';
import 'package:nooow/ui/screens/on_boarding/splash_screen.dart';
import 'package:nooow/ui/screens/under_development_screen.dart';

abstract class AppRoutes {
  static const String signInScreen = '/signInScreen';
  static const String signUpScreen = '/signUpScreen';
  static const String enterOtpScreen = '/enterOtpScreen';
  static const String resetPasswordScreen = '/resetPasswordScreen';
  static const String homeScreen = '/homeScreen';

  // static const String / = '/splashScreen';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // case '/':
      //   return MaterialPageRoute(
      //     builder: (context) => const SplashScreen(),
      //   );

      case '/':
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        );
      case signInScreen:
        return MaterialPageRoute(
          builder: (context) => const SignInScreen(),
        );
      case signUpScreen:
        return MaterialPageRoute(
          builder: (context) => const SignUpScreen(),
        );
      case enterOtpScreen:
        return MaterialPageRoute(
          builder: (context) => const EnterOtpScreen(),
        );
      case resetPasswordScreen:
        return MaterialPageRoute(
          builder: (context) => const ResetPasswordScreen(),
        );
      case homeScreen:
        return MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        );
      default:
        return MaterialPageRoute(
          builder: (context) {
            return const UnderDevelopmentScreen();
          },
        );
    }
  }
}
