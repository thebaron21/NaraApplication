import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:myapp3/config/end_point_path.dart';
import 'package:myapp3/core/api/app_exception.dart';
import 'package:myapp3/core/repoitorites/brand_repository.dart';

class BrandResponse {

  
  getBrand(String id) async {
    try {
      http.Response _response;
      _response = await http.get(Uri.parse(EndPointPath.getBrand + "/${id}"));
      if (_response.statusCode == 200) {
        var data = json.decode(_response.body);
        if (data["statusCode"] == 200)
          return BrandRepository.fromMap(data["data"]);
      } else {
        return BrandRepository.withError(
            json.decode(_response.body).toString());
      }
    } on FetchDataException catch (e) {
      return BrandRepository.withError(e.toString());
    } on BadRequestException catch (e) {
      return BrandRepository.withError(e.toString());
    } on InvalidInputException catch (e) {
      return BrandRepository.withError(e.toString());
    } on InternalServerError catch (e) {
      return BrandRepository.withError(e.toString());
    } on SocketException catch (e) {
      return BrandRepository.withError("Not Connected");
    } catch (e) {
      return BrandRepository.withError(e.toString());
    }
  }

  // ignore: missing_return
  Future<BrandRepository> getBrands() async {
    try {
      http.Response _response;
      _response = await http.get(
        Uri.parse(EndPointPath.getBrands),
        headers: {
          "Accept": "application/json",
        },
      );
      if (_response.statusCode == 200) {
        var data = json.decode(_response.body);
        if (data["statusCode"] == 200)
          return BrandRepository.fromMap(data["data"]);
      } else {
        return BrandRepository.withError(
            json.decode(_response.body).toString());
      }
    } on FetchDataException catch (e) {
      return BrandRepository.withError(e.toString());
    } on BadRequestException catch (e) {
      return BrandRepository.withError(e.toString());
    } on InvalidInputException catch (e) {
      return BrandRepository.withError(e.toString());
    } on InternalServerError catch (e) {
      return BrandRepository.withError(e.toString());
    } on SocketException catch (e) {
      return BrandRepository.withError("Not Connected");
    } catch (e) {
      return BrandRepository.withError(e.toString());
    }
  }

  StreamController<BrandRepository> getBrandOnceC =
      StreamController<BrandRepository>.broadcast();
  close3() {
    if (getBrandOnceC.isClosed == false) getBrandOnceC.close();
  }

  Future<BrandRepository> getBrandOnce({String name}) async {
    try {
      http.Response _response;
      if (name != null) {
        _response = await http.get(
          Uri.parse("${EndPointPath.getBrands}?name=$name"),
          headers: {
            "Accept": "application/json",
          },
        );
      } else {
        _response = await http.get(
          Uri.parse(EndPointPath.getBrands),
          headers: {
            "Accept": "application/json",
          },
        );
      }

      if (_response.statusCode == 200) {
        var data = json.decode(_response.body);
        if (data["statusCode"] == 200) {
          print(data);
          getBrandOnceC.sink.add(BrandRepository.fromMap(data["data"]));
          return BrandRepository.fromMap(data["data"]);
        }
      } else {
        getBrandOnceC.sink.add(
            BrandRepository.withError(json.decode(_response.body).toString()));
        return BrandRepository.withError(
            json.decode(_response.body).toString());
      }
    } on FetchDataException catch (e) {
      getBrandOnceC.sink.add(BrandRepository.withError(e.toString()));
      return BrandRepository.withError(e.toString());
    } on BadRequestException catch (e) {
      getBrandOnceC.sink.add(BrandRepository.withError(e.toString()));
      return BrandRepository.withError(e.toString());
    } on InvalidInputException catch (e) {
      getBrandOnceC.sink.add(BrandRepository.withError(e.toString()));
      return BrandRepository.withError(e.toString());
    } on InternalServerError catch (e) {
      getBrandOnceC.sink.add(BrandRepository.withError(e.toString()));
      return BrandRepository.withError(e.toString());
    } on SocketException catch (e) {
      getBrandOnceC.sink.add(BrandRepository.withError("Not Connected"));
      return BrandRepository.withError("Not Connected");
    } catch (e) {
      getBrandOnceC.sink.add(BrandRepository.withError(e.toString()));
      return BrandRepository.withError(e.toString());
    }
  }

  Future<BrandRepository2> getProductBrand(String id) async {
    try {
      http.Response _response;
      // ignore: unnecessary_brace_in_string_interps
      _response = await http
          .get(Uri.parse(EndPointPath.getProductBrand + "/${int.parse(id)}"));
      if (_response.statusCode == 200) {
        var data = json.decode(_response.body);
        if (data["statusCode"] == 200) {
          return BrandRepository2.fromMap(data["data"]);
        }
      } else {
        return BrandRepository2.withError(
            json.decode(_response.body).toString());
      }
    } on FetchDataException catch (e) {
      return BrandRepository2.withError(e.toString());
    } on BadRequestException catch (e) {
      return BrandRepository2.withError(e.toString());
    } on InvalidInputException catch (e) {
      return BrandRepository2.withError(e.toString());
    } on InternalServerError catch (e) {
      return BrandRepository2.withError(e.toString());
    } on SocketException catch (e) {
      return BrandRepository2.withError("Not Connected");
    } catch (e) {
      return BrandRepository2.withError(e.toString());
    }
  }
}
