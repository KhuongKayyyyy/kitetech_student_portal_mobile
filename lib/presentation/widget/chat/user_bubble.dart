import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:kitetech_student_portal/core/constant/app_text_style.dart';

class UserBubble extends StatelessWidget {
  final types.User user;
  final bool nameVisible;
  const UserBubble({super.key, required this.user, this.nameVisible = true});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 80,
          height: 80,
          child: Stack(
            children: [
              CircleAvatar(
                radius: 100,
                backgroundImage: NetworkImage(user.imageUrl!),
              ),
              Positioned(
                bottom: 10,
                right: 10,
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
    );
  }

  Widget _buildFallbackAvatar() {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [Colors.blue.shade400, Colors.blue.shade600],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: Text(
          _getInitials(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  String _getInitials() {
    final firstName = user.firstName ?? '';
    final lastName = user.lastName ?? '';

    if (firstName.isEmpty && lastName.isEmpty) {
      return '?';
    }

    final firstInitial = firstName.isNotEmpty ? firstName[0].toUpperCase() : '';
    final lastInitial = lastName.isNotEmpty ? lastName[0].toUpperCase() : '';

    return '$firstInitial$lastInitial';
  }
}
