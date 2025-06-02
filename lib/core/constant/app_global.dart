import 'package:flutter/material.dart';
import 'package:kitetech_student_portal/core/router/app_router.dart';
import 'package:kitetech_student_portal/data/model/app_feature_model.dart';

class AppGlobal {
  static final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
}

class AppFeature {
  static final List<AppFeatureModel> allFeatures = [
    AppFeatureModel(
      title: 'Thông báo',
      icon: Icons.notifications,
      route: '',
    ),
    AppFeatureModel(
      title: 'Điểm số',
      icon: Icons.grade,
      route: AppRouter.scoreboardPage,
    ),
    AppFeatureModel(
      title: 'Thời khóa biểu',
      icon: Icons.schedule,
      route: AppRouter.timetablePage,
    ),
    AppFeatureModel(
      title: 'Học phí',
      icon: Icons.payment,
      route: '',
    ),
    AppFeatureModel(
      title: 'Thông tin SV',
      icon: Icons.person,
      route: AppRouter.studentDetailInformation,
    ),
    AppFeatureModel(
      title: 'Điểm danh',
      icon: Icons.event,
      route: AppRouter.nameRecognitionPage,
    ),
    AppFeatureModel(
      title: 'Chat',
      icon: Icons.chat,
      route: AppRouter.chatRoomPage,
    ),
  ];
}
