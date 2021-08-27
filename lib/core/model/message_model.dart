class MessageModel {
  final String toId;
  final String message;

  MessageModel({this.toId, this.message});

  MessageModel.fromJson(Map<String, dynamic> json)
      : toId = json["to_id"].toString(),
        message = json["message"];

  toMap() => {"to_id": toId, "message": message};
}
