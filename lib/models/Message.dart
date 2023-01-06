import 'package:kranite/data/consts.dart';

class Message {
  late String sender;
  late String receiver;
  late String content;
  late MessageType type;
  late String created_at;

  Message({
    required this.sender,
    required this.receiver,
    required this.content,
    required this.type,
  }) : this.created_at = DateTime.now().toString();

  Message.fromJson(Map<String, dynamic> json) {
    this.sender = json["sender"];
    this.receiver = json["receiver"];
    this.content = json["content"];
    this.type = json["type"];
    this.created_at = json["created_at"];
  }

  Map<String, dynamic> toJson() {
    return {
      "sender": this.sender,
      "receiver": this.receiver,
      "content": this.content,
      "type": this.type,
      "created_at": this.created_at,
    };
  }
}
