import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kitetech_student_portal/core/router/app_router.dart';
import 'package:kitetech_student_portal/core/util/fake_data.dart';
import 'package:kitetech_student_portal/data/model/name_recognition.dart';
import 'package:kitetech_student_portal/presentation/view/add_on/check_chat_request_page.dart';
import 'package:kitetech_student_portal/presentation/view/add_on/name_recognition/name_recognition_confirm_page.dart';
import 'package:kitetech_student_portal/presentation/view/add_on/name_recognition/name_recognition_history_page.dart';
import 'package:kitetech_student_portal/presentation/view/add_on/name_recognition/name_recognition_page.dart';
import 'package:kitetech_student_portal/presentation/view/add_on/name_recognition/name_recognition_qr_scanner.dart';
import 'package:kitetech_student_portal/presentation/view/add_on/name_recognition/name_recogniton_pin_page.dart';
import 'package:kitetech_student_portal/presentation/view/add_on/news_read_page.dart';
import 'package:kitetech_student_portal/presentation/view/add_on/student_detail_information.dart';
import 'package:kitetech_student_portal/presentation/view/authentication/authentication_page.dart';
import 'package:kitetech_student_portal/presentation/view/main/chat/chat_home_page.dart';
import 'package:kitetech_student_portal/presentation/view/main/chat/chat_home_search.dart';
import 'package:kitetech_student_portal/presentation/view/main/chat/chat_room_page.dart';
import 'package:kitetech_student_portal/presentation/view/main/chat/chat_search_history.dart';
import 'package:kitetech_student_portal/presentation/view/main/home/home_search_page.dart';
import 'package:kitetech_student_portal/presentation/view/main/home/homepage.dart';
import 'package:kitetech_student_portal/presentation/view/main/home/nfc_test.dart';
import 'package:kitetech_student_portal/presentation/view/main/home/scoreboard_page.dart';
import 'package:kitetech_student_portal/presentation/view/main/home/timetable_page.dart';
import 'package:kitetech_student_portal/presentation/view/main/profile/profile_page.dart';
import 'package:kitetech_student_portal/presentation/view/main_wrapper/main_wrapper.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

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
        GoRoute(
            path: AppRouter.homeSearchPage,
            name: AppRouter.homeSearchPage,
            builder: (context, state) => const HomeSearchPage(),
            pageBuilder: (context, state) => CustomTransitionPage(
                  key: state.pageKey,
                  child: const HomeSearchPage(),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    return FadeTransition(
                      opacity: animation,
                      child: child,
                    );
                  },
                )),
        GoRoute(
            path: AppRouter.nfcPage,
            name: AppRouter.nfcPage,
            builder: (context, state) => const NFCPage()),
      ],
    );
  }

  static StatefulShellBranch _buildChatBranch() {
    return StatefulShellBranch(
      navigatorKey: _chatNavigatorKey,
      routes: [
        GoRoute(
            path: AppRouter.chatHomePage,
            name: AppRouter.chatHomePage,
            builder: (context, state) => const ChatHomePage()),
        GoRoute(
            path: AppRouter.chatHomeSearch,
            name: AppRouter.chatHomeSearch,
            builder: (context, state) => const ChatHomeSearch(),
            pageBuilder: (context, state) => CustomTransitionPage(
                  key: state.pageKey,
                  child: const ChatHomeSearch(),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    return FadeTransition(
                      opacity: animation,
                      child: child,
                    );
                  },
                )),
        GoRoute(
            path: AppRouter.chatSearchHistory,
            name: AppRouter.chatSearchHistory,
            builder: (context, state) => const ChatSearchHistory()),
        GoRoute(
            path: AppRouter.checkChatRequestPage,
            name: AppRouter.checkChatRequestPage,
            builder: (context, state) => const CheckChatRequestPage()),
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
            path: AppRouter.profilePage,
            name: AppRouter.profilePage,
            builder: (context, state) => const ProfilePage())
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
        builder: (context, state) => const AuthenticationPage(),
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
          path: AppRouter.nameRecognitionConfirmPage,
          name: AppRouter.nameRecognitionConfirmPage,
          builder: (context, state) {
            final extra = state.extra as NameRecognition;
            return NameRecognitionConfirmPage(
              nameRecognition: extra,
            );
          }),
      GoRoute(
          path: AppRouter.chatRoomPage,
          name: AppRouter.chatRoomPage,
          builder: (context, state) => ChatRoomPage(
                user: state.extra as types.User,
              )),
    ];
  }
}
