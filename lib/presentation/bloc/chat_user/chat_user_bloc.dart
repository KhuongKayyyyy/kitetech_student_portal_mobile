import 'package:bloc/bloc.dart';
import 'package:kitetech_student_portal/data/model/chat_user.dart';
import 'package:kitetech_student_portal/data/respository/chat_user_repository.dart';
import 'package:meta/meta.dart';

part 'chat_user_event.dart';
part 'chat_user_state.dart';

class ChatUserBloc extends Bloc<ChatUserEvent, ChatUserState> {
  final ChatUserRepository chatUserRepository;
  ChatUserBloc(this.chatUserRepository) : super(ChatUserInitial()) {
    on<ChatUserEvent>((event, emit) {});

    on<ChatUserEventGetAllUsers>(_onGetAllUsers);
  }

  Future<void> _onGetAllUsers(
      ChatUserEventGetAllUsers event, Emitter<ChatUserState> emit) async {
    emit(ChatUserStateLoading());
    try {
      final users = await chatUserRepository.getAllUsers();
      emit(ChatUserStateAllUsers(allUsers: users));
    } catch (e) {
      emit(ChatUserStateError(message: e.toString()));
    }
  }
}
