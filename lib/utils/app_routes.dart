import 'package:flutter/material.dart';
import 'package:nooow/ui/screens/home/home_screen.dart';
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

  // static const String / = '/splashScreen';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // case '/':
      //   return MaterialPageRoute(
      //     builder: (context) => const SignInScreen(),
      //   );

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

      default:
        return MaterialPageRoute(
          builder: (context) {
            return const SignInScreen();
          },
        );
    }
  }
}
