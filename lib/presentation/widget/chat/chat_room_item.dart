import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kitetech_student_portal/core/constant/app_text_style.dart';
import 'package:kitetech_student_portal/core/router/app_router.dart';
import 'package:go_router/go_router.dart';
import 'package:kitetech_student_portal/data/model/app_user.dart';
import 'package:kitetech_student_portal/data/model/message_room.dart';
import 'package:kitetech_student_portal/presentation/bloc/authentication/authentication_bloc.dart';

class ChatRoomItem extends StatefulWidget {
  final MessageRoom messageRoom;
  const ChatRoomItem({super.key, required this.messageRoom});

  @override
  State<ChatRoomItem> createState() => _ChatRoomItemState();
}

class _ChatRoomItemState extends State<ChatRoomItem> {
  late AppUser? currentUser;

  @override
  void initState() {
    super.initState();
    final authState = context.read<AuthenticationBloc>().state;
    if (authState is AuthenticationStateLoggedIn) {
      currentUser = authState.appUser;
    }
    print(currentUser?.username);
  }

  String _getLastSeenText(DateTime? lastSeen) {
    if (lastSeen == null) return 'Không xác định';

    final now = DateTime.now();
    final difference = now.difference(lastSeen);

    if (difference.inDays > 0) {
      return '${difference.inDays} ngày trước';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} giờ trước';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} phút trước';
    } else {
      return 'Vừa xong';
    }
  }

  String _getRoomDisplayName() {
    if (widget.messageRoom.isGroup) {
      return widget.messageRoom.name.isNotEmpty
          ? widget.messageRoom.name
          : 'Nhóm chat';
    } else {
      if (widget.messageRoom.name.isNotEmpty) {
        return widget.messageRoom.name;
      }

      // If no room name, show the other member's name/username
      final otherMember = widget.messageRoom.members.firstWhere(
        (member) => member.userId != currentUser?.username,
        orElse: () => widget.messageRoom.members.first,
      );
      return otherMember.userId;
    }
  }

  Widget _buildAvatar() {
    if (widget.messageRoom.isGroup) {
      return CircleAvatar(
        radius: 25,
        backgroundColor: Colors.blue.shade100,
        child: Icon(
          Icons.group,
          color: Colors.blue.shade600,
          size: 24,
        ),
      );
    } else {
      // For 1-on-1 chat, you might want to get the other user's avatar
      return CircleAvatar(
        radius: 25,
        backgroundColor: Colors.grey.shade200,
        child: Icon(
          Icons.person,
          color: Colors.grey.shade600,
          size: 24,
        ),
      );
    }
  }

  bool _isUserOnline() {
    if (widget.messageRoom.isGroup) {
      // For groups, check if any member is online (you might need to implement this logic)
      return widget.messageRoom.members.any((member) =>
          member.lastSeen
              ?.isAfter(DateTime.now().subtract(const Duration(minutes: 5))) ??
          false);
    } else {
      // For 1-on-1 chat, check the other user's status
      final otherMember = widget.messageRoom.members.firstWhere(
        (member) =>
            member.userId !=
            'current_user_id', // Replace with actual current user ID
        orElse: () => widget.messageRoom.members.first,
      );
      return otherMember.lastSeen
              ?.isAfter(DateTime.now().subtract(const Duration(minutes: 5))) ??
          false;
    }
  }

  DateTime? _getLastActivity() {
    if (widget.messageRoom.isGroup) {
      // For groups, get the latest lastSeen from all members
      final validLastSeenDates = widget.messageRoom.members
          .map((member) => member.lastSeen)
          .where((lastSeen) => lastSeen != null)
          .cast<DateTime>()
          .toList();

      if (validLastSeenDates.isEmpty) return null;

      return validLastSeenDates.reduce((a, b) => a.isAfter(b) ? a : b);
    } else {
      // For 1-on-1 chat, get the other user's lastSeen
      final otherMember = widget.messageRoom.members.firstWhere(
        (member) =>
            member.userId !=
            'current_user_id', // Replace with actual current user ID
        orElse: () => widget.messageRoom.members.first,
      );
      return otherMember.lastSeen;
    }
  }

  String _getLastMessage() {
    if (widget.messageRoom.messageContents.isNotEmpty) {
      final lastMessage = widget.messageRoom.messageContents.last;
      return lastMessage.content;
    }
    return "Chưa có tin nhắn";
  }

  int _getUnseenMessageCount() {
    // Since unseenMessageCount is not in the model, we'll return 0 for now
    // You can implement this logic based on your business requirements
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final isOnline = _isUserOnline();
    final lastActivity = _getLastActivity();
    final unseenCount = _getUnseenMessageCount();

    return GestureDetector(
      onTap: () {
        context.pushNamed(AppRouter.chatRoomPage, extra: widget.messageRoom);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          children: [
            SizedBox(
              width: 50,
              height: 50,
              child: Stack(
                children: [
                  _buildAvatar(),
                  if (!widget.messageRoom.isGroup)
                    Positioned(
                      bottom: 2,
                      right: 2,
                      child: Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: isOnline ? Colors.green : Colors.grey,
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
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          _getRoomDisplayName(),
                          style: AppTextStyle.title.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        isOnline
                            ? "Đang hoạt động"
                            : _getLastSeenText(lastActivity),
                        style: AppTextStyle.body.copyWith(
                          fontSize: 12,
                          color: isOnline ? Colors.green : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          _getLastMessage(),
                          style: AppTextStyle.body.copyWith(
                            fontSize: 14,
                            color: Colors.grey.shade600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (unseenCount > 0)
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            unseenCount.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
