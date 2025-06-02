import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kitetech_student_portal/core/constant/app_text_style.dart';
import 'package:kitetech_student_portal/core/router/app_router.dart';
import 'package:kitetech_student_portal/core/util/fake_data.dart';
import 'package:kitetech_student_portal/presentation/widget/chat/chat_room_item.dart';
import 'package:kitetech_student_portal/presentation/widget/chat/chat_search_bar.dart';
import 'package:kitetech_student_portal/presentation/widget/chat/user_bubble.dart';

class ChatHomePage extends StatefulWidget {
  const ChatHomePage({super.key});

  @override
  State<ChatHomePage> createState() => _ChatHomePageState();
}

class _ChatHomePageState extends State<ChatHomePage> {
  bool _showSearchBar = false;

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Chat',
          style: AppTextStyle.title,
        ),
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (notification.metrics.pixels <= 0 &&
              notification is ScrollUpdateNotification &&
              notification.scrollDelta != null &&
              notification.scrollDelta! < -10) {
            // User is pulling down at the top
            setState(() {
              _showSearchBar = true;
            });
          }
          return false;
        },
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: _showSearchBar ? 60 : 0,
                child: _showSearchBar
                    ? Hero(
                        tag: "chat-search",
                        child: ChatSearchBar(
                          onTap: () => context.push(AppRouter.chatHomeSearch),
                        ))
                    : const SizedBox.shrink(),
              ),
              _buildUserList(),
              const Divider(height: 1),
              _buildChatRoomList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserList() {
    return SizedBox(
      height: 90,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: FakeData.chatUsers.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: UserBubble(user: FakeData.chatUsers[index], onTap: () {}),
          );
        },
      ),
    );
  }

  Widget _buildChatRoomList() {
    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: FakeData.chatUsers.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: ChatRoomItem(user: FakeData.chatUsers[index]),
        );
      },
    );
  }
}
