import 'package:bloc/bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kitetech_student_portal/core/network/api.dart';
import 'package:kitetech_student_portal/data/model/app_user.dart';
import 'package:kitetech_student_portal/data/respository/student_repository.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final FlutterSecureStorage storage = FlutterSecureStorage();
  final StudentRepository studentRepository;
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
      final student = await studentRepository.getUserInfo(); // or similar
      emit(AuthenticationStateLoggedIn(appUser: student));
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
    } catch (e) {
      emit(AuthenticationStateError(message: e.toString()));
    }
  }

  void _onAuthenticationEventLogout(
      AuthenticationEventLogout event, Emitter<AuthenticationState> emit) {
    emit(AuthenticationStateLoading());
    try {
      studentRepository.logout();
    } catch (e) {
      emit(AuthenticationStateError(message: e.toString()));
    }
    emit(AuthenticationStateLoggedOut());
  }
}
