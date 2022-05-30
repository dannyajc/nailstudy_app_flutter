import 'package:nailstudy_app_flutter/logic/courses/lesson_model.dart';

class CourseModel {
  String? id;
  String name;
  String description;
  String image;
  num expiryTime;
  List<Lesson>? lessons;

  CourseModel({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.expiryTime,
    this.lessons,
  });

  static CourseModel fromJson(dynamic json) {
    return CourseModel(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        image: json['image'],
        expiryTime: json['expiryTime'],
        lessons: json['lessons'] != null && json['lessons'].length != 0
            ? json['lessons']
                .map<Lesson>((obj) => Lesson.fromJson(obj))
                .toList()
            : []);
  }
}
