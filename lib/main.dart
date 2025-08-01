import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:kitetech_student_portal/core/constant/app_color.dart';
import 'package:kitetech_student_portal/core/constant/app_global.dart';
import 'package:kitetech_student_portal/core/router/app_navigation.dart';
import 'package:kitetech_student_portal/core/theme/app_theme.dart';
import 'package:kitetech_student_portal/data/client/api_client.dart';
import 'package:kitetech_student_portal/data/respository/student_repository.dart';
import 'package:kitetech_student_portal/presentation/bloc/authentication/authentication_bloc.dart';
import 'package:kitetech_student_portal/presentation/bloc/name_recognition/name_recognition_bloc.dart';

void main() async {
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) =>
                AuthenticationBloc(StudentRepository(ApiClient()))),
        BlocProvider(create: (context) => NameRecognitionBloc()),
        BlocProvider(
          create: (context) =>
              AuthenticationBloc(StudentRepository(ApiClient()))
                ..add(AppStarted()), // trigger login check
        ),
      ],
      child: MaterialApp.router(
        scaffoldMessengerKey: AppGlobal.scaffoldMessengerKey,
        debugShowCheckedModeBanner: false,
        title: "KiteTech Student Portal",
        theme: AppTheme.theme,
        routerConfig: AppNavigation.router,
        builder: EasyLoading.init(),
      ),
    );
  }
}
