import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kitetech_student_portal/core/constant/app_color.dart';
import 'package:kitetech_student_portal/core/router/app_router.dart';
import 'package:kitetech_student_portal/core/util/fake_data.dart';
import 'package:kitetech_student_portal/presentation/widget/app/app_function_item.dart';
import 'package:kitetech_student_portal/presentation/widget/app/app_seach_bar.dart';
import 'package:kitetech_student_portal/presentation/widget/app/news_banner_item.dart';
import 'package:kitetech_student_portal/presentation/widget/student/student_header.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late final PageController _pageController;
  int _currentPage = 0;
  late final Timer _timer;
  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.8);

    // Autoscroll every 3 seconds
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_pageController.hasClients) {
        _currentPage++;
        if (_currentPage >= FakeData.news.length) _currentPage = 0;
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          centerTitle: true,
          expandedHeight: 150,
          pinned: true,
          flexibleSpace: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              final top = constraints.biggest.height;
              final expanded = top > 120;

              return Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.blue,
                      Colors.green,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: StudentHeader(
                  student: FakeData.student,
                  isExpanded: expanded,
                ),
              );
            },
          ),
        ),

        _buildSearchBar(),

        //
        _buildFeatureSection(context),

        _buildNewsSection(),
      ],
    );
  }

  SliverToBoxAdapter _buildSearchBar() {
    return SliverToBoxAdapter(
      child: InkWell(
          onTap: () => context.pushNamed(AppRouter.homeSearchPage),
          child: Hero(tag: "app-search", child: AppSeachBar())),
    );
  }

  SliverToBoxAdapter _buildNewsSection() {
    return SliverToBoxAdapter(
      child: Container(
        height: 200,
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: PageView.builder(
          controller: _pageController,
          itemCount: FakeData.news.length,
          onPageChanged: (index) {
            _currentPage = index;
          },
          itemBuilder: (context, index) {
            return AnimatedBuilder(
              animation: PageController(viewportFraction: 0.8),
              builder: (context, child) {
                return Transform.scale(
                  scale: 1.0,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    child: NewsBannerItem(news: FakeData.news[index]),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildFeatureSection(BuildContext context) {
    return SliverToBoxAdapter(
      child: GridView.count(
        padding: const EdgeInsets.symmetric(vertical: 15),
        crossAxisCount: 4,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        children: [
          AppFunctionItem(
            title: "Thông báo",
            icon: Icons.notifications,
            onTap: () {},
          ),
          AppFunctionItem(
            title: "Điểm số",
            icon: Icons.grade,
            onTap: () => context.pushNamed(AppRouter.scoreboardPage),
          ),
          AppFunctionItem(
            title: "Thời khóa biểu",
            icon: Icons.schedule,
            onTap: () => context.pushNamed(AppRouter.timetablePage),
          ),
          AppFunctionItem(
            title: "Học phí",
            icon: Icons.payment,
            onTap: () {},
          ),
          AppFunctionItem(
            title: "Thông tin SV",
            icon: Icons.person,
            onTap: () => context.pushNamed(AppRouter.studentDetailInformation),
          ),
          AppFunctionItem(
            title: "Điểm danh",
            icon: Icons.event,
            onTap: () => context.pushNamed(AppRouter.nameRecognitionPage),
          ),
          AppFunctionItem(
            title: "Chat",
            icon: Icons.chat,
            onTap: () => context.pushNamed(AppRouter.chatRoomPage),
          ),
        ],
      ),
    );
  }
}
