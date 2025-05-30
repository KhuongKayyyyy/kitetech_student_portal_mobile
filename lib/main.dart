import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:kitetech_student_portal/core/router/app_navigation.dart';

import 'package:kitetech_student_portal/core/theme/app_theme.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: "KiteTech Student Portal",
      routerConfig: AppNavigation.router,
      theme: AppTheme.theme,
    );
  }
}
