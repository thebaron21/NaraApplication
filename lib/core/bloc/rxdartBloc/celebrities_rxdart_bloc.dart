import 'dart:async';

import 'package:myapp3/core/repoitorites/celebrity_repoitory.dart';
import 'package:myapp3/core/response/categories_reponse.dart';
import 'package:rxdart/rxdart.dart';

class CelebritiesRxdartBloc {
  CategoriesResponse _celebritiesResponse = CategoriesResponse();

  final BehaviorSubject<CelebrityRepoitory> _subject =
      BehaviorSubject<CelebrityRepoitory>();

  // ignore: close_sinks
  StreamController<CelebrityRepoitory> _subjectObj =
      StreamController<CelebrityRepoitory>.broadcast();

  getCelebrities() async {
    CelebrityRepoitory data = await _celebritiesResponse.getCelebrities();
    if (!_subject.isClosed) _subject.sink.add(data);
  }

  Stream<CelebrityRepoitory> getCelebrit({String name}) async* {
    CelebrityRepoitory data =
        await _celebritiesResponse.getCelebritOnce(name: name);
    if (!_subjectObj.isClosed) _subjectObj.sink.add(data);
    yield* _subjectObj.stream;
  }

  close() {
    _subject.close();
  }

  BehaviorSubject<CelebrityRepoitory> get subject => _subject;
}

final celebritiesRxdartBloc = CelebritiesRxdartBloc();
