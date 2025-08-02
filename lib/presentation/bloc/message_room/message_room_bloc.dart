import 'package:bloc/bloc.dart';
import 'package:kitetech_student_portal/data/model/message_room.dart';
import 'package:kitetech_student_portal/data/respository/message_room_repository.dart';
import 'package:meta/meta.dart';

part 'message_room_event.dart';
part 'message_room_state.dart';

class MessageRoomBloc extends Bloc<MessageRoomEvent, MessageRoomState> {
  final MessageRoomRepository _messageRoomRepository;

  MessageRoomBloc(this._messageRoomRepository) : super(MessageRoomInitial()) {
    on<MessageRoomEvent>((event, emit) {});

    on<MessageRoomEventGetMessageRoomsByUserName>(_onGetMessageRoomsByUserName);
  }

  void _onGetMessageRoomsByUserName(
      MessageRoomEventGetMessageRoomsByUserName event,
      Emitter<MessageRoomState> emit) async {
    emit(MessageRoomStateLoading());
    try {
      final messageRooms = await _messageRoomRepository
          .getMessageRoomsByUserName(event.userName);
      emit(MessageRoomStateLoaded(messageRooms: messageRooms));
    } catch (e) {
      emit(MessageRoomStateError(message: e.toString()));
    }
  }
}
