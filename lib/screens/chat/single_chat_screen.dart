import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nailstudy_app_flutter/constants.dart';
import 'package:nailstudy_app_flutter/logic/chat/chat_model.dart';

import 'widgets/message_bubble.dart';

class SingleChatScreen extends StatelessWidget {
  final ChatModel chat;

  const SingleChatScreen({Key? key, required this.chat}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kDefaultBackgroundColor,
        centerTitle: true,
        title: const Text('Gaillion Cordua',
            style: TextStyle(fontSize: kHeader2, color: kSecondaryColor)),
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
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  reverse: true,
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: const [
                      MessageBubble(
                        text:
                            'Ik heb zojuist je praktijk les 1 goedgekeurd! Goed bezig. Je kan nu direct door naar les 2 ;)',
                        sentByMe: true,
                      ),
                      MessageBubble(
                        text: 'Super bedankt!',
                        sentByMe: false,
                      ),
                      MessageBubble(
                        text: 'Ik ga meteen beginnen',
                        sentByMe: false,
                      ),
                      MessageBubble(
                        text:
                            'Ik heb zojuist je praktijk les 1 goedgekeurd! Goed bezig. Je kan nu direct door naar les 2 ;)',
                        sentByMe: true,
                      ),
                      MessageBubble(
                        text: 'Super bedankt!',
                        sentByMe: false,
                      ),
                      MessageBubble(
                        text: 'Ik ga meteen beginnen',
                        sentByMe: false,
                      ),
                      MessageBubble(
                        text:
                            'Ik heb zojuist je praktijk les 1 goedgekeurd! Goed bezig. Je kan nu direct door naar les 2 ;)',
                        sentByMe: true,
                      ),
                      MessageBubble(
                        text: 'Super bedankt!',
                        sentByMe: false,
                      ),
                      MessageBubble(
                        text: 'Ik ga meteen beginnen',
                        sentByMe: false,
                      ),
                      MessageBubble(
                        text:
                            'Ik heb zojuist je praktijk les 1 goedgekeurd! Goed bezig. Je kan nu direct door naar les 2 ;)',
                        sentByMe: true,
                      ),
                      MessageBubble(
                        text: 'Super bedankt!',
                        sentByMe: false,
                      ),
                      MessageBubble(
                        text: 'Ik ga meteen beginnen',
                        sentByMe: false,
                      ),
                      MessageBubble(
                        text:
                            'Ik heb zojuist je praktijk les 1 goedgekeurd! Goed bezig. Je kan nu direct door naar les 2 ;)',
                        sentByMe: true,
                      ),
                      MessageBubble(
                        text: 'Super bedankt!',
                        sentByMe: false,
                      ),
                      MessageBubble(
                        text: 'Ik ga meteen beginnen',
                        sentByMe: false,
                      ),
                      MessageBubble(
                        text:
                            'Ik heb zojuist je praktijk les 1 goedgekeurd! Goed bezig. Je kan nu direct door naar les 2 ;)',
                        sentByMe: true,
                      ),
                      MessageBubble(
                        text: 'Super bedankt!',
                        sentByMe: false,
                      ),
                      MessageBubble(
                        text: 'Ik ga meteen beginnen',
                        sentByMe: false,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              height: 60,
              padding: const EdgeInsets.symmetric(
                  horizontal: kDefaultPadding, vertical: kDefaultPadding / 2),
              child: CupertinoTextField(
                // controller: emailController,
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
                  child: Icon(
                    Icons.send_rounded,
                    size: 25,
                    color: kLightGrey,
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
