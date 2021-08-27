import 'package:flutter/cupertino.dart';
import 'package:myapp3/core/response/authentication_reponse.dart';
import 'package:rxdart/rxdart.dart';

class AuthRxdartBloc {
  AuthenticationResponse _authResponse = AuthenticationResponse();

  final BehaviorSubject<bool> _subjectEditPassword = BehaviorSubject<bool>();
  final BehaviorSubject<bool> _subjectEditProfile = BehaviorSubject<bool>();

  editPassword({String oldPass, String pass, String confirmPass}) async {
    bool data = await _authResponse.editPassword(pass, confirmPass, oldPass);
    if (!_subjectEditPassword.isClosed) _subjectEditPassword.sink.add(data);
  }

  editProfile({String name, String phone, String email}) async {
    bool data = await _authResponse.updateProfile(name, phone, email);
    if (!_subjectEditProfile.isClosed) {
      _subjectEditProfile.sink.add(data);
    }
    return data;
  }

  void drainStream() {
    _subjectEditPassword.value = null;
    _subjectEditProfile.value = null;
  }

  @mustCallSuper
  close() {
    _subjectEditPassword.drain();
    _subjectEditProfile.drain();
    _subjectEditPassword.close();
    _subjectEditProfile.close();
  }

  BehaviorSubject<bool> get subjectPassword => _subjectEditPassword;
  BehaviorSubject<bool> get subjectProfile => _subjectEditProfile;
}

final authRxdartBloc = AuthRxdartBloc();
