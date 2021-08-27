import 'dart:convert';
import 'dart:io';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:myapp3/config/boxs.dart';
import 'package:myapp3/config/end_point_path.dart';
import 'package:myapp3/core/api/app_exception.dart';
import 'package:myapp3/core/model/complainats_model.dart';
import 'package:myapp3/core/model/message_model.dart';
import 'package:myapp3/core/repoitorites/complainats_repository.dart';
import 'package:myapp3/core/repoitorites/message_repository.dart';

class MessageResponse {
  // ignore: missing_return
  Future<MessageRepository> getMessages() async {
    try {
      http.Response _response;
      String token = Hive.box(Boxs.NaraApp).get("token");
      _response = await http.get(
        Uri.parse(EndPointPath.message),
        headers: {
          "Accept": "application/json",
          'Authorization': 'Bearer $token'
        },
      );

      if (_response.statusCode == 200) {
        var data = json.decode(_response.body);
        if (data["statusCode"] == 200) {
          return MessageRepository.fromMap(data["data"]);
        }
      } else {
        return MessageRepository.withError(
            json.decode(_response.body).toString());
      }
    } on FetchDataException catch (e) {
      return MessageRepository.withError(e.toString());
    } on BadRequestException catch (e) {
      return MessageRepository.withError(e.toString());
    } on InvalidInputException catch (e) {
      return MessageRepository.withError(e.toString());
    } on InternalServerError catch (e) {
      return MessageRepository.withError(e.toString());
    } on SocketException catch (e) {
      return MessageRepository.withError("Not Connected");
    } catch (e) {
      return MessageRepository.withError(e.toString());
    }
  }

  // ignore: missing_return
  Future<MessageRepository> setMessage(MessageModel message) async {
    try {
      http.Response _response;
      String token = Hive.box(Boxs.NaraApp).get("token");

      _response = await http.post(Uri.parse(EndPointPath.message), headers: {
        "Accept": "application/json",
        'Authorization': 'Bearer $token'
      }, body: {
        "message": message.message,
        "to_id": message.toId.toString()
      });

      if (_response.statusCode == 200) {
        var data = json.decode(_response.body);
        if (data["statusCode"] == 200) {
          print(data["data"]);
          return MessageRepository.fromMap([data]);
        }
      } else {
        return MessageRepository.withError(
            json.decode(_response.body).toString());
      }
    } on FetchDataException catch (e) {
      return MessageRepository.withError(e.toString());
    } on BadRequestException catch (e) {
      return MessageRepository.withError(e.toString());
    } on InvalidInputException catch (e) {
      return MessageRepository.withError(e.toString());
    } on InternalServerError catch (e) {
      return MessageRepository.withError(e.toString());
    } on SocketException catch (e) {
      return MessageRepository.withError("Not Connected");
    } catch (e) {
      return MessageRepository.withError(e.toString());
    }
  }

  // ignore: missing_return
  Future<bool> setComplainats(ComplainantsModel complainantsModel) async {
    try {
      http.Response _response;
      String token = Hive.box(Boxs.NaraApp).get("token");

      _response = await http.post(
        Uri.parse(EndPointPath.problam),
        headers: {
          "Accept": "application/json",
          'Authorization': 'Bearer $token'
        },
        body: complainantsModel.toMap(),
      );

      if (_response.statusCode == 200) {
        var data = json.decode(_response.body);
        print(data);
        if (data["statusCode"] == 200) return true;
      } else {
        return false;
      }
    } on FetchDataException catch (e) {
      return false;
    } on BadRequestException catch (e) {
      return false;
    } on InvalidInputException catch (e) {
      print(e.toString());
      return false;
    } on InternalServerError catch (e) {
      print(e.toString());
      return false;
    } on SocketException catch (e) {
      print(e.toString());
      return false;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }
}
