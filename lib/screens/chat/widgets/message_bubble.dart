import 'package:flutter/material.dart';
import 'package:nailstudy_app_flutter/constants.dart';

class MessageBubble extends StatelessWidget {
  final String text;
  final bool sentByMe;

  const MessageBubble({
    Key? key,
    required this.text,
    required this.sentByMe,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: sentByMe ? Alignment.topRight : Alignment.topLeft,
      child: Container(
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width * .7),
        margin: const EdgeInsets.only(bottom: kDefaultPadding / 2),
        padding: const EdgeInsets.symmetric(
            horizontal: kDefaultPadding, vertical: kDefaultPadding / 2),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(15),
              topRight: const Radius.circular(15),
              bottomLeft: sentByMe
                  ? const Radius.circular(15)
                  : const Radius.circular(0),
              bottomRight: sentByMe
                  ? const Radius.circular(0)
                  : const Radius.circular(15),
            ),
            color: sentByMe ? kSecondaryColor : kPrimaryColor),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Flexible(
              child: Text(
                text,
                style: TextStyle(
                    color: sentByMe ? Colors.white : kSecondaryColor,
                    fontSize: kSubtitle1),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: kDefaultPadding),
              child: Text(
                '12:40',
                style: TextStyle(color: kGrey, fontSize: kParagraph1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
