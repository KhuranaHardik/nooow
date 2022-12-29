import 'package:flutter/material.dart';

class AppCommonSnackBar {
  void appCommonSnackbar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
        duration: const Duration(seconds: 4),
      ),
    );
  }
}
