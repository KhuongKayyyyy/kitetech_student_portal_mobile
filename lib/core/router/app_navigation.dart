import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kitetech_student_portal/core/router/app_router.dart';
import 'package:kitetech_student_portal/presentation/view/add_on/news_read_page.dart';
import 'package:kitetech_student_portal/presentation/view/authentication/login.dart';
import 'package:kitetech_student_portal/presentation/view/main/home/homepage.dart';
import 'package:kitetech_student_portal/presentation/view/main/home/timetable.dart';
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
  static final GlobalKey<NavigatorState> _settingsNavigatorKey =
      GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    initialLocation: AppRouter.home,
    routes: [
      _buildMainShellRoute(),
      ..._buildAuthenticationBranch(),
      ..._buildAddOnBranch(),
    ],
  );

  static StatefulShellRoute _buildMainShellRoute() {
    return StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            MainWrapper(navigationShell: navigationShell),
        branches: [
          _buildHomeBranch(),
          _buildChatBranch(),
          _buildPaddingBranch(),
          _buildProfileBranch(),
          _buildSettingsBranch()
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
            builder: (context, state) => const TimetablePage())
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
            builder: (context, state) => const Homepage())
      ],
    );
  }

  static StatefulShellBranch _buildPaddingBranch() {
    return StatefulShellBranch(
      navigatorKey: _paddingNavigatorKey,
      routes: [
        GoRoute(
            path: "padding",
            name: "padding",
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

  static StatefulShellBranch _buildSettingsBranch() {
    return StatefulShellBranch(
      navigatorKey: _settingsNavigatorKey,
      routes: [
        GoRoute(
            path: AppRouter.settings,
            name: AppRouter.settings,
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

  static List<GoRoute> _buildAddOnBranch() {
    return [
      GoRoute(
        path: AppRouter.newsReadPage,
        name: AppRouter.newsReadPage,
        builder: (context, state) => const NewsReadPage(),
      ),
    ];
  }
}
