import 'package:flutter/material.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:kitetech_student_portal/core/constant/app_color.dart';
import 'package:kitetech_student_portal/core/constant/app_text_style.dart';

class ChatRoomPage extends StatefulWidget {
  final types.User user;
  const ChatRoomPage({super.key, required this.user});

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
    // Add some sample messages to make the UI look better
    final welcomeMessage = types.TextMessage(
      id: 'welcome',
      text: 'Chào Nguyễn Đạt Khương đẹp trai đã trở lại phòng chat! 👋',
      createdAt: DateTime.now()
          .subtract(const Duration(minutes: 5))
          .millisecondsSinceEpoch,
      author: widget.user,
    );

    setState(() {
      messages.insert(0, welcomeMessage);
    });
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

  String _getLastSeenText(int lastSeen) {
    final lastSeenTime = DateTime.fromMillisecondsSinceEpoch(lastSeen);
    final now = DateTime.now();
    final difference = now.difference(lastSeenTime);

    if (difference.inMinutes < 1) {
      return "Active now";
    } else if (difference.inMinutes < 60) {
      return "Active ${difference.inMinutes}m ago";
    } else if (difference.inHours < 24) {
      return "Active ${difference.inHours}h ago";
    } else if (difference.inDays < 7) {
      return "Active ${difference.inDays}d ago";
    } else {
      return "Last seen ${lastSeenTime.day}/${lastSeenTime.month}/${lastSeenTime.year}";
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
    return AppBar(
      title: Row(
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(widget.user.imageUrl!),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color:
                        widget.user.lastSeen == 0 ? Colors.green : Colors.grey,
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${widget.user.firstName!} ${widget.user.lastName!}",
                style: AppTextStyle.title,
              ),
              Text(
                widget.user.lastSeen == 0
                    ? "Active now"
                    : _getLastSeenText(widget.user.lastSeen!),
                style: AppTextStyle.body.copyWith(
                  fontSize: 12,
                  color: widget.user.lastSeen == 0 ? Colors.green : Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
      centerTitle: true,
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
