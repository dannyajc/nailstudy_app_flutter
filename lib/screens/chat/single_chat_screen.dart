import 'dart:async';

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
import 'package:nailstudy_app_flutter/logic/user/user_course_model.dart';
import 'package:nailstudy_app_flutter/logic/user/user_model.dart';
import 'package:nailstudy_app_flutter/screens/chat/widgets/approval_item.dart';
import 'package:nailstudy_app_flutter/screens/chat/widgets/message_image_bubble.dart';
import 'package:nailstudy_app_flutter/utils/spacing.dart';

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
      query: messageDao.getMessageQuery(widget.chat.id).orderByValue(),
      itemBuilder: (context, snapshot, animation, index) {
        final json = snapshot.value as Map<dynamic, dynamic>;
        final message = Message.fromJson(json);

        // Timestamp for every single message
        var formatter = DateFormat("d-M-yyyy HH:mm:ss");
        var hours = formatter.parse(message.timeStamp).hour.toString();
        var minutes = formatter.parse(message.timeStamp).minute.toInt();

        var minuteString = minutes < 10 ? '0$minutes' : minutes.toString();
        var timeStamp = hours + ':' + minuteString;

        if (message.images.isNotEmpty) {
          return MessageImageBubble(
              index: index,
              images: message.images,
              sentByMe:
                  message.senderId == FirebaseAuth.instance.currentUser?.uid,
              timeStamp: timeStamp);
        }
        return MessageBubble(
            text: message.text?.trim(),
            sentByMe:
                message.senderId == FirebaseAuth.instance.currentUser?.uid,
            timeStamp: timeStamp);
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
            text: _messageController.text.trim(),
            images: []),
        // TODO: Fix chat id
        widget.chat.id);
    _scrollController.animateTo(_scrollController.position.maxScrollExtent + 40,
        duration: const Duration(milliseconds: 250), curve: Curves.easeInOut);
    _messageController.clear();
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 500), () {
        _scrollController.animateTo(
            _scrollController.position.maxScrollExtent + 150,
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut);
      });
    });
  }

  List<ApprovalItem> getPendingApprovals(List<UserCourseModel> courses) {
    List<UserCourseModel> pendingCourses = [];
    courses.forEach((course) {
      if (course.pendingApproval) {
        pendingCourses.add(course);
      }
    });

    return pendingCourses
        .map((e) => ApprovalItem(courseName: e.courseId))
        .toList();
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
        actions: [
          IconButton(
              onPressed: () {
                showModalBottomSheet<void>(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(30),
                    ),
                  ),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  context: context,
                  builder: (BuildContext context) {
                    return SingleChildScrollView(
                      child: Wrap(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(kDefaultPadding),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  height: 6,
                                  width: 100,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(2),
                                      color: kPrimaryColor),
                                ),
                                addVerticalSpace(),
                                const Text(
                                    'De volgende cursussen moeten nog worden goedgekeurd',
                                    style: TextStyle(
                                        fontSize: kHeader2,
                                        color: kSecondaryColor)),
                                addVerticalSpace(),
                                addVerticalSpace(),
                                ...getPendingApprovals(widget.endUser.courses),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              icon: const Icon(Icons.pending_actions_outlined),
              color: kGrey)
        ],
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
