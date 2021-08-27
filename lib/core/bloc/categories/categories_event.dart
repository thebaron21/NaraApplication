part of 'categories_bloc.dart';

@immutable
abstract class CategoriesEvent {}

class InitialCategories extends CategoriesEvent {}

class GetProductsOfCategory extends CategoriesEvent {
  final String index;

  GetProductsOfCategory(this.index);
}

class GetSliderImage extends CategoriesEvent {}

class GetCelebrities extends CategoriesEvent {}
