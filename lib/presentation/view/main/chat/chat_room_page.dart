import 'package:flutter/material.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:kitetech_student_portal/core/constant/app_color.dart';
import 'package:kitetech_student_portal/core/constant/app_text_style.dart';
import 'package:kitetech_student_portal/data/model/message_room.dart';
import 'package:kitetech_student_portal/data/model/message_room_member.dart';

class ChatRoomPage extends StatefulWidget {
  final MessageRoom messageRoom;
  const ChatRoomPage({super.key, required this.messageRoom});

  @override
  State<ChatRoomPage> createState() => _ChatRoomPageState();
}

class _ChatRoomPageState extends State<ChatRoomPage> {
  List<types.Message> messages = [];
  final _user =
      const types.User(id: 'user1', firstName: 'John', lastName: 'Doe');

  final _chatController = InMemoryChatController();

  @override
  void initState() {
    super.initState();
    _loadInitialMessages();
  }

  void _loadInitialMessages() {
    // Convert MessageContent to chat UI messages
    for (var content in widget.messageRoom.messageContents) {
      final message = types.TextMessage(
        id: content.id,
        text: content.content,
        createdAt: content.dateSent.millisecondsSinceEpoch,
        author: types.User(
          id: content.userId,
          firstName: _getMemberDisplayName(content.userId),
        ),
      );
      messages.insert(0, message);
    }

    // Add welcome message if no messages exist
    if (messages.isEmpty) {
      final welcomeMessage = types.TextMessage(
        id: 'welcome',
        text: widget.messageRoom.isGroup
            ? 'Chào mừng đến với ${_getRoomDisplayName()}! 👋'
            : 'Chào mừng đến với cuộc trò chuyện! 👋',
        createdAt: DateTime.now()
            .subtract(const Duration(minutes: 5))
            .millisecondsSinceEpoch,
        author: types.User(
          id: "system",
          firstName: "System",
        ),
      );

      setState(() {
        messages.insert(0, welcomeMessage);
      });
    }
  }

  String _getMemberDisplayName(String userId) {
    final member = widget.messageRoom.members.firstWhere(
      (member) => member.userId == userId,
      orElse: () => MessageRoomMember(
        userId: userId,
        messageRoomId: widget.messageRoom.id,
        isAdmin: false,
        lastSeen: null,
      ),
    );
    return member
        .userId; // You might want to replace this with actual display name
  }

  String _getRoomDisplayName() {
    if (widget.messageRoom.isGroup) {
      return widget.messageRoom.name.isNotEmpty
          ? widget.messageRoom.name
          : 'Nhóm chat';
    } else {
      // For 1-on-1 chat, show the other member's name
      final otherMember = widget.messageRoom.members.firstWhere(
        (member) =>
            member.userId !=
            'current_user_id', // Replace with actual current user ID
        orElse: () => widget.messageRoom.members.first,
      );
      return otherMember.userId;
    }
  }

  MessageRoomMember? _getOtherMember() {
    if (widget.messageRoom.isGroup) return null;

    return widget.messageRoom.members.firstWhere(
      (member) =>
          member.userId !=
          'current_user_id', // Replace with actual current user ID
      orElse: () => widget.messageRoom.members.first,
    );
  }

  bool _isOtherMemberOnline() {
    final otherMember = _getOtherMember();
    if (otherMember?.lastSeen == null) return false;

    return otherMember!.lastSeen!
        .isAfter(DateTime.now().subtract(const Duration(minutes: 5)));
  }

  @override
  void dispose() {
    _chatController.dispose();
    super.dispose();
  }

  void _addMessage(types.Message message) {
    setState(() {
      messages.insert(0, message);
    });
  }

  void _handleSendMessage(types.PartialText message) {
    final textMessage = types.TextMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      text: message.text,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      author: _user,
    );
    _addMessage(textMessage);
  }

  String _getLastSeenText(DateTime? lastSeen) {
    if (lastSeen == null) return "Không xác định";

    final now = DateTime.now();
    final difference = now.difference(lastSeen);

    if (difference.inMinutes < 1) {
      return "Đang hoạt động";
    } else if (difference.inMinutes < 60) {
      return "Hoạt động ${difference.inMinutes} phút trước";
    } else if (difference.inHours < 24) {
      return "Hoạt động ${difference.inHours} giờ trước";
    } else if (difference.inDays < 7) {
      return "Hoạt động ${difference.inDays} ngày trước";
    } else {
      return "Hoạt động ${lastSeen.day}/${lastSeen.month}/${lastSeen.year}";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.primaryColor.withOpacity(0.1),
              Colors.white,
            ],
          ),
        ),
        child: Chat(
          messages: messages,
          onSendPressed: _handleSendMessage,
          user: _user,
          theme: _buildChatTheme(),
          showUserAvatars: true,
          showUserNames: true,
          dateHeaderThreshold: 3600000, // 1 hour
          emptyState: _buildEmptyStateHold(),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    final otherMember = _getOtherMember();
    final isOnline = _isOtherMemberOnline();

    return AppBar(
      title: Row(
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: widget.messageRoom.isGroup
                    ? Colors.blue.shade100
                    : Colors.grey.shade200,
                child: Icon(
                  widget.messageRoom.isGroup ? Icons.group : Icons.person,
                  color: widget.messageRoom.isGroup
                      ? Colors.blue.shade600
                      : Colors.grey.shade600,
                  size: 20,
                ),
              ),
              if (!widget.messageRoom.isGroup && otherMember != null)
                Positioned(
                  bottom: 0,
                  right: 0,
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
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _getRoomDisplayName(),
                  style: AppTextStyle.title.copyWith(fontSize: 16),
                  overflow: TextOverflow.ellipsis,
                ),
                if (!widget.messageRoom.isGroup && otherMember != null)
                  Text(
                    isOnline
                        ? "Đang hoạt động"
                        : _getLastSeenText(otherMember.lastSeen),
                    style: AppTextStyle.body.copyWith(
                      fontSize: 12,
                      color: isOnline ? Colors.green : Colors.grey,
                    ),
                  )
                else if (widget.messageRoom.isGroup)
                  Text(
                    "${widget.messageRoom.members.length} thành viên",
                    style: AppTextStyle.body.copyWith(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
      centerTitle: false,
      backgroundColor: AppColors.primaryColor.withOpacity(0.2),
      elevation: 0,
      actions: [
        IconButton(
          icon: const Icon(Icons.info_outline),
          onPressed: () {
            // Show chat info
          },
        ),
      ],
    );
  }

  Container _buildEmptyStateHold() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.chat_bubble_outline,
            size: 80,
            color: AppColors.primaryColor.withOpacity(0.5),
          ),
          const SizedBox(height: 20),
          Text(
            'Chưa có tin nhắn nào',
            style: TextStyle(
              fontSize: 18,
              color: AppColors.primaryColor.withOpacity(0.7),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Hãy bắt đầu cuộc trò chuyện!',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }

  DefaultChatTheme _buildChatTheme() {
    return DefaultChatTheme(
      inputMargin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      primaryColor: AppColors.primaryColor,
      secondaryColor: AppColors.primaryColor.withOpacity(0.1),
      backgroundColor: Colors.transparent,
      inputBackgroundColor: Colors.white,
      inputBorderRadius: BorderRadius.circular(25),
      inputContainerDecoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      messageBorderRadius: 20,
      userAvatarNameColors: const [AppColors.primaryColor],
      receivedMessageBodyTextStyle: const TextStyle(
        color: Colors.black87,
        fontSize: 16,
      ),
      sentMessageBodyTextStyle: const TextStyle(
        color: Colors.black,
        fontSize: 16,
      ),
      inputTextStyle: const TextStyle(
        fontSize: 16,
        color: Colors.black,
      ),
      inputTextDecoration: const InputDecoration(
        hintText: 'Nhập tin nhắn...',
        hintStyle: TextStyle(color: Colors.black),
        border: InputBorder.none,
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      ),
      sendButtonIcon: const Icon(
        Icons.send_rounded,
        color: Colors.white,
      ),
    );
  }
}
