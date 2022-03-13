import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:nailstudy_app_flutter/constants.dart';
import 'package:nailstudy_app_flutter/logic/utils/api_client.dart';

import 'course_model.dart';

class CourseStore extends ChangeNotifier {
  List<CourseModel>? _courses;
  List<CourseModel>? get courses => _courses;
  bool _loading = false;
  bool get loading => _loading;

  Future<void> fetchAllCourses() async {
    _loading = true;
    var result = await ApiClient().get(Uri.parse(baseUrl + 'getAllCourses'));

    _courses = jsonDecode(result.body)
        .map<CourseModel>((course) => CourseModel.fromJson(course))
        .toList();

    _loading = false;
    notifyListeners();
    return;
  }
}
