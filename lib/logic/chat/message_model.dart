import 'package:nailstudy_app_flutter/logic/courses/lesson_model.dart';

class Message {
  String senderId;
  String receiverId;
  String timeStamp;
  String? text;
  List<String> images;
  String? readAt;
  num? submitForApprovalLevel;

  Message({
    required this.senderId,
    required this.receiverId,
    required this.timeStamp,
    this.text,
    required this.images,
    this.readAt,
    this.submitForApprovalLevel,
  });

  static Message fromJson(dynamic json) {
    return Message(
        senderId: json['senderId'],
        receiverId: json['receiverId'],
        timeStamp: json['timeStamp'],
        text: json['text'],
        images: json['images'].cast<String>(),
        readAt: json['readAt'],
        submitForApprovalLevel: json['submitForApprovalLevel']);
  }
}
