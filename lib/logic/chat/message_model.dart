class Message {
  String senderId;
  String receiverId;
  String timeStamp;
  String? text;
  List<String> images;
  String? readAt;
  num? submitForApprovalLevel;
  String? courseId;

  Message({
    required this.senderId,
    required this.receiverId,
    required this.timeStamp,
    this.text,
    required this.images,
    this.readAt,
    this.submitForApprovalLevel,
    this.courseId,
  });

  static Message fromJson(dynamic json) {
    return Message(
        senderId: json['senderId'],
        receiverId: json['receiverId'],
        timeStamp: json['timeStamp'],
        text: json['text'],
        images: (json['images'] != null) ? json['images'].cast<String>() : [],
        readAt: json['readAt'],
        submitForApprovalLevel: json['submitForApprovalLevel'],
        courseId: json['courseId']);
  }

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
        'senderId': senderId,
        'receiverId': receiverId,
        'timeStamp': timeStamp,
        'text': text,
        'images': images,
        'readAt': readAt,
        'submitForApprovalLevel': submitForApprovalLevel,
        'courseId': courseId,
      };
}
