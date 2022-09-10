import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:nailstudy_app_flutter/constants.dart';
import 'package:nailstudy_app_flutter/logic/chat/chat_model.dart';
import 'package:nailstudy_app_flutter/logic/chat/message_model.dart';
import 'package:nailstudy_app_flutter/logic/user/user_model.dart';
import 'package:nailstudy_app_flutter/logic/user/user_store.dart';
import 'package:nailstudy_app_flutter/screens/chat/single_chat_screen.dart';
import 'package:provider/provider.dart';

class ChatItem extends StatefulWidget {
  final ChatModel chat;

  const ChatItem({
    Key? key,
    required this.chat,
  }) : super(key: key);

  @override
  State<ChatItem> createState() => _ChatItemState();
}

class _ChatItemState extends State<ChatItem> {
  final ref = FirebaseStorage.instance.ref();

  Future<UserModel?> getEndUser() async {
    var talkingTo =
        widget.chat.userOne != FirebaseAuth.instance.currentUser?.uid
            ? widget.chat.userOne
            : widget.chat.userTwo;
    return await Provider.of<UserStore>(context, listen: false)
        .fetchUserById(talkingTo);
  }

  String getLastReceivedMessageTime(Message message) {
    DateTime expiryDate =
        DateFormat("d-M-yyyy HH:mm:ss").parse(message.timeStamp);

    var timeAgo = expiryDate.difference(DateTime.now());
    var timeAgoInMinutes = timeAgo.inMinutes.toInt().abs();
    var timeAgoInHours = timeAgo.inHours.toInt().abs();
    var timeAgoInDays = timeAgo.inDays.toInt().abs();
    if (timeAgoInMinutes < 60) {
      return '${timeAgoInMinutes}m';
    }
    if (timeAgoInMinutes > 60 && timeAgoInMinutes < 1440) {
      return '${timeAgoInHours}h ${timeAgoInMinutes - (timeAgoInHours * 60)}m';
    }
    if (timeAgoInDays > 0) {
      return '${timeAgoInDays}d';
    }
    return '...';
  }

  Future<String?> getDownloadUrl(avatar) async {
    if (avatar == "") {
      return null;
    }
    var image = ref.child(avatar);
    return image.getDownloadURL();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserModel?>(
        future: getEndUser(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GestureDetector(
              onTap: () => {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => SingleChatScreen(
                              chat: widget.chat,
                              endUser: snapshot.data!,
                            )))
              },
              child: SizedBox(
                height: 80,
                child: Stack(children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: FutureBuilder(
                              future: getDownloadUrl(snapshot.data!.avatar),
                              builder: ((context, snapshot) {
                                return snapshot.hasData
                                    ? CachedNetworkImage(
                                        imageUrl: snapshot.data.toString(),
                                        width: 64,
                                        height: 64,
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) =>
                                            const CircularProgressIndicator
                                                .adaptive(),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                      )
                                    : Image.asset(
                                        'assets/images/default_avatar.png',
                                        width: 64,
                                        height: 64,
                                        fit: BoxFit.cover,
                                      );
                              }),
                            )),
                        Padding(
                          padding: const EdgeInsets.only(left: kDefaultPadding),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  '${snapshot.data!.firstName} ${snapshot.data!.lastName} ',
                                  style: const TextStyle(
                                      fontSize: kHeader2,
                                      color: kSecondaryColor)),
                              // Last received message
                              if (widget.chat.messages.last.text != null)
                                Text(widget.chat.messages.last.text!,
                                    style: const TextStyle(
                                        fontSize: kSubtitle1, color: kGrey))
                              else if (widget
                                  .chat.messages.last.images.isNotEmpty)
                                const Text('Heeft een foto gestuurd',
                                    style: TextStyle(
                                        fontSize: kSubtitle1, color: kGrey))
                              else
                                Container(),
                            ],
                          ),
                        ),
                        // Last message received time
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                                getLastReceivedMessageTime(
                                    widget.chat.messages.last),
                                style: const TextStyle(
                                    fontSize: kParagraph1, color: kGrey)),
                          ),
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    left: 50,
                    top: 5,
                    child: Lottie.asset(
                      'assets/lottie/live.json',
                      repeat: true,
                      width: 30,
                    ),
                  ),
                ]),
              ),
            );
          } else {
            return const Center(
                child: SizedBox(
                    height: 15,
                    width: 15,
                    child: CircularProgressIndicator.adaptive()));
          }
        });
  }
}
