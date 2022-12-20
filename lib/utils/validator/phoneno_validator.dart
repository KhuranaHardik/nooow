import 'package:coach_app/utils/apphelper/constants/app_constants.dart';

// phone no. validation
class PhoneNoValidator {
  String? phoneNoValidation(String? phoneNo) {
    if (phoneNo == null || phoneNo.isEmpty) {
      return 'Mobile No. Required*';
    } else if (!AppConstants.mobileNo.hasMatch(phoneNo)) {
      return 'Mobile No. Invalid*';
    }
    return null;
  }
}
