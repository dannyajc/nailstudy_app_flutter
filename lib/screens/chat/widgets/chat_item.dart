import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:nailstudy_app_flutter/constants.dart';
import 'package:nailstudy_app_flutter/logic/chat/chat_model.dart';
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
  var endUser;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      var talkingTo =
          widget.chat.userOne != FirebaseAuth.instance.currentUser?.uid
              ? widget.chat.userOne
              : widget.chat.userTwo;
      endUser = await Provider.of<UserStore>(context, listen: false)
          .fetchUserById(talkingTo);

      setState(() {
        endUser = endUser;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        Navigator.push(
            context,
            CupertinoPageRoute(
                builder: (context) => SingleChatScreen(
                      chat: widget.chat,
                      endUser: endUser,
                    )))
      },
      child: endUser == null
          ? const Center(child: CircularProgressIndicator.adaptive())
          : SizedBox(
              height: 80,
              child: Stack(children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.asset(
                          'assets/images/profile.jpg',
                          width: 64,
                          height: 64,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: kDefaultPadding),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${endUser.firstName} ${endUser.lastName} ',
                                style: const TextStyle(
                                    fontSize: kHeader2,
                                    color: kSecondaryColor)),
                            // TODO: Fix last received message
                            // const Text('Hier komt het laatste bericht',
                            //     style: TextStyle(
                            //         fontSize: kSubtitle1, color: kGrey)),
                          ],
                        ),
                      ),
                      // TODO: Fix last message received time
                      // const Expanded(
                      //   child: Align(
                      //     alignment: Alignment.centerRight,
                      //     child: Text('3min geleden',
                      //         style: TextStyle(
                      //             fontSize: kParagraph1, color: kGrey)),
                      //   ),
                      // )
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
  }
}
