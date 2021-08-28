import 'package:myapp3/src/logic/repository/repoitory_categories.dart';
import 'package:myapp3/src/logic/repository/repoitory_celebrities.dart';
import 'package:myapp3/src/logic/repository/repoitory_products.dart';
import 'package:myapp3/src/logic/repository/repository_brand.dart';

class HeadleCategoriesProductBrandCelebrities {
  static RespoitoryCategories categories(var data) {
    return RespoitoryCategories.fromMap(data);
  }

  static RepositoryBrand brands(var data) {
    return RepositoryBrand.fromMap(data);
  }

  static RepositoryProduct products(var data) {
    return RepositoryProduct.fromMap(data);
  }

  static RepositoryCelebrities celebrities(var data) {
    return RepositoryCelebrities.fromMap(data);
  }

  static RepositoryProduct productsBrand(var data) {
    return RepositoryProduct.from(data);
  }
}
