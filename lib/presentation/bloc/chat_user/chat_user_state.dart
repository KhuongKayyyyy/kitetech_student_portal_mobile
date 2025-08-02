part of 'chat_user_bloc.dart';

@immutable
sealed class ChatUserState {}

final class ChatUserInitial extends ChatUserState {}

final class ChatUserStateLoggedIn extends ChatUserState {}

final class ChatUserStateLoggedOut extends ChatUserState {}

final class ChatUserStateLoading extends ChatUserState {}

final class ChatUserStateError extends ChatUserState {
  final String message;
  ChatUserStateError({required this.message});
}

final class ChatUserStateOnlineUsers extends ChatUserState {
  final List<String> onlineUsers;
  ChatUserStateOnlineUsers({required this.onlineUsers});
}

final class ChatUserStateSearchUsers extends ChatUserState {
  final List<String> searchUsers;
  ChatUserStateSearchUsers({required this.searchUsers});
}

final class ChatUserStateAllUsers extends ChatUserState {
  final List<ChatUser> allUsers;
  ChatUserStateAllUsers({required this.allUsers});
}
