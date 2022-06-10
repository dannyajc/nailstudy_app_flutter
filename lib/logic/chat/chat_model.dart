import 'package:nailstudy_app_flutter/logic/chat/message_model.dart';

class ChatModel {
  String id;
  String userOne;
  String userTwo;
  List<Message> messages;

  ChatModel({
    required this.id,
    required this.userOne,
    required this.userTwo,
    required this.messages,
  });

  static ChatModel fromJson(dynamic json) {
    return ChatModel(
        id: json['id'],
        userOne: json['userOne'],
        userTwo: json['userTwo'],
        messages: json['messages'] != null && json['messages'].length != 0
            ? json['messages']
                .map<Message>((obj) => Message.fromJson(obj))
                .toList()
            : []);
  }
}
