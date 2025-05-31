import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kitetech_student_portal/core/router/app_router.dart';
import 'package:kitetech_student_portal/core/util/fake_data.dart';
import 'package:kitetech_student_portal/presentation/view/add_on/name_recognition/name_recognition_history_page.dart';
import 'package:kitetech_student_portal/presentation/view/add_on/name_recognition/name_recognition_page.dart';
import 'package:kitetech_student_portal/presentation/view/add_on/name_recognition/name_recognition_qr_scanner.dart';
import 'package:kitetech_student_portal/presentation/view/add_on/name_recognition/name_recogniton_pin_page.dart';
import 'package:kitetech_student_portal/presentation/view/add_on/news_read_page.dart';
import 'package:kitetech_student_portal/presentation/view/add_on/student_detail_information.dart';
import 'package:kitetech_student_portal/presentation/view/authentication/login.dart';
import 'package:kitetech_student_portal/presentation/view/main/chat/chat_home_page.dart';
import 'package:kitetech_student_portal/presentation/view/main/chat/chat_room_page.dart';
import 'package:kitetech_student_portal/presentation/view/main/home/homepage.dart';
import 'package:kitetech_student_portal/presentation/view/main/home/scoreboard_page.dart';
import 'package:kitetech_student_portal/presentation/view/main/home/timetable_page.dart';
import 'package:kitetech_student_portal/presentation/view/main_wrapper/main_wrapper.dart';

class AppNavigation {
  static final GlobalKey<NavigatorState> _rootNavigatorKey =
      GlobalKey<NavigatorState>();
  // static final GlobalKey<NavigatorState> _authNavigatorKey =
  //     GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> _homeNavigatorKey =
      GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> _chatNavigatorKey =
      GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> _paddingNavigatorKey =
      GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> _profileNavigatorKey =
      GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> _newsNavigatorKey =
      GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: AppRouter.home,
    routes: [
      _buildMainShellRoute(),
      ..._buildAuthenticationBranch(),
      ..._buildNoBottomNavRoute(),
    ],
  );

  static StatefulShellRoute _buildMainShellRoute() {
    return StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            MainWrapper(navigationShell: navigationShell),
        branches: [
          _buildHomeBranch(),
          _buildNewsBranch(),
          _buildPaddingBranch(),
          _buildChatBranch(),
          _buildProfileBranch(),
        ]);
  }

  static StatefulShellBranch _buildHomeBranch() {
    return StatefulShellBranch(
      navigatorKey: _homeNavigatorKey,
      routes: [
        GoRoute(
            path: AppRouter.home,
            name: AppRouter.home,
            builder: (context, state) => const Homepage()),
        GoRoute(
            path: AppRouter.timetablePage,
            name: AppRouter.timetablePage,
            builder: (context, state) => const TimetablePage()),
        GoRoute(
            path: AppRouter.nameRecognitionPage,
            name: AppRouter.nameRecognitionPage,
            builder: (context, state) => const NameRecognitionPage()),
        GoRoute(
            path: AppRouter.studentDetailInformation,
            name: AppRouter.studentDetailInformation,
            builder: (context, state) => const StudentDetailInformationPage()),
        GoRoute(
            path: AppRouter.nameRecognitionHistoryPage,
            name: AppRouter.nameRecognitionHistoryPage,
            builder: (context, state) => const NameRecognitionHistoryPage()),
        GoRoute(
            path: AppRouter.nameRecognitionPinPage,
            name: AppRouter.nameRecognitionPinPage,
            builder: (context, state) => const NameRecognitonPinPage()),
        GoRoute(
            path: AppRouter.scoreboardPage,
            name: AppRouter.scoreboardPage,
            builder: (context, state) => const ScoreboardPage()),
      ],
    );
  }

  static StatefulShellBranch _buildChatBranch() {
    return StatefulShellBranch(
      navigatorKey: _chatNavigatorKey,
      routes: [
        GoRoute(
            path: AppRouter.chat,
            name: AppRouter.chat,
            builder: (context, state) => const ChatHomePage()),
      ],
    );
  }

  static StatefulShellBranch _buildPaddingBranch() {
    return StatefulShellBranch(
      navigatorKey: _paddingNavigatorKey,
      routes: [
        GoRoute(
            path: AppRouter.padding,
            name: AppRouter.padding,
            builder: (context, state) => const Homepage())
      ],
    );
  }

  static StatefulShellBranch _buildProfileBranch() {
    return StatefulShellBranch(
      navigatorKey: _profileNavigatorKey,
      routes: [
        GoRoute(
            path: AppRouter.profile,
            name: AppRouter.profile,
            builder: (context, state) => const Homepage())
      ],
    );
  }

  static StatefulShellBranch _buildNewsBranch() {
    return StatefulShellBranch(
      navigatorKey: _newsNavigatorKey,
      routes: [
        GoRoute(
            path: AppRouter.news,
            name: AppRouter.news,
            builder: (context, state) => const Homepage())
      ],
    );
  }

  static List<GoRoute> _buildAuthenticationBranch() {
    return [
      GoRoute(
        path: AppRouter.authentication,
        name: AppRouter.authentication,
        builder: (context, state) => const LoginPage(),
      ),
    ];
  }

  static List<GoRoute> _buildNoBottomNavRoute() {
    return [
      GoRoute(
        path: AppRouter.newsReadPage,
        name: AppRouter.newsReadPage,
        builder: (context, state) => const NewsReadPage(),
      ),
      GoRoute(
          path: AppRouter.nameRecognitionQrScanner,
          name: AppRouter.nameRecognitionQrScanner,
          builder: (context, state) => NameRecognitionQrScanner(
                student: FakeData.student,
              )),
      GoRoute(
          path: AppRouter.chatRoomPage,
          name: AppRouter.chatRoomPage,
          builder: (context, state) => ChatRoomPage(
                user: FakeData.chatUsers.elementAt(1),
              ))
    ];
  }
}
