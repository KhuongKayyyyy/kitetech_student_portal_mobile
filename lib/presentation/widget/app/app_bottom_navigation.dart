import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kitetech_student_portal/core/constant/app_color.dart';

class AppBottomNavigationBar extends StatefulWidget {
  final dynamic widget;
  const AppBottomNavigationBar({super.key, required this.widget});

  @override
  State<AppBottomNavigationBar> createState() => _AppBottomNavigationBarState();
}

class _AppBottomNavigationBarState extends State<AppBottomNavigationBar> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: FlashyTabBar(
        backgroundColor: Colors.white,
        selectedIndex: _selectedIndex,
        showElevation: true,
        onItemSelected: (index) => setState(() {
          _selectedIndex = index;
          _onTabTapped(index, widget.widget);
        }),
        items: [
          FlashyTabBarItem(
            inactiveColor: AppColors.grey,
            activeColor: AppColors.primaryColor,
            icon: const Icon(CupertinoIcons.home),
            title: const Text('Trang chủ'),
          ),
          FlashyTabBarItem(
            inactiveColor: AppColors.grey,
            activeColor: AppColors.primaryColor,
            icon: const Icon(CupertinoIcons.news),
            title: const Text("Thông báo"),
          ),
          FlashyTabBarItem(
            inactiveColor: AppColors.grey,
            activeColor: AppColors.primaryColor,
            icon: const Icon(CupertinoIcons.news),
            title: const Text("Padding"),
          ),
          FlashyTabBarItem(
            inactiveColor: AppColors.grey,
            activeColor: AppColors.primaryColor,
            icon: const Icon(CupertinoIcons.chat_bubble),
            title: const Text('Nhắn tin'),
          ),
          FlashyTabBarItem(
            inactiveColor: AppColors.grey,
            activeColor: AppColors.primaryColor,
            icon: const Icon(CupertinoIcons.person),
            title: const Text('Hồ sơ'),
          ),
        ],
      ),
    );
  }

  void _onTabTapped(int index, dynamic widget) {
    widget.navigationShell.goBranch(index,
        initialLocation: index == widget.navigationShell.currentIndex);
  }
}
