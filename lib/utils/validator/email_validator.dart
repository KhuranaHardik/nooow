import 'package:coach_app/utils/apphelper/constants/app_constants.dart';

// email validation
class EmailValidator {
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return ' Email Required*';
    } else if (!AppConstants.email.hasMatch(value)) {
      return "Invalid Email*";
    } else {
      return null;
    }
  }

// email and phone no validation
  String? validateEmailOrPhone(String? value) {
    if (value == null || value.isEmpty) {
      return ' Email or Mobile No. Required*';
    } else if (!AppConstants.emailOrPhone.hasMatch(value)) {
      return "Invalid Email or a Mobile No.*";
    } else {
      return null;
    }
  }
}
