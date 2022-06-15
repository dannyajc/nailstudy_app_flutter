import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nailstudy_app_flutter/constants.dart';
import 'package:nailstudy_app_flutter/logic/chat/chat_model.dart';
import 'package:nailstudy_app_flutter/logic/chat/message_dao.dart';
import 'package:nailstudy_app_flutter/logic/chat/message_model.dart';
import 'package:nailstudy_app_flutter/logic/user/user_model.dart';

import 'widgets/message_bubble.dart';

class SingleChatScreen extends StatefulWidget {
  final ChatModel chat;
  final UserModel endUser;

  const SingleChatScreen({Key? key, required this.chat, required this.endUser})
      : super(key: key);

  @override
  State<SingleChatScreen> createState() => _SingleChatScreenState();
}

class _SingleChatScreenState extends State<SingleChatScreen> {
  final messageDao = MessageDao();
  final _scrollController = ScrollController();
  final _messageController = TextEditingController();

  Widget _getMessageList() {
    return FirebaseAnimatedList(
      controller: _scrollController,
      physics: const BouncingScrollPhysics(),
      reverse: true,
      query: messageDao.getMessageQuery('123'),
      itemBuilder: (context, snapshot, animation, index) {
        final json = snapshot.value as Map<dynamic, dynamic>;
        final message = Message.fromJson(json);
        return MessageBubble(
            text: message.text,
            sentByMe:
                (message.senderId == FirebaseAuth.instance.currentUser?.uid));
      },
    );
  }

  void onSendMessage() {
    // TODO: Fix init chat
    // messageDao.initiateChat('SAkxRuAN2LMAt0KzQNSWF4SK7Qt2',
    //     '8mUfgRObyGgnDbstUl5MuXUSNeo2', '321'),
    var now = DateTime.now().toLocal();
    var formatter = DateFormat("d-M-yyyy HH:mm:ss");
    var formattedDate = formatter.format(now);
    messageDao.sendMessage(
        Message(
            senderId: FirebaseAuth.instance.currentUser?.uid ?? '',
            receiverId: widget.endUser.id,
            timeStamp: formattedDate,
            text: _messageController.text,
            images: []),
        // TODO: Fix chat id
        widget.chat.id);
    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kDefaultBackgroundColor,
        centerTitle: true,
        title: Text(widget.endUser.firstName,
            style: const TextStyle(fontSize: kHeader2, color: kSecondaryColor)),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: kSecondaryColor,
          ),
          iconSize: 20.0,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Flexible(
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: _getMessageList()),
            ),
            Container(
              height: 60,
              padding: const EdgeInsets.symmetric(
                  horizontal: kDefaultPadding, vertical: kDefaultPadding / 2),
              child: CupertinoTextField(
                controller: _messageController,
                placeholder: 'Bericht ...',
                padding: const EdgeInsets.all(kDefaultPadding),
                decoration: BoxDecoration(
                  color: kLightGrey,
                  borderRadius: BorderRadius.circular(30.0),
                ),
                autocorrect: false,
                suffix: Container(
                  margin: const EdgeInsets.symmetric(
                      horizontal: kDefaultPadding / 2),
                  padding: const EdgeInsets.only(left: 2),
                  height: 35,
                  width: 35,
                  decoration: BoxDecoration(
                      color: kSecondaryColor,
                      borderRadius: BorderRadius.circular(30)),
                  child: GestureDetector(
                    onTap: onSendMessage,
                    child: Icon(
                      Icons.send_rounded,
                      size: 25,
                      color: kLightGrey,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
