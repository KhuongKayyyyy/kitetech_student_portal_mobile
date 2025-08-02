part of 'message_room_bloc.dart';

@immutable
sealed class MessageRoomState {}

final class MessageRoomInitial extends MessageRoomState {}

final class MessageRoomStateLoading extends MessageRoomState {}

final class MessageRoomStateLoaded extends MessageRoomState {
  final List<MessageRoom> messageRooms;

  MessageRoomStateLoaded({required this.messageRooms});
}

final class MessageRoomStateError extends MessageRoomState {
  final String message;

  MessageRoomStateError({required this.message});
}
