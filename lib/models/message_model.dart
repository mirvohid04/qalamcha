class MessageModel {
  String? id;
  String? senderId;
  String? receiverId;
  String? text;
  String? status;
  String? createdAt;

  MessageModel(
      {this.id, this.senderId, this.receiverId, this.text, this.status, this.createdAt});

  MessageModel copyWith(
      {String? id, String? senderId, String? receiverId, String? text, String? status, String? createdAt}) =>
      MessageModel(id: id ?? this.id,
          senderId: senderId ?? this.senderId,
          receiverId: receiverId ?? this.receiverId,
          text: text ?? this.text,
          status: status ?? this.status,
          createdAt: createdAt ?? this.createdAt);

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map["id"] = id;
    map["senderId"] = senderId;
    map["receiverId"] = receiverId;
    map["text"] = text;
    map["status"] = status;
    map["createdAt"] = createdAt;
    return map;
  }

  MessageModel.fromJson(dynamic json){
    id = json["id"];
    senderId = json["senderId"];
    receiverId = json["receiverId"];
    text = json["text"];
    status = json["status"];
    createdAt = json["createdAt"];
  }
}