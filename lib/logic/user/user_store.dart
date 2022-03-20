import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:nailstudy_app_flutter/constants.dart';
import 'package:nailstudy_app_flutter/logic/utils/api_client.dart';

import 'user_model.dart';

class UserStore extends ChangeNotifier {
  UserModel? _user;
  UserModel? get user => _user;
  bool _loading = false;
  bool get loading => _loading;

  Future<void> fetchSelf() async {
    _loading = true;
    notifyListeners();
    var result = await ApiClient().post(Uri.parse(baseUrl + 'getUser'),
        body: jsonEncode({"uid": FirebaseAuth.instance.currentUser?.uid}));
    _user = UserModel.fromJson(jsonDecode(result.body));
    _loading = false;
    notifyListeners();
    return;
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
}
