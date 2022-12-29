import 'package:nooow/utils/app_asset_images.dart';
import 'package:nooow/utils/app_strings.dart';

class AppConstants {
  final int statusCode = 201;
  final int statusCode2001 = 200;
  static const login = "login Successfully";
  static const logout = "logout Successfully";

// for checking null value
  bool checkStatusCode(status) {
    if (status == statusCode || status == statusCode2001) {
      return true;
    } else {
      return false;
    }
  }

  // RegEx
  static RegExp emailOrPhone = RegExp(r'\w+@\w+\.\w+|(^[1-9][0-9]{0,10}$)');
  static RegExp capitalAlphabets = RegExp(r'[A-Z]');
  static RegExp lowerAlphabets = RegExp(r'[a-z]');
  static RegExp noDigits = RegExp(r'[0-9]');
  static RegExp mobileNo = RegExp(r'^[1-9][0-9]{9,13}$');
  static RegExp email =
      RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$');
  static RegExp punctuation = RegExp(r'[!@#\$&*~-]');

  // Categories List
  static List popularCategoriesList = [
    {
      AppString.categoryName: AppString.fashion,
      AppString.categoryImage: AppAssetImages.fashion,
    },
    {
      AppString.categoryName: AppString.beauty,
      AppString.categoryImage: AppAssetImages.beauty,
    },
    {
      AppString.categoryName: AppString.beauty,
      AppString.categoryImage: AppAssetImages.beauty,
    },
    {
      AppString.categoryName: AppString.grocery,
      AppString.categoryImage: AppAssetImages.grocery,
    },
    {
      AppString.categoryName: AppString.movies,
      AppString.categoryImage: AppAssetImages.movies,
    },
    {
      AppString.categoryName: AppString.pharmacy,
      AppString.categoryImage: AppAssetImages.pharmacy,
    },
    {
      AppString.categoryName: AppString.fashion,
      AppString.categoryImage: AppAssetImages.fashion,
    },
    {
      AppString.categoryName: AppString.grocery,
      AppString.categoryImage: AppAssetImages.beauty,
    },
  ];
}

class AppKeys {
  static const String appName = 'Nooow';
}

abstract class ApiEndPoints {
  static const String sliderList =
      "http://nooow.com/testing.nooow.com/api/Api/slider";
  static const String categoryList =
      "http://nooow.com/testing.nooow.com/api/Api/category";
  static const String otpForSignup =
      "http://testing.nooow.com/api/Api/verify_otp";
  static const String forgotOtpVerificationUrl =
      "http://nooow.com/testing.nooow.com/api/Api/verify_forgot_password";
  static const String signup =
      'http://nooow.com/testing.nooow.com/api/Api/user_registration';
  static const String updateUserProfile =
      "http://nooow.com/testing.nooow.com/api/Api/update_user_profile";
  static const String login =
      'http://nooow.com/testing.nooow.com/api/Api/user_login';
  static const String forgotPassword =
      "http://testing.nooow.com/api/Api/forgot_password";
  static const String otpVerificationForgotPassword =
      "http://nooow.com/testing.nooow.com/api/Api/verify_forgot_password";
  static const String changePassword =
      "http://nooow.com/testing.nooow.com/api/Api/change_forgot_password";
  static const String userDetails =
      "http://nooow.com/testing.nooow.com/api/Api/user_details";
  static const String addToCart =
      "http://nooow.com/testing.nooow.com/api/Api/add_to_cart";
  static const String cartList =
      "http://nooow.com/testing.nooow.com/api/Api/cart_list";
  static const String removeFromCart =
      "http://nooow.com/testing.nooow.com/api/Api/remove_from_cart";
  static const String resetPasswordUrl =
      "http://nooow.com/testing.nooow.com/api/Api/change_forgot_password";
}
