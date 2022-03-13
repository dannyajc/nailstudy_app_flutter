import 'package:flutter/material.dart';
import 'package:nailstudy_app_flutter/logic/courses/subject_model.dart';

enum MaterialType { theory, practice }

class LessonMaterial {
  MaterialType materialType;
  String name;
  String description;
  String? image;
  List<Subject>? subjects;

  LessonMaterial({
    required this.materialType,
    required this.name,
    required this.description,
    this.image,
    this.subjects,
  });

  static LessonMaterial fromJson(dynamic json) {
    return LessonMaterial(
        materialType: MaterialType.values[json['materialType']],
        name: json['name'],
        description: json['description'],
        image: json['image'] != '' ? json['image'] : null,
        subjects: json['subjects'].length != 0
            ? json['subjects']
                .map<Subject>((obj) => Subject.fromJson(obj))
                .toList()
            : []);
  }
}
