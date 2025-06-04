part of 'authentication_bloc.dart';

@immutable
sealed class AuthenticationEvent {}

class AuthenticationEventLogin extends AuthenticationEvent {
  final String email;
  final String password;

  AuthenticationEventLogin({required this.email, required this.password});
}

class AuthenticationEventLogout extends AuthenticationEvent {}
