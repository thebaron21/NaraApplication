part of 'authenticationo_bloc.dart';

@immutable
abstract class AuthenticationState {}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationError extends AuthenticationState {
  final Map<String, dynamic> error;

  AuthenticationError(this.error);
}

class AuthentiationException extends AuthenticationState {
  final String error;
  AuthentiationException(this.error);
}

class AuthenticationSuccess extends AuthenticationState {
  final String token;
  AuthenticationSuccess(this.token);
}

class AuthenticationForgot extends AuthenticationState {
  final String isSuccess;

  AuthenticationForgot(this.isSuccess);
}

class AuthenticationForgotError extends AuthenticationState {
  final bool error;

  AuthenticationForgotError(this.error);
}

class AuthenticationRestPassword extends AuthenticationState {
  final bool isSuccess;

  AuthenticationRestPassword(this.isSuccess);
}

class AuthenticationRestPasswordError extends AuthenticationState {
  final bool error;

  AuthenticationRestPasswordError(this.error);
}

class ProfileUserState extends AuthenticationState {
  final ProfileUserRespoitory user;

  ProfileUserState(this.user);
}
