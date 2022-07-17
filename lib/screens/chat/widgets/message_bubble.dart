import 'package:flutter/material.dart';
import 'package:nailstudy_app_flutter/constants.dart';

class MessageBubble extends StatelessWidget {
  final String? text;
  final bool sentByMe;
  final String timeStamp;

  const MessageBubble({
    Key? key,
    required this.text,
    required this.sentByMe,
    required this.timeStamp,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: sentByMe ? Alignment.topRight : Alignment.topLeft,
      child: Container(
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width * .7),
        margin: const EdgeInsets.only(bottom: kDefaultPadding / 4),
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
            text != null
                ? Flexible(
                    child: Text(
                      text!,
                      style: TextStyle(
                          color: sentByMe ? Colors.white : kSecondaryColor,
                          fontSize: kSubtitle1),
                    ),
                  )
                : Container(),
            Padding(
              padding: const EdgeInsets.only(left: kDefaultPadding),
              child: Text(
                timeStamp,
                style: const TextStyle(color: kGrey, fontSize: kParagraph1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
