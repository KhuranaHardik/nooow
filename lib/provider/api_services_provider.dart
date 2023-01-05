// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:nooow/model/login_model.dart';
import 'package:nooow/services/api_services.dart';
import 'package:nooow/services/local_db.dart';
import 'package:nooow/ui/components/app_common_snack_bar.dart';
import 'package:nooow/utils/app_routes.dart';

class ApiServiceProvider extends ChangeNotifier {
  //Singleton Method
  ApiServiceProvider._internal();

  static final ApiServiceProvider _instance = ApiServiceProvider._internal();

  factory ApiServiceProvider() {
    return _instance;
  }

  ApiServices apiServices = ApiServices();

  //Login Provider
  Future<void> loginProvider(
      {required BuildContext context,
      required Map<String, dynamic> body}) async {
    LoginModel? result = await apiServices.login(context: context, body: body);

    if (result == null) {
      null;
    } else {
      if (result.status ?? false) {
        await AppSharedPrefrence().saveScreen(AppRoutes.signInScreen);
        await AppSharedPrefrence().setUserSignedIn(true);
        print(
          result.information == null
              ? "<------------ Information Null --------------->"
              : result.information!.profileImage == null
                  ? "<------------ Null --------------->"
                  : "<------------ ${result.information!.profileImage.toString()} --------------->",
        );
        await AppSharedPrefrence().saveUserData(
          userId: result.information!.id.toString(),
          userName: result.information!.name.toString(),
          userProfile: result.information!.profileImage.toString(),
          userAddress: result.information!.address.toString(),
          mobileNumber: result.information!.contact.toString(),
        );
        Navigator.pushNamedAndRemoveUntil(
          context,
          "/",
          (route) => false,
        );
      } else {
        AppCommonSnackBar().appCommonSnackbar(
          context,
          result.message.toString(),
        );
      }
    }
  }

  //SignUp Provider
  Future<void> signupProvider(
      {required BuildContext context,
      required Map<String, dynamic> body}) async {
    Map<String, dynamic>? data =
        await apiServices.signup(context: context, body: body);
    log('signup data\n $data');
    if (data == null) {
      null;
    } else {
      if (data['information'] == null || data['information'].isEmpty) {
        AppCommonSnackBar().appCommonSnackbar(context, data['message']);
      } else {
        if (data['status']) {
          await AppSharedPrefrence().saveScreen(AppRoutes.signInScreen);
          await AppSharedPrefrence().setUserSignedIn(true);
          Navigator.pushNamed(
            context,
            AppRoutes.enterOtpSignUpScreen,
            arguments: {
              "email": body['email'],
              "otp": data["information"]['otp']['otp'].toString(),
            },
          );
        }
      }
    }
  }

  // OTP for signup
  Future signupOtpVerification(
      {required BuildContext context,
      required Map<String, dynamic> body}) async {
    Map<String, dynamic>? data =
        await apiServices.otpForSignUp(context: context, body: body);

    if (data == null || data.isEmpty) {
      AppCommonSnackBar().appCommonSnackbar(context, data!['message']);
    } else {
      if (data['status']) {
        Navigator.pushNamedAndRemoveUntil(
            context, AppRoutes.homeScreen, (route) => false);
      } else {
        AppCommonSnackBar().appCommonSnackbar(context, data['message']);
      }
    }
    // print(response.body);
  }

  //Forgot Password Provider
  Future forgotPasswordProvider(
      {required BuildContext context,
      required Map<String, dynamic> body}) async {
    Map<String, dynamic>? result =
        await apiServices.forgotPassword(context: context, body: body);

    if (result == null || result.isEmpty) {
      null;
    } else {
      if (result["status"]) {
        Navigator.pushNamed(
          context,
          AppRoutes.enterOtpForgotPasswordScreen,
          arguments: {
            "email": body["email"],
            "otp": result["information"]["otp"].toString(),
          },
        );
      } else {
        return AppCommonSnackBar()
            .appCommonSnackbar(context, result["message"]);
      }
    }
    // print(response.body);
  }

  //OTP Verification Forgot Password Provider
  Future<void> otpVerificationForgotPasswordProvider(
      {required BuildContext context,
      required Map<String, dynamic> body}) async {
    Map<String, dynamic>? result = await apiServices
        .otpVerificationForgotPassword(context: context, body: body);

    if (result == null || result.isEmpty) {
      null;
    } else {
      if (result["status"]) {
        Navigator.pushNamed(context, AppRoutes.resetPasswordScreen,
            arguments: body['email']);
      } else {
        return AppCommonSnackBar()
            .appCommonSnackbar(context, result["message"]);
      }
    }
    // print(response.body);
  }

  // reset password api
  Future<void> resetPasswordProvider(
      {required BuildContext context,
      required Map<String, dynamic> body}) async {
    Map<String, dynamic>? result =
        await apiServices.resetPassword(context: context, body: body);

    if (result == null || result.isEmpty) {
      null;
    } else {
      if (result["status"]) {
        Navigator.pushNamedAndRemoveUntil(
            context, AppRoutes.signInScreen, (route) => false);
      } else {
        return AppCommonSnackBar()
            .appCommonSnackbar(context, result["message"]);
      }
    }
    // print(response.body);
  }
}
