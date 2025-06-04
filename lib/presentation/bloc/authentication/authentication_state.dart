part of 'authentication_bloc.dart';

@immutable
sealed class AuthenticationState {}

final class AuthenticationInitial extends AuthenticationState {}

final class AuthenticationStateLoggedIn extends AuthenticationState {
  final String email;
  final String password;

  AuthenticationStateLoggedIn({required this.email, required this.password});
}

final class AuthenticationStateLoggedOut extends AuthenticationState {}
