import 'package:flutter/cupertino.dart';
import 'package:myapp3/core/repoitorites/categories_repoitory.dart';
import 'package:myapp3/core/response/categories_reponse.dart';
import 'package:rxdart/rxdart.dart';

class CategoriesRxdartBloc {
  CategoriesResponse _categoriesResponse = CategoriesResponse();

  final BehaviorSubject<CategoriesRespoitory> _subject =
      BehaviorSubject<CategoriesRespoitory>();

  final BehaviorSubject<CategoriesRespoitory> _subjectOneCategory =
      BehaviorSubject<CategoriesRespoitory>();

  final BehaviorSubject<CategoriesRespoitory> _subjectSliderCategory =
      BehaviorSubject<CategoriesRespoitory>();

  final BehaviorSubject<CategoriesRespoitory> _subjectAllCategory =
      BehaviorSubject<CategoriesRespoitory>();

  getCategories(String limit) async {
    CategoriesRespoitory data =
        await _categoriesResponse.getFilteredCategories(limit: limit);
    if (_subject.isClosed == false) _subject.sink.add(data);
  }

  getOneCategory(String limit) async {
    CategoriesRespoitory data =
        await _categoriesResponse.getFilteredCategories(limit: limit);
    if (_subjectOneCategory.isClosed == false)
      _subjectOneCategory.sink.add(data);
  }

  getSliderCategories(String limit) async {
    CategoriesRespoitory data =
        await _categoriesResponse.getFilteredCategories(limit: limit);
    if (_subjectSliderCategory.isClosed == false)
      _subjectSliderCategory.sink.add(data);
  }

  getAllCategories() async {
    CategoriesRespoitory data =
        await _categoriesResponse.getCategories();
    print("Subject is Closed : ${_subjectAllCategory.isClosed}");
    if (_subjectAllCategory.isClosed == false) {
      print("Print data from Function Get All Categories in RxDart");
      _subjectAllCategory.sink.add(data);
    }
  }

  close() {
    if (_subject.isClosed == false) _subject.close();
    if (!_subjectOneCategory.isClosed == false) _subjectOneCategory.close();
    if (!_subjectSliderCategory.isClosed == false)
      _subjectSliderCategory.close();
    if (!_subjectAllCategory.isClosed == false) _subjectAllCategory.close();
  }

  BehaviorSubject<CategoriesRespoitory> get subject => _subject;
  BehaviorSubject<CategoriesRespoitory> get subjectOneCategory =>
      _subjectOneCategory;
  BehaviorSubject<CategoriesRespoitory> get subjectSliderImage =>
      _subjectSliderCategory;
  BehaviorSubject<CategoriesRespoitory> get subjectAllCategories =>
      _subjectAllCategory;
}

final categoriesRxdartBloc = CategoriesRxdartBloc();
final oneCategory = CategoriesRxdartBloc();
final sliderRxdartBloc = CategoriesRxdartBloc();
final allCategoriesRxdarBloc = CategoriesRxdartBloc();
