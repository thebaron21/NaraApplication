import 'package:myapp3/core/repoitorites/user_repoitory.dart';
import 'package:myapp3/core/response/authentication_reponse.dart';
import 'package:rxdart/rxdart.dart';

class ProfileController {
  AuthenticationResponse _bloc = AuthenticationResponse();
  BehaviorSubject<ProfileUserRespoitory> _subject =
      BehaviorSubject<ProfileUserRespoitory>();

  getProfile() async {
    var data = await _bloc.getProfile();
    if (_subject.isClosed == false) _subject.sink.add(data);
  }

  close() {
    if (_subject.isClosed == false) _subject.close();
  }

  BehaviorSubject<ProfileUserRespoitory> get subjectProfile => _subject;
}

final profileRxDart = ProfileController();
