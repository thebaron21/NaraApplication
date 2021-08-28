import 'package:myapp3/src/logic/handling/handle_categories.dart';

import '../config/end_point.dart';
import '../function/res_function.dart';

class ResCategoryProductCelebrities {
  //
  static Future categories({String name}) async {
    try {
      if (name == null) {
        var data = await ResFunction.getRes(
          url: EndPoint.categoriesUrl,
          headers: ResFunction.withOutToken(),
        );
        return HeadleCategoriesProductBrandCelebrities.categories(data);
      } else {
        var data = await ResFunction.getRes(
          url: EndPoint.categoriesUrl + "?name=$name",
          headers: ResFunction.withOutToken(),
        );
        return HeadleCategoriesProductBrandCelebrities.categories(data);
      }
    } catch (e) {
      throw e;
    }
  }

  static Future categoriesSlider({String name}) async {
    try {
      if (name == null) {
        var data = await ResFunction.getRes(
          url: EndPoint.categoriesUrl,
          headers: ResFunction.withOutToken(),
        );
        return HeadleCategoriesProductBrandCelebrities.categories(data);
      } else {
        var data = await ResFunction.getRes(
          url: EndPoint.categoriesUrl + "?name=$name",
          headers: ResFunction.withOutToken(),
        );
        return HeadleCategoriesProductBrandCelebrities.categories(data);
      }
    } catch (e) {
      throw e;
    }
  }

  static Future celebrities({String name}) async {
    try {
      if (name == null) {
        var data = await ResFunction.getRes(
          url: EndPoint.celebritiesUrl,
          headers: ResFunction.withOutToken(),
        );
        return HeadleCategoriesProductBrandCelebrities.celebrities(data);
      } else {
        var data = await ResFunction.getRes(
          url: EndPoint.celebritiesUrl + "?name=$name",
          headers: ResFunction.withOutToken(),
        );
        return HeadleCategoriesProductBrandCelebrities.celebrities(data);
      }
    } catch (e) {
      throw e;
    }
  }

  static Future celebrities2({String name}) async {
    try {
      if (name == null) {
        var data = await ResFunction.getRes(
          url: EndPoint.celebritiesUrl,
          headers: ResFunction.withOutToken(),
        );
        return HeadleCategoriesProductBrandCelebrities.celebrities(data);
      } else {
        var data = await ResFunction.getRes(
          url: EndPoint.celebritiesUrl + "?name=$name",
          headers: ResFunction.withOutToken(),
        );
        return HeadleCategoriesProductBrandCelebrities.celebrities(data);
      }
    } catch (e) {
      throw e;
    }
  }

  static Future products({String name, String categoryId}) async {
    try {
      if (categoryId == null) {
        if (name == null) {
          var data = await ResFunction.getRes(
            url: EndPoint.productsUrl,
            headers: ResFunction.withOutToken(),
          );
          return HeadleCategoriesProductBrandCelebrities.products(data);
        } else {
          var data = await ResFunction.getRes(
            url: EndPoint.productsUrl + "?name=$name",
            headers: ResFunction.withOutToken(),
          );
          return HeadleCategoriesProductBrandCelebrities.products(data);
        }
      } else {
        var data = await ResFunction.getRes(
          url: EndPoint.productsUrl + "?category_id=$categoryId",
          headers: ResFunction.withOutToken(),
        );
        return HeadleCategoriesProductBrandCelebrities.products(data);
      }
    } catch (e) {
      throw e;
    }
  }

  static Future brands({String name}) async {
    try {
      if (name == null) {
        var data = await ResFunction.getRes(
          url: EndPoint.getBrands,
          headers: ResFunction.withOutToken(),
        );
        return HeadleCategoriesProductBrandCelebrities.brands(data);
      } else {
        var data = await ResFunction.getRes(
          url: EndPoint.getBrands + "?name=$name",
          headers: ResFunction.withOutToken(),
        );
        return HeadleCategoriesProductBrandCelebrities.brands(data);
      }
    } catch (e) {
      throw e;
    }
  }

  static Future getProductBrand({String idBrand}) async {
    try {
      var data = await ResFunction.getRes(
        url: EndPoint.getProductBrand + "/${int.parse(idBrand)}",
        headers: ResFunction.withOutToken(),
      );
      print(data["data"].length);
      if (data["data"].length == 0) {
        return HeadleCategoriesProductBrandCelebrities.productsBrand([]);
      } else {
        return HeadleCategoriesProductBrandCelebrities.productsBrand(
            data["data"]);
      }
    } catch (e) {
      throw e;
    }
  }
}
