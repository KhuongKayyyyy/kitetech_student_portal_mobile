import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:kitetech_student_portal/core/constant/app_color.dart';
import 'package:kitetech_student_portal/core/router/app_navigation.dart';
import 'package:kitetech_student_portal/core/theme/app_theme.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
  configLoading();
}

void configLoading() {
  EasyLoading.instance
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.light
    ..maskType = EasyLoadingMaskType.black
    ..indicatorColor = AppColors.primaryColor
    ..textColor = AppColors.primaryColor
    ..progressColor = AppColors.primaryColor
    ..dismissOnTap = false;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: "KiteTech Student Portal",
      theme: AppTheme.theme,
      routerConfig: AppNavigation.router,
      builder: EasyLoading.init(),
    );
  }
}
