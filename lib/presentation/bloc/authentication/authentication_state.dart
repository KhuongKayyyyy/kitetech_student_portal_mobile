part of 'authentication_bloc.dart';

@immutable
sealed class AuthenticationState {}

final class AuthenticationInitial extends AuthenticationState {}

final class AuthenticationStateLoading extends AuthenticationState {}

final class AuthenticationStateError extends AuthenticationState {
  final String message;

  AuthenticationStateError({required this.message});
}

final class AuthenticationStateLoggedIn extends AuthenticationState {
  final AppUser appUser;

  AuthenticationStateLoggedIn({required this.appUser});
}

final class AuthenticationStateLoggedOut extends AuthenticationState {}
