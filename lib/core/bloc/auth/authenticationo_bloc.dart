import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:myapp3/core/repoitorites/user_repoitory.dart';
import 'package:myapp3/core/response/authentication_reponse.dart';

part 'authenticationo_event.dart';
part 'authenticationo_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationInitial());
  AuthenticationResponse _authenticationResponse;

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    _authenticationResponse = AuthenticationResponse();
    if (event is Login) {
      yield* _mapToLogin(event, _authenticationResponse);
    } else if (event is Register) {
      yield* _mapToRegister(event, _authenticationResponse);
    } else if (event is ForgotPassword) {
      yield* _mapToForgotPassword(event, _authenticationResponse);
    } else if (event is RestPasswordEvent) {
      yield* _mapToRestPassword(event, _authenticationResponse);
    } else if (event is GetProfileUserEvent) {
      yield* _mapToProileUser(event, _authenticationResponse);
    }
  }

  Stream<AuthenticationState> _mapToRegister(
      Register event, AuthenticationResponse authenticationResponse) async* {
    var data = await authenticationResponse.register(
      name: event.name,
      email: event.email,
      password: event.password,
      confirmPass: event.passwordConfirmation,
    );
    if (data.user != null) {
      yield AuthenticationSuccess(data.user.token);
    } else if (data.exception != null) {
      yield AuthentiationException(data.exception);
    } else if (data.error != null) {
      yield AuthenticationError(data.error);
    }
  }

  Stream<AuthenticationState> _mapToLogin(
      Login event, AuthenticationResponse authenticationResponse) async* {
    var data = await authenticationResponse.login(
        email: event.email, password: event.password);
    if (data.user != null) {
      print("User");
      yield AuthenticationSuccess(data.user.token);
    } else if (data.exception != null) {
      print("exception");
      yield AuthentiationException(data.exception);
    } else if (data.error != null) {
      print("Error");
      yield AuthenticationError(data.error);
    }
  }

  Stream<AuthenticationState> _mapToForgotPassword(ForgotPassword event,
      AuthenticationResponse authenticationResponse) async* {
    try {
      var data = await authenticationResponse.forgetPass(email: event.email);
      print("Status $data");
      yield AuthenticationForgot("data");
    } catch (e) {
      yield AuthenticationForgotError(false);
    }
  }

  Stream<AuthenticationState> _mapToRestPassword(RestPasswordEvent event,
      AuthenticationResponse authenticationResponse) async* {
    try {
      var status = await authenticationResponse.resetPass(
          email: event.email,
          code: event.code,
          pass: event.password,
          passConfirm: event.passConfirm);
      print("Status $status");
      if (status == true)
        yield AuthenticationRestPassword(true);
      else if (status == false) yield AuthenticationRestPasswordError(false);
    } catch (e) {
      yield AuthenticationRestPasswordError(false);
    }
  }

  Stream<AuthenticationState> _mapToProileUser(GetProfileUserEvent event,
      AuthenticationResponse authenticationResponse) async* {
    try {
      var status = await authenticationResponse.getProfile();
      yield ProfileUserState(status);
    } catch (e) {
      yield AuthentiationException(e.toString());
    }
  }
}
