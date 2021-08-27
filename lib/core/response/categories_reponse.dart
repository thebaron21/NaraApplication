import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:myapp3/config/end_point_path.dart';
import 'package:myapp3/core/api/app_exception.dart';
import 'package:myapp3/core/repoitorites/categories_repoitory.dart';
import 'package:myapp3/core/repoitorites/celebrity_repoitory.dart';
import 'package:myapp3/core/repoitorites/product_respoitory.dart';
import 'package:myapp3/core/repoitorites/slider_repoitory.dart';

class CategoriesResponse {
  Future<CategoriesRespoitory> getFilteredCategories(
      {String limit, String name}) async {
    var params = {
      'limit': limit,
      'name': name,
    };

    http.Response _response;
    try {
      _response = await http.get(
          Uri.parse(EndPointPath.categoriesUrl + "?limit=$limit"),
          headers: params);
      var body = json.decode(_response.body);
      if (body["statusCode"] == 200) {
        return CategoriesRespoitory.fromMap(json.decode(_response.body));
      } else {
        return CategoriesRespoitory.withError(body);
      }
    } on FetchDataException catch (e) {
      return CategoriesRespoitory.withException("Fetch Data Exception");
    } on BadRequestException catch (e) {
      return CategoriesRespoitory.withException("Bad Request Exception");
    } on InvalidInputException catch (e) {
      return CategoriesRespoitory.withException("Invalid Input Exception");
    } on InternalServerError catch (e) {
      return CategoriesRespoitory.withException("Internal Server Error");
    } on SocketException catch (e) {
      return CategoriesRespoitory.withException("Not Connected");
    }
  }

  Future<CategoriesRespoitory> getCategories() async {
    http.Response _response;
    try {
      _response = await http.get(
        Uri.parse(EndPointPath.categoriesUrl),
      );
      var body = json.decode(_response.body);
      if (body["statusCode"] == 200) {
        return CategoriesRespoitory.fromMap(json.decode(_response.body));
      } else {
        return CategoriesRespoitory.withError(body);
      }
    } on FetchDataException catch (e) {
      return CategoriesRespoitory.withException("Fetch Data Exception");
    } on BadRequestException catch (e) {
      return CategoriesRespoitory.withException("Bad Request Exception");
    } on InvalidInputException catch (e) {
      return CategoriesRespoitory.withException("Invalid Input Exception");
    } on InternalServerError catch (e) {
      return CategoriesRespoitory.withException("Internal Server Error");
    } on SocketException catch (e) {
      return CategoriesRespoitory.withException("Not Connected");
    }
  }

  Future<ProductModelRespoitory> getCategoryProducts({String id}) async {
    http.Response _response;
    try {
      _response = await http.get(Uri.parse(EndPointPath.productsUrl), headers: {
        "connection": "Keep-Alive",
        "Keep-Alive": "timeout=2, max=100000"
      });
      var body = json.decode(_response.body);
      if (body["statusCode"] == 200) {
        return ProductModelRespoitory.fromMap(json.decode(_response.body));
      } else if (body["statusCode"] == 404) {
        var error = json.decode(_response.body);
        return ProductModelRespoitory.withException(error["error"]);
      } else {
        return ProductModelRespoitory.withError(body);
      }
    } on FetchDataException catch (e) {
      return ProductModelRespoitory.withException("Fetch Data Exception");
    } on BadRequestException catch (e) {
      return ProductModelRespoitory.withException("Bad Request Exception");
    } on InvalidInputException catch (e) {
      return ProductModelRespoitory.withException("Invalid Input Exception");
    } on InternalServerError catch (e) {
      return ProductModelRespoitory.withException("Internal Server Error");
    } on SocketException catch (e) {
      return ProductModelRespoitory.withException("Not Connected");
    }
  }

  Future<ProductModelRespoitory> getFilteredProducts(
      {String limit,
      String name,
      String priceFrom,
      String priceTo,
      String categoryID,
      String option}) async {
    http.Response _response;
    Map<String, String> data = {
      'limit': limit,
      'priceFrom': priceFrom,
      'priceTo': priceTo,
      'category_id': categoryID,
      'filterProducts': option,
      "connection": "Keep-Alive",
      "Keep-Alive": "timeout=2, max=100000"
    };

    try {
      if (name != null)
        _response = await http.get(
            Uri.parse("${EndPointPath.productsUrl}?name=$name"),
            headers: data);
      else
        _response =
            await http.get(Uri.parse(EndPointPath.productsUrl), headers: data);
      var body = json.decode(_response.body);
      if (body["statusCode"] == 200) {
        return ProductModelRespoitory.fromMap(json.decode(_response.body));
      } else if (body["statusCode"] == 404) {
        var error = json.decode(_response.body);
        return ProductModelRespoitory.withException(error["error"]);
      } else {
        return ProductModelRespoitory.withError(body);
      }
    } on FetchDataException catch (e) {
      return ProductModelRespoitory.withException("Fetch Data Exception");
    } on BadRequestException catch (e) {
      return ProductModelRespoitory.withException("Bad Request Exception");
    } on InvalidInputException catch (e) {
      return ProductModelRespoitory.withException("Invalid Input Exception");
    } on InternalServerError catch (e) {
      return ProductModelRespoitory.withException("Internal Server Error");
    } on SocketException catch (e) {
      return ProductModelRespoitory.withException("Not Connected");
    }
  }

  /*
 
  */
  StreamController<ProductModelRespoitory> getOnceProduct =
      StreamController<ProductModelRespoitory>.broadcast();
  close2() {
    if (getOnceProduct.isClosed == false) getOnceProduct.close();
  }

  Future<ProductModelRespoitory> getOnceProductFun(
      {String limit,
      String name,
      String priceFrom,
      String priceTo,
      String categoryID,
      String option}) async {
    http.Response _response;

    try {
      if (name == null && categoryID != null) {
        print("Ok 1");
        _response = await http.get(
          Uri.parse(
            "${EndPointPath.productsUrl}?category_id=$categoryID",
          ),
        );
      } else if (categoryID != null) {
        print("Ok");
        _response = await http.get(
          Uri.parse(
            "${EndPointPath.productsUrl}?category_id=$categoryID",
          ),
        );
      } else {
        _response =
            await http.get(Uri.parse("${EndPointPath.productsUrl}?name=$name"));
      }
      var body = json.decode(_response.body);
      print(body);
      if (body["statusCode"] == 200) {
        getOnceProduct.sink
            .add(ProductModelRespoitory.fromMap(json.decode(_response.body)));
        return ProductModelRespoitory.fromMap(json.decode(_response.body));
      } else if (body["statusCode"] == 404) {
        var error = json.decode(_response.body);
        getOnceProduct.sink
            .add(ProductModelRespoitory.withException(error["error"]));
        return ProductModelRespoitory.withException(error["error"]);
      } else {
        getOnceProduct.sink.add(ProductModelRespoitory.withError(body));
        return ProductModelRespoitory.withError(body);
      }
    } on FetchDataException catch (e) {
      getOnceProduct.sink
          .add(ProductModelRespoitory.withException("Fetch Data Exception"));
      return ProductModelRespoitory.withException("Fetch Data Exception");
    } on BadRequestException catch (e) {
      getOnceProduct.sink
          .add(ProductModelRespoitory.withException("Bad Request Exception"));
      return ProductModelRespoitory.withException("Bad Request Exception");
    } on InvalidInputException catch (e) {
      getOnceProduct.sink
          .add(ProductModelRespoitory.withException("Invalid Input Exception"));
      return ProductModelRespoitory.withException("Invalid Input Exception");
    } on InternalServerError catch (e) {
      getOnceProduct.sink
          .add(ProductModelRespoitory.withException("Internal Server Error"));
      return ProductModelRespoitory.withException("Internal Server Error");
    } on SocketException catch (e) {
      getOnceProduct.sink
          .add(ProductModelRespoitory.withException("Not Connected"));
      return ProductModelRespoitory.withException("Not Connected");
    }
  }

//-----------------------------------------------------------
  Future<SliderModelRespoitory> getSliderImage() async {
    http.Response _response;
    try {
      _response = await http.get(Uri.parse(EndPointPath.categoriesUrl),
          headers: {
            "connection": "Keep-Alive",
            "Keep-Alive": "timeout=2, max=100000"
          });
      var body = json.decode(_response.body);
      if (body["statusCode"] == 200) {
        return SliderModelRespoitory.fromMap(json.decode(_response.body));
      } else if (body["statusCode"] == 404) {
        var error = json.decode(_response.body);
        return SliderModelRespoitory.withException(error["error"]);
      } else {
        return SliderModelRespoitory.withError(body);
      }
    } on FetchDataException catch (e) {
      return SliderModelRespoitory.withException("Fetch Data Exception");
    } on BadRequestException catch (e) {
      return SliderModelRespoitory.withException("Bad Request Exception");
    } on InvalidInputException catch (e) {
      return SliderModelRespoitory.withException("Invalid Input Exception");
    } on InternalServerError catch (e) {
      return SliderModelRespoitory.withException("Internal Server Error");
    } on SocketException catch (e) {
      return SliderModelRespoitory.withException("Not Connected");
    }
  }

  //
  Future<CelebrityRepoitory> getCelebrities() async {
    http.Response _response;
    try {
      _response =
          await http.get(Uri.parse(EndPointPath.celebritiesUrl), headers: {
        // "connection": "Keep-Alive",
        // "Keep-Alive": "timeout=2, max=100000"
      });
      var body = json.decode(_response.body);
      if (body["statusCode"] == 200) {
        return CelebrityRepoitory.fromMap(json.decode(_response.body));
      } else if (body["statusCode"] == 404) {
        var error = json.decode(_response.body);
        return CelebrityRepoitory.withException(error["error"]);
      } else {
        return CelebrityRepoitory.withError(body);
      }
    } on FetchDataException catch (e) {
      return CelebrityRepoitory.withException("Fetch Data Exception");
    } on BadRequestException catch (e) {
      return CelebrityRepoitory.withException("Bad Request Exception");
    } on InvalidInputException catch (e) {
      return CelebrityRepoitory.withException("Invalid Input Exception");
    } on InternalServerError catch (e) {
      return CelebrityRepoitory.withException("Internal Server Error");
    } on SocketException catch (e) {
      return CelebrityRepoitory.withException("Not Connected");
    }
  }

  StreamController<CelebrityRepoitory> getOnce =
      StreamController<CelebrityRepoitory>.broadcast();
  close() {
    if (getOnce.isClosed == false) getOnce.close();
  }

  Future<CelebrityRepoitory> getCelebritOnce({String name}) async {
    http.Response _response;
    try {
      if (name == null) {
        _response = await http.get(
          Uri.parse("http://larra.xyz/api/celeberities"),
        );
      } else {
        _response = await http.get(
          Uri.parse("http://larra.xyz/api/celeberities?name=$name"),
        );
      }
      var body = json.decode(_response.body);
      print(body);
      if (body["statusCode"] == 200) {
        getOnce.sink
            .add(CelebrityRepoitory.fromMap(json.decode(_response.body)));
        return CelebrityRepoitory.fromMap(json.decode(_response.body));
      } else if (body["statusCode"] == 404) {
        var error = json.decode(_response.body);
        return CelebrityRepoitory.withException(error["error"]);
      } else {
        getOnce.sink.add(CelebrityRepoitory.withError(body));
        return CelebrityRepoitory.withError(body);
      }
    } on FetchDataException catch (e) {
      getOnce.sink.add(CelebrityRepoitory.withException(e.toString()));
      return CelebrityRepoitory.withException("Fetch Data Exception");
    } on BadRequestException catch (e) {
      getOnce.sink.add(CelebrityRepoitory.withException(e.toString()));
      return CelebrityRepoitory.withException("Bad Request Exception");
    } on InvalidInputException catch (e) {
      getOnce.sink.add(CelebrityRepoitory.withException(e.toString()));
      return CelebrityRepoitory.withException("Invalid Input Exception");
    } on InternalServerError catch (e) {
      getOnce.sink.add(CelebrityRepoitory.withException(e.toString()));
      return CelebrityRepoitory.withException("Internal Server Error");
    } on SocketException catch (e) {
      getOnce.sink.add(CelebrityRepoitory.withException(e.toString()));
      return CelebrityRepoitory.withException("Not Connected");
    }
  }
}
