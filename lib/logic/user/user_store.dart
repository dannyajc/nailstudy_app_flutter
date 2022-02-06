import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:nailstudy_app_flutter/constants.dart';
import 'package:nailstudy_app_flutter/logic/utils/api_client.dart';

import 'user_model.dart';

class UserStore extends ChangeNotifier {
  UserModel? _user = null;
  UserModel? get user => _user;

  void fetchSelf() async {
    var result = await ApiClient().post(Uri.parse(baseUrl + 'getUser'),
        body: jsonEncode({"uid": FirebaseAuth.instance.currentUser?.uid}));
    _user = UserModel.fromJson(jsonDecode(result.body));
    notifyListeners();
  }
}
