import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationInitial()) {
    on<AuthenticationEvent>((event, emit) {});
    on<AuthenticationEventLogin>(_onAuthenticationEventLogin);
    on<AuthenticationEventLogout>(_onAuthenticationEventLogout);
  }

  void _onAuthenticationEventLogin(
      AuthenticationEventLogin event, Emitter<AuthenticationState> emit) {
    emit(AuthenticationStateLoggedIn(
        email: event.email, password: event.password));
  }

  void _onAuthenticationEventLogout(
      AuthenticationEventLogout event, Emitter<AuthenticationState> emit) {
    emit(AuthenticationStateLoggedOut());
  }
}
