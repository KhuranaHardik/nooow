import 'package:flutter/material.dart';

class UnderDevelopmentScreen extends StatelessWidget {
  const UnderDevelopmentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //UnderDevelopment Page
    return const Scaffold(
      body: Center(
        child: Text(
          'Under Development',
          style: TextStyle(fontSize: 25),
        ),
      ),
    );
  }
}
