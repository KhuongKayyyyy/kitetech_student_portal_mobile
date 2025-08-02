import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kitetech_student_portal/core/constant/app_text_style.dart';
import 'package:kitetech_student_portal/core/router/app_router.dart';
import 'package:kitetech_student_portal/data/model/chat_user.dart';

class UserBubble extends StatelessWidget {
  final VoidCallback onTap;
  final ChatUser user;
  final bool nameVisible;
  const UserBubble(
      {super.key,
      required this.user,
      this.nameVisible = true,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.pushNamed(AppRouter.chatRoomPage, extra: user);
        onTap();
      },
      child: Column(
        children: [
          SizedBox(
            width: 60,
            height: 60,
            child: Stack(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(user.avatarUrl!),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: user.status == UserStatus.ONLINE
                          ? Colors.green
                          : Colors.grey,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white,
                        width: 2,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          if (nameVisible)
            Text(
              user.username,
              style: AppTextStyle.body,
            ),
        ],
      ),
    );
  }
}
