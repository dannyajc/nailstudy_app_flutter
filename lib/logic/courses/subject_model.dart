import 'package:nailstudy_app_flutter/logic/courses/paragraph_model.dart';

class Subject {
  String title;
  String description;
  num subjectNumber;
  List<Paragraph>? paragraphs;

  Subject(
      {required this.title,
      required this.description,
      required this.subjectNumber,
      this.paragraphs});

  static Subject fromJson(dynamic json) {
    return Subject(
        title: json['title'],
        description: json['description'],
        subjectNumber: json['subjectNumber'],
        paragraphs: json['paragraphs'].length != 0
            ? json['paragraphs']
                .map<Paragraph>((obj) => Paragraph.fromJson(obj))
                .toList()
            : []);
  }
}
