import 'package:bloc/bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kitetech_student_portal/core/network/api.dart';
import 'package:kitetech_student_portal/data/model/app_user.dart';
import 'package:kitetech_student_portal/data/respository/student_repository.dart';
import 'package:kitetech_student_portal/data/service/chat_service.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  static const FlutterSecureStorage storage = FlutterSecureStorage();
  final StudentRepository studentRepository;
  final ChatService _chatService = ChatService();

  AuthenticationBloc(this.studentRepository) : super(AuthenticationInitial()) {
    on<AuthenticationEvent>((event, emit) {});
    on<AuthenticationEventLogin>(_onAuthenticationEventLogin);
    on<AuthenticationEventLogout>(_onAuthenticationEventLogout);
    on<AppStarted>(_onAppStarted);
  }

  Future<void> _onAppStarted(
      AppStarted event, Emitter<AuthenticationState> emit) async {
    emit(AuthenticationStateLoading());
    final accessToken = await storage.read(key: APIRoute.accessToken);
    final refreshToken = await storage.read(key: APIRoute.refreshToken);

    if (accessToken != null && refreshToken != null) {
      try {
        final student = await studentRepository.getUserInfo();
        emit(AuthenticationStateLoggedIn(appUser: student));

        // Auto-connect to chat if user is authenticated
        await _connectToChat(student.username, student.password);
      } catch (e) {
        emit(AuthenticationStateError(message: e.toString()));
      }
    } else {
      emit(AuthenticationStateLoggedOut());
    }
  }

  Future<void> _onAuthenticationEventLogin(
      AuthenticationEventLogin event, Emitter<AuthenticationState> emit) async {
    emit(AuthenticationStateLoading());
    try {
      await studentRepository.login(event.name, event.password);
      final appUser = await studentRepository.getUserInfo();

      emit(AuthenticationStateLoggedIn(appUser: appUser));
      await _connectToChat(appUser.username, appUser.password);
    } catch (e) {
      emit(AuthenticationStateError(message: e.toString()));
    }
  }

  void _onAuthenticationEventLogout(
      AuthenticationEventLogout event, Emitter<AuthenticationState> emit) {
    emit(AuthenticationStateLoading());
    try {
      // Disconnect from chat before logout
      _chatService.disconnect();
      studentRepository.logout();
    } catch (e) {
      emit(AuthenticationStateError(message: e.toString()));
    }
    emit(AuthenticationStateLoggedOut());
  }

  // Helper method to connect to chat
  Future<void> _connectToChat(String username, String password) async {
    try {
      // First login to chat system using the same credentials
      await studentRepository.loginChatUser(
          username: username,
          password: password,
          fullName:
              'Nguyen Dat Khuong'); // You might want to store password securely

      // Then connect to WebSocket
      await _chatService.connect(APIRoute.javaBaseUrl, username);

      print('Successfully connected to chat as $username');
    } catch (e) {
      print('Failed to connect to chat: $e');
      // Don't throw error here as chat connection failure shouldn't break authentication
    }
  }

  // Getter to check if user is connected to chat
  bool get isChatConnected => _chatService.isConnected;

  // Getter to get current chat username
  String? get currentChatUsername => _chatService.currentUsername;

  // Method to manually disconnect from chat
  Future<void> disconnectFromChat() async {
    await _chatService.disconnect();
  }
}
