part of 'message_room_bloc.dart';

@immutable
sealed class MessageRoomEvent {}

class MessageRoomEventGetMessageRoomsByUserName extends MessageRoomEvent {
  final String userName;

  MessageRoomEventGetMessageRoomsByUserName(this.userName);
}
