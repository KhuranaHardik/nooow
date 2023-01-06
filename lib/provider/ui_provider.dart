import 'package:flutter/material.dart';

class UIProvider extends ChangeNotifier {
  // For bottom navigation bar.
  int onTap(int index) {
    int currentIndex = index;
    notifyListeners();
    return currentIndex;
  }

  // for changing the button color.
  bool buttonColorChange(List<TextEditingController> controller) {
    for (int i = 0; i < controller.length; i++) {
      if (controller[i].text.isEmpty) {
        notifyListeners();
        return true;
      }
    }
    notifyListeners();
    return false;
  }

  //Provider to show the obscure text of the password.

  // To show loader
  bool loading = false;

  void loaderTrue() {
    loading = true;
    notifyListeners();
  }

  void loaderFalse() {
    loading = false;
    notifyListeners();
  }
}

class ObscureIconProvider extends ChangeNotifier {
  bool obscure = false;
  bool showPassword() {
    print("Provider before $obscure");
    obscure = !obscure;
    print("Provider after $obscure");
    notifyListeners();
    return obscure;
  }
}
