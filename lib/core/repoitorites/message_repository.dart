import 'package:myapp3/core/model/message_model.dart';

class MessageRepository {
  List<MessageModel> messages;
  String error;
  MessageRepository.fromMap(var json)
      : messages = (json as List).map((e) => MessageModel.fromJson(e)).toList(),
        error = null;

  MessageRepository.withError(e)
      : messages = List(),
        error = e.toString();
}
