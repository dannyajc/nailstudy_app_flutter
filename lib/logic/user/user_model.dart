import 'package:nailstudy_app_flutter/logic/user/user_course_model.dart';

class UserModel {
  String id;
  bool isAdmin;
  String lastName;
  String firstName;
  String email;
  String avatar;
  String phone;
  String zipCode;
  String address;
  String city;
  List<UserCourseModel> courses;
  List<String> chats;

  UserModel({
    required this.id,
    required this.isAdmin,
    required this.lastName,
    required this.firstName,
    required this.email,
    required this.avatar,
    required this.phone,
    required this.zipCode,
    required this.address,
    required this.city,
    required this.courses,
    required this.chats,
  });

  static UserModel fromJson(dynamic json) {
    return UserModel(
        id: json['id'],
        isAdmin: json['isAdmin'],
        lastName: json['lastName'],
        firstName: json['firstName'],
        email: json['email'],
        avatar: json['avatar'],
        phone: json['phone'],
        zipCode: json['zipCode'],
        address: json['address'],
        city: json['city'],
        courses: json['courses'].length != 0
            ? json['courses']
                .map<UserCourseModel>((obj) => UserCourseModel.fromJson(obj))
                .toList()
            : [],
        chats: json['chats'].cast<String>());
  }
}
