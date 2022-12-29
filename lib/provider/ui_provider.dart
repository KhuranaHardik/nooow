import 'package:flutter/material.dart';

class UIProvider extends ChangeNotifier {
  // for changing the button color.
  bool buttonColorChange(List<TextEditingController> controller) {
    for (int i = 0; i < controller.length; i++) {
      if (controller[i].text.isEmpty) {
        notifyListeners();
        return false;
      }
    }
    notifyListeners();
    return true;
  }

  //Provider to show the obscure text of the password.
  bool showPassword(bool obscure) {
    obscure = !obscure;
    notifyListeners();
    return obscure;
  }

  // To show loader
  bool loader = false;

  void loaderTrue() {
    loader = true;
    notifyListeners();
  }

  void loaderFalse() {
    loader = false;
    notifyListeners();
  }
}
