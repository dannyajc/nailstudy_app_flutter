import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nailstudy_app_flutter/constants.dart';
import 'package:nailstudy_app_flutter/logic/chat/chat_model.dart';
import 'package:nailstudy_app_flutter/logic/user/user_model.dart';
import 'package:nailstudy_app_flutter/logic/user/user_store.dart';
import 'package:nailstudy_app_flutter/screens/chat/widgets/chat_item.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:provider/provider.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  _ChatsScreenState createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  var _items = [];
  var _users = [];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      await readJson();
    });
  }

  Future<void> readJson() async {
    // TODO: Get the chats array from user
    final String response = await rootBundle.loadString('assets/chat.json');
    final data = await json.decode(response);
    setState(() {
      _items = data["chat"];
    });
  }

  Future<UserModel?> getTalkingTo(int index) async {
    var chat = _items[index];
    var talkingTo = chat["userOne"] != FirebaseAuth.instance.currentUser?.uid
        ? chat["userOne"]
        : chat["userTwo"];
    var user = await Provider.of<UserStore>(context, listen: false)
        .fetchUserById(talkingTo);
    return user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kDefaultBackgroundColor,
        centerTitle: true,
        title: const Text('Chats',
            style: TextStyle(fontSize: kHeader2, color: kSecondaryColor)),
      ),
      body: SafeArea(
          child: RefreshIndicator(
              onRefresh: () {
                // TODO
                return Future.delayed(const Duration(seconds: 2));
              },
              child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: _items.length,
                  itemBuilder: (BuildContext context, int index) {
                    return FutureBuilder<UserModel?>(
                        future: getTalkingTo(index),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            var chat = ChatModel.fromJson(_items[index]);

                            var endUser = snapshot.data;
                            if (endUser != null) {
                              return ChatItem(
                                chat: chat,
                                endUser: endUser,
                              );
                            } else {
                              return Container();
                            }
                          } else {
                            return Container();
                          }
                        });
                  }))),
    );
  }
}
