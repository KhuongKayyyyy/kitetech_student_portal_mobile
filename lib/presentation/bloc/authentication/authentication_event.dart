part of 'authentication_bloc.dart';

@immutable
sealed class AuthenticationEvent {}

class AppStarted extends AuthenticationEvent {}

class AuthenticationEventLogin extends AuthenticationEvent {
  final String name;
  final String password;

  AuthenticationEventLogin({required this.name, required this.password});
}

class AuthenticationEventLogout extends AuthenticationEvent {}
