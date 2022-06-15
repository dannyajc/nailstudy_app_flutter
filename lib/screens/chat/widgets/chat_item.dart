import 'package:flutter/cupertino.dart';
import 'package:lottie/lottie.dart';
import 'package:nailstudy_app_flutter/constants.dart';
import 'package:nailstudy_app_flutter/logic/chat/chat_model.dart';
import 'package:nailstudy_app_flutter/logic/user/user_model.dart';
import 'package:nailstudy_app_flutter/screens/chat/single_chat_screen.dart';

class ChatItem extends StatelessWidget {
  final ChatModel chat;
  final UserModel endUser;

  const ChatItem({
    Key? key,
    required this.chat,
    required this.endUser,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        Navigator.push(
            context,
            CupertinoPageRoute(
                builder: (context) => SingleChatScreen(
                      chat: chat,
                      endUser: endUser,
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
                              fontSize: kHeader2, color: kSecondaryColor)),
                      const Text('Hier komt het laatste bericht',
                          style: TextStyle(fontSize: kSubtitle1, color: kGrey)),
                    ],
                  ),
                ),
                const Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text('3min geleden',
                        style: TextStyle(fontSize: kParagraph1, color: kGrey)),
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
  }
}
