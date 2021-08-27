import 'package:myapp3/src/config/end_point.dart';
import 'package:myapp3/src/function/res_function.dart';

class ResCategoryProductCelebrities {
  static Future categories({String name}) async {
    try {
      if (name == null) {
        var data = await ResFunction.getRes(
          url: EndPoint.categoriesUrl,
          headers: ResFunction.withOutToken(),
        );
        return data;
      } else {
        var data = await ResFunction.getRes(
          url: EndPoint.categoriesUrl + "?name=$name",
          headers: ResFunction.withOutToken(),
        );
        return data;
      }
    } catch (e) {
      return e;
    }
  }


  static Future celebrities({String name}) async {
    try {
      if (name == null) {
        var data = await ResFunction.getRes(
          url: EndPoint.celebritiesUrl,
          headers: ResFunction.withOutToken(),
        );
        return data;
      } else {
        var data = await ResFunction.getRes(
          url: EndPoint.celebritiesUrl + "?name=$name",
          headers: ResFunction.withOutToken(),
        );
        return data;
      }
    } catch (e) {
      return e;
    }
  }

  static Future products({String name}) async {
    try {
      if (name == null) {
        var data = await ResFunction.getRes(
          url: EndPoint.productsUrl,
          headers: ResFunction.withOutToken(),
        );
        return data;
      } else {
        var data = await ResFunction.getRes(
          url: EndPoint.productsUrl + "?name=$name",
          headers: ResFunction.withOutToken(),
        );
        return data;
      }
    } catch (e) {
      return e;
    }
  }

  static Future brands({String name}) async {
    try {
      if (name == null) {
        var data = await ResFunction.getRes(
          url: EndPoint.getBrands,
          headers: ResFunction.withOutToken(),
        );
        return data;
      } else {
        var data = await ResFunction.getRes(
          url: EndPoint.getBrands + "?name=$name",
          headers: ResFunction.withOutToken(),
        );
        return data;
      }
    } catch (e) {
      return e;
    }
  }

  static Future getProductBrand({String idBrand}) async {
    try {
      var data = await ResFunction.getRes(
        url: EndPoint.getProductBrand,
        headers: ResFunction.withOutToken(),
      );
      return data;
    } catch (e) {
      return e;
    }
  }
}
