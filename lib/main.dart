import 'package:flutter/material.dart';
import 'package:nooow/provider/api_services_provider.dart';
import 'package:nooow/provider/theme_provider.dart';
import 'package:nooow/provider/ui_provider.dart';
import 'package:nooow/services/local_db.dart';
import 'package:nooow/utils/app_constants.dart';
import 'package:nooow/utils/app_routes.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppSharedPrefrence().getInitialRoute();
  await AppSharedPrefrence().getUserData();

  runApp(
    ChangeNotifierProvider(
      create: (context) => UIProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UIProvider()),
        ChangeNotifierProvider(create: (context) => ApiServiceProvider()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            theme: themeProvider.getTheme(),
            debugShowCheckedModeBanner: false,
            title: AppKeys.appName,
            initialRoute: AppRoutes.selectIntrestScreen,
            onGenerateRoute: AppRoutes.generateRoute,
          );
        },
      ),
    );
  }
}
