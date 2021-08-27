class ModelMessage {
  final String toId;
  final String message;

  ModelMessage({this.toId, this.message});

  ModelMessage.fromJson(Map<String, dynamic> json)
      : toId = json["to_id"].toString(),
        message = json["message"];

  toMap() => {"to_id": toId, "message": message};
}
