import 'package:nailstudy_app_flutter/logic/courses/lesson_material_model.dart';

class Lesson {
  String name;
  num lessonNumber;
  LessonMaterial theory;
  LessonMaterial practice;
  String? image;

  Lesson({
    required this.name,
    required this.lessonNumber,
    required this.theory,
    required this.practice,
    this.image,
  });

  static Lesson fromJson(dynamic json) {
    return Lesson(
        name: json['name'],
        lessonNumber: json['lessonNumber'],
        theory: LessonMaterial.fromJson(json['theory']),
        practice: LessonMaterial.fromJson(json['practice']));
  }
}
