import 'package:flutter/material.dart';

//Provider to show the obscure text of the password.
class PasswordProvider extends ChangeNotifier {
  bool showPassword(bool obscure) {
    obscure = !obscure;
    notifyListeners();
    return obscure;
  }
}
