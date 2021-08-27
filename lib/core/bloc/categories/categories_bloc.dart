import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:myapp3/core/model/categories_model.dart';
import 'package:myapp3/core/model/celebrity_model.dart';
import 'package:myapp3/core/model/product_model.dart';
import 'package:myapp3/core/model/slider_model.dart';
import 'package:myapp3/core/response/categories_reponse.dart';

part 'categories_event.dart';
part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  CategoriesBloc() : super(CategoriesInitial());

  @override
  Stream<CategoriesState> mapEventToState(
    CategoriesEvent event,
  ) async* {
    final CategoriesResponse categoriesResponse = CategoriesResponse();
    if (event is InitialCategories) {
      yield* _mapToCategories(event, categoriesResponse);
    } else if (event is GetProductsOfCategory) {
      yield* _mapToCategoryProduct(event, categoriesResponse);
    } else if (event is GetSliderImage) {
      yield* _mapToGetSliderImage(event, categoriesResponse);
    } else if (event is GetCelebrities) {
      yield* _mapToGetCelebrities(event, categoriesResponse);
    }
  }

  Stream<CategoriesState> _mapToCategories(
      InitialCategories event, CategoriesResponse categoriesResponse) async* {
    try {
      yield CategortiesLoading();
      var data = await categoriesResponse.getFilteredCategories();
      if (data.categories != null) {
        yield CategoriesSuccess(data.categories);
      } else if (data.error != null) {
        yield CategoriesError(data.error);
      } else if (data.exception != null) {
        yield CategoriresException(data.exception);
      }
    } catch (e) {
      yield CategoriresException(e.toString());
    }
  }

  Stream<CategoriesState> _mapToCategoryProduct(GetProductsOfCategory event,
      CategoriesResponse categoriesResponse) async* {
    try {
      yield CategortiesLoading();
      var data = await categoriesResponse.getCategoryProducts(id: event.index);
      if (data.products != null) {
      print("GetProductsOfCategory : ${data.products.length}");
        yield ProductSuccess(data.products);
      } else if (data.error != null) {
        yield CategoriesError(data.error);
      } else if (data.exception != null) {
        yield CategoriresException(data.exception);
      }
    } catch (e) {
      yield CategoriresException(e.toString());
    }
  }

  Stream<CategoriesState> _mapToGetSliderImage(
      GetSliderImage event, CategoriesResponse categoriesResponse) async* {
    try {
      yield CategortiesLoading();
      var data = await categoriesResponse.getSliderImage();
      print(data);
      if (data.sliders != null) {
        yield SliderSuccess(data.sliders);
      } else if (data.error != null) {
        yield CategoriesError(data.error);
      } else if (data.exception != null) {
        yield CategoriresException(data.exception);
      }
    } catch (e) {
      yield CategoriresException(e.toString());
    }
  }

  //get

  Stream<CategoriesState> _mapToGetCelebrities(
      GetCelebrities event, CategoriesResponse categoriesResponse) async* {
    try {
      yield CategortiesLoading();
      var data = await categoriesResponse.getCelebrities();
      print(data);
      if (data.celebrity != null) {
        yield CelebritiesSuccess(data.celebrity);
      } else if (data.error != null) {
        yield CategoriesError(data.error);
      } else if (data.exception != null) {
        yield CategoriresException(data.exception);
      }
    } catch (e) {
      yield CategoriresException(e.toString());
    }
  }
}
