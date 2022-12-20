// username validation

class UserNameValidator {
  String? validateUserName(String? userName) {
    if (userName == null || userName.isEmpty) {
      return 'Name Required*';
    } else if (userName.length < 2) {
      return ' Atleast 2 Characters Required*';
    } else {
      return null;
    }
  }
}
