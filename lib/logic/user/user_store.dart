import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:nailstudy_app_flutter/constants.dart';
import 'package:nailstudy_app_flutter/logic/user/user_course_model.dart';
import 'package:nailstudy_app_flutter/logic/utils/api_client.dart';
import 'package:nailstudy_app_flutter/logic/utils/auth_status.dart';

import 'user_model.dart';

class UserStore extends ChangeNotifier {
  UserModel? _user;
  UserModel? get user => _user;

  UserCourseModel? _currentCourse;
  UserCourseModel? get currentCourse => _currentCourse;

  bool _loading = false;
  bool get loading => _loading;

  AuthStatus _authStatus = AuthStatus.unknown;
  AuthStatus get authStatus => _authStatus;

  Future<void> fetchSelf({bool shouldNotify = true}) async {
    _loading = true;
    if (shouldNotify) notifyListeners();
    var result = await ApiClient().post(Uri.parse(baseUrl + 'getUser'),
        body: jsonEncode({"userId": FirebaseAuth.instance.currentUser?.uid}));
    try {
      _user = UserModel.fromJson(jsonDecode(result.body));
      _authStatus = AuthStatus.successful;
    } on FirebaseAuthException catch (e) {
      _authStatus = AuthExceptionHandler.handleAuthException(e);
    }
    _loading = false;
    if (shouldNotify) notifyListeners();
    return;
  }

  Future<void> modifyAvatar(String avatarPath) async {
    _loading = true;
    notifyListeners();

    await ApiClient().post(Uri.parse(baseUrl + 'modifyUser'),
        body: jsonEncode({
          "userId": FirebaseAuth.instance.currentUser?.uid,
          "avatar": avatarPath
        }));

    notifyListeners();
    _loading = false;
    return;
  }

  Future<UserModel?> fetchUserById(String id) async {
    _loading = true;
    var result = await ApiClient().post(Uri.parse(baseUrl + 'getUserById'),
        body: jsonEncode({"userId": id}));
    var user = UserModel.fromJson(jsonDecode(result.body));
    _loading = false;
    return user;
  }

  Future<void> registerUser(String firstName, String lastName, String email,
      String password, String phone) async {
    _loading = true;

    var result = await ApiClient().post(Uri.parse(baseUrl + 'createUser'),
        body: jsonEncode({
          "name": firstName,
          "lastName": lastName,
          "phone": phone,
          "password": password,
          "email": email
        }));
    _user = UserModel.fromJson(jsonDecode(result.body));
    _loading = false;
    notifyListeners();
    return;
  }

  Future<AuthStatus> resetPassword({required String email}) async {
    await FirebaseAuth.instance
        .sendPasswordResetEmail(email: email)
        .then((value) => _authStatus = AuthStatus.successful)
        .catchError(
            (e) => _authStatus = AuthExceptionHandler.handleAuthException(e));
    return _authStatus;
  }

  Future<String?> activateCourse(String licenseCode) async {
    _loading = true;
    notifyListeners();
    var result = await ApiClient().post(
        Uri.parse(baseUrl + 'activateUserCourse'),
        body: jsonEncode({
          "userId": FirebaseAuth.instance.currentUser?.uid,
          "licenseCode": licenseCode
        }));
    fetchSelf();
    _loading = false;
    notifyListeners();
    if (result.statusCode == 404) {
      return null;
    }
    var response = jsonDecode(result.body);
    return response['course']['courseId'].toString();
  }

  Future<void> setCurrentUserCourse(UserCourseModel userCourse) async {
    _loading = true;
    notifyListeners();

    _currentCourse = userCourse;

    _loading = false;
    notifyListeners();
  }

  Future<void> setNewPendingApproval(String courseId) async {
    _loading = true;
    notifyListeners();
    var result = await ApiClient().post(
        Uri.parse(baseUrl + 'newPendingApproval'),
        body: jsonEncode({
          "userId": FirebaseAuth.instance.currentUser?.uid,
          "courseId": courseId
        }));
    if (result.statusCode != 404) {
      _user = UserModel.fromJson(jsonDecode(result.body));
    }
    _loading = false;
    notifyListeners();
  }

  Future<void> approveLesson(String courseId, String userId) async {
    _loading = true;
    notifyListeners();
    await ApiClient().post(Uri.parse(baseUrl + 'approveLesson'),
        body: jsonEncode({"userId": userId, "courseId": courseId}));
    _loading = false;
    notifyListeners();
  }

  Future<void> updateSubjectNumber(String courseId) async {
    _loading = true;
    notifyListeners();
    var result = await ApiClient().post(
        Uri.parse(baseUrl + 'updateSubjectNumber'),
        body: jsonEncode({
          "userId": FirebaseAuth.instance.currentUser?.uid,
          "courseId": courseId
        }));
    if (result.statusCode != 404) {
      _user = UserModel.fromJson(jsonDecode(result.body));
    }
    _loading = false;
    notifyListeners();
  }

  Future<void> finishLesson(String courseId) async {
    _loading = true;
    notifyListeners();
    var result = await ApiClient().post(Uri.parse(baseUrl + 'finishLesson'),
        body: jsonEncode({
          "userId": FirebaseAuth.instance.currentUser?.uid,
          "courseId": courseId
        }));
    if (result.statusCode != 404) {
      _user = UserModel.fromJson(jsonDecode(result.body));
    }
    _loading = false;
    notifyListeners();
  }

  Future<String?> getChatId() async {
    _loading = true;
    notifyListeners();
    var result = await ApiClient().post(Uri.parse(baseUrl + 'newChat'),
        body: jsonEncode({
          "userId": FirebaseAuth.instance.currentUser?.uid,
          "receiverId": adminId
        }));
    if (result.statusCode != 404) {
      return result.body;
    }
    _loading = false;
    notifyListeners();
    return null;
  }
}
