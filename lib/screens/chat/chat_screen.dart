import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nailstudy_app_flutter/constants.dart';
import 'package:nailstudy_app_flutter/logic/chat/chat_model.dart';
import 'package:nailstudy_app_flutter/screens/chat/widgets/chat_item.dart';
import 'package:flutter/services.dart' show rootBundle;

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  var _items = [];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      readJson();
    });
  }

  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/chat.json');
    final data = await json.decode(response);
    setState(() {
      _items = data["chat"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kDefaultBackgroundColor,
        centerTitle: true,
        title: const Text('Chat',
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
              var chat = ChatModel.fromJson(_items[index]);
              return ChatItem(
                chat: chat,
              );
            }),
      )),
    );
  }
}
