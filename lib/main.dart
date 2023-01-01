import 'package:flutter/material.dart';
import 'package:nooow/provider/api_services_provider.dart';
import 'package:nooow/provider/ui_provider.dart';
import 'package:nooow/services/local_db.dart';
import 'package:nooow/utils/app_constants.dart';
import 'package:nooow/utils/app_routes.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppSharedPrefrence().getInitialRoute();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UIProvider()),
        ChangeNotifierProvider(create: (context) => ApiServiceProvider()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: AppKeys.appName,
        // initialRoute: AppSharedPrefrence().initialRoute,
        onGenerateRoute: AppRoutes.generateRoute,
      ),
    );
  }
}
