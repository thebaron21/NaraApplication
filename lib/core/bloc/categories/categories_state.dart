part of 'categories_bloc.dart';

@immutable
abstract class CategoriesState {}

class CategoriesInitial extends CategoriesState {}

class CategoriesError extends CategoriesState {
  final Map<String, dynamic> error;

  CategoriesError(this.error);
}

class CategoriresException extends CategoriesState {
  final String error;
  CategoriresException(this.error);
}

class CategoriesSuccess extends CategoriesState {
  final List<CategoryModel> categories;
  CategoriesSuccess(this.categories);
}

class ProductSuccess extends CategoriesState {
  final List<ProductModel> products;

  ProductSuccess(this.products);
}

class CategortiesLoading extends CategoriesState {}

class SliderSuccess extends CategoriesState {
  final List<SliderImage> slider;

  SliderSuccess(this.slider);
}

class CelebritiesSuccess extends CategoriesState {
  final List<Celebrity> celebrity;

  CelebritiesSuccess(this.celebrity);
}
