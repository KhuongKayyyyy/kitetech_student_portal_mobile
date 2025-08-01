import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kitetech_student_portal/core/router/app_router.dart';
import 'package:kitetech_student_portal/presentation/widget/app/app_bottom_navigation.dart';
import 'package:kitetech_student_portal/presentation/widget/app/qr_scanner_widget.dart';

class MainWrapper extends StatefulWidget {
  final StatefulNavigationShell navigationShell;
  const MainWrapper({super.key, required this.navigationShell});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  Widget? getFloatingButton() {
    final location = GoRouterState.of(context).uri.toString();

    if (location.startsWith(AppRouter.home)) {
      if (location == AppRouter.home) {
        return FloatingActionButton(
          onPressed: () => print("Home FAB pressed"),
          child: const Icon(Icons.add),
        );
      } else if (location == AppRouter.timetablePage) {
        return FloatingActionButton(
          onPressed: () => print("Timetable FAB pressed"),
          child: const Icon(Icons.calendar_today),
        );
      } else if (location == AppRouter.nameRecognitionPage) {
        return FloatingActionButton(
          onPressed: () => print("Name Recognition FAB pressed"),
          child: const Icon(Icons.face),
        );
      }
    } else if (location.startsWith(AppRouter.chatHomePage)) {
      return FloatingActionButton(
        onPressed: () => print("Chat FAB pressed"),
        child: const Icon(Icons.chat),
      );
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        extendBody: true,
        extendBodyBehindAppBar: true,
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
        // floatingActionButton: getFloatingButton(),
        body: Padding(
          padding: const EdgeInsets.only(bottom: 100),
          child: widget.navigationShell,
        ),
        bottomNavigationBar: Stack(
          children: [
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: AppBottomNavigationBar(widget: widget)),
            const Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: Center(child: QRScannerWidget()),
            ),
            Positioned(
                bottom: 90,
                left: 0,
                right: 0,
                child: Container(
                  height: 15,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      gradient: LinearGradient(
                          colors: [
                            Colors.white,
                            Colors.white.withOpacity(0.3),
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter)),
                )),
          ],
        ));
  }
}
