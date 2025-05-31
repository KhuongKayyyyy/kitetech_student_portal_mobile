import 'package:flutter/material.dart';
import 'package:kitetech_student_portal/core/constant/app_text_style.dart';
import 'package:kitetech_student_portal/core/util/fake_data.dart';
import 'package:kitetech_student_portal/presentation/widget/chat/chat_room_item.dart';
import 'package:kitetech_student_portal/presentation/widget/chat/user_bubble.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class ChatHomePage extends StatefulWidget {
  const ChatHomePage({super.key});

  @override
  State<ChatHomePage> createState() => _ChatHomePageState();
}

class _ChatHomePageState extends State<ChatHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Chat',
          style: AppTextStyle.title,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildUserList(),
            const Divider(height: 1),
            _buildChatRoomList(),
          ],
        ),
      ),
    );
  }

  Widget _buildUserList() {
    return SizedBox(
      height: 130,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: FakeData.chatUsers.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: UserBubble(user: FakeData.chatUsers[index]),
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
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
          child: ChatRoomItem(user: FakeData.chatUsers[index]),
        );
      },
    );
  }
}
