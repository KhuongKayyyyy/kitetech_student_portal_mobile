part of 'chat_user_bloc.dart';

@immutable
sealed class ChatUserEvent {}

class ChatUserEventLogin extends ChatUserEvent {
  final String username;
  final String password;
  ChatUserEventLogin({required this.username, required this.password});
}

class ChatUserEventLogout extends ChatUserEvent {}

class ChatUserEventGetOnlineUsers extends ChatUserEvent {}

class ChatUserEventSearchUsers extends ChatUserEvent {
  final String username;
  ChatUserEventSearchUsers({required this.username});
}

class ChatUserEventGetAllUsers extends ChatUserEvent {}
