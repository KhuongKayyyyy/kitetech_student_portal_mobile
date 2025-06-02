import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:go_router/go_router.dart';
import 'package:kitetech_student_portal/core/constant/app_text_style.dart';
import 'package:kitetech_student_portal/core/router/app_router.dart';

class UserBubble extends StatelessWidget {
  final VoidCallback onTap;
  final types.User user;
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
                  backgroundImage: NetworkImage(user.imageUrl!),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: user.lastSeen == 0 ? Colors.green : Colors.grey,
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
              user.lastName!,
              style: AppTextStyle.body,
            ),
        ],
      ),
    );
  }
}
