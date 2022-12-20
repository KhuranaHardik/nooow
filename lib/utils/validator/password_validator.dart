import 'package:coach_app/utils/apphelper/constants/app_constants.dart';

// password validation
class PasswordValidator {
  String? validatePassword(String? pass) {
    if (pass == null || pass.isEmpty) {
      return 'Password Required*';
    }
    if (!RegExp(r'.{8,}').hasMatch(pass)) {
      return 'Password must have at least 8 characters';
    }

    if (!AppConstants.captialAlphabets.hasMatch(pass)) {
      return 'Password must have at least one uppercase character';
    }
    if (!AppConstants.lowerAlphabets.hasMatch(pass)) {
      return 'Password must have at least one lowercase character';
    }

    if (!AppConstants.noDigits.hasMatch(pass)) {
      return 'Password must have at least one number';
    }

    if (!AppConstants.punctuation.hasMatch(pass)) {
      return 'Required at least one special character like !@#\$&*~-';
    }

    return null;
  }
}
