import 'package:flutter/material.dart';
import 'package:nooow/provider/password_provider.dart';
import 'package:nooow/ui/screens/on_boarding/sign_in_screen.dart';
import 'package:nooow/utils/app_keys.dart';
import 'package:nooow/utils/app_routes.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => PasswordProvider(),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: AppKeys.appName,
        home: SignInScreen(),
        // initialRoute: ResetPasswordScreen(),
        onGenerateRoute: AppRoutes.generateRoute,
      ),
    );
  }
}
