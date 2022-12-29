// password validation
import 'package:nooow/utils/app_constants.dart';

class PasswordValidator {
  String? validatePassword(String? pass) {
    if (pass == null || pass.isEmpty) {
      return 'Password Required*';
    }
    if (!RegExp(r'.{8,}').hasMatch(pass)) {
      return 'Password must have at least 8 characters';
    }
    if (!AppConstants.capitalAlphabets.hasMatch(pass)) {
      return 'Password must have at least one uppercase character';
    }
    if (!AppConstants.lowerAlphabets.hasMatch(pass)) {
      return 'Password must have at least one lowercase character';
    }
    if (!AppConstants.noDigits.hasMatch(pass)) {
      return 'Password must have at least one number';
    }

    return null;
  }
}
