part of 'authenticationo_bloc.dart';

@immutable
abstract class AuthenticationEvent {}

class Login extends AuthenticationEvent {
  final String email;
  final String password;

  Login(this.email, this.password);
}

class Register extends AuthenticationEvent {
  final String name;
  final String email;
  final String password;
  final String passwordConfirmation;

  Register(this.name, this.email, this.password, this.passwordConfirmation);
}

class ForgotPassword extends AuthenticationEvent {
  final String email;

  ForgotPassword(this.email);
}

class RestPasswordEvent extends AuthenticationEvent {
  final String email;
  final String password;
  final String code;
  final String passConfirm;

  RestPasswordEvent(this.email, this.password, this.code, this.passConfirm);
}

class GetProfileUserEvent extends AuthenticationEvent {}
