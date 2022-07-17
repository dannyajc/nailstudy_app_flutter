import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:nailstudy_app_flutter/constants.dart';
import 'package:nailstudy_app_flutter/screens/chat/widgets/full_screen_image.dart';
import 'package:collection/collection.dart';

class MessageImageBubble extends StatefulWidget {
  final int index;
  final List<String> images;
  final bool sentByMe;
  final String timeStamp;

  const MessageImageBubble({
    Key? key,
    required this.index,
    required this.images,
    required this.sentByMe,
    required this.timeStamp,
  }) : super(key: key);

  @override
  State<MessageImageBubble> createState() => _MessageImageBubbleState();
}

class _MessageImageBubbleState extends State<MessageImageBubble> {
  final ref = FirebaseStorage.instance.ref();

  Widget getImageColumn(BuildContext context) {
    return FutureBuilder<List<String>>(
      future: Future.wait(widget.images.map((element) {
        var image = ref.child('files/$element');
        return image.getDownloadURL();
      }).toList()),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Column(
            children: [
              ...snapshot.data!.mapIndexed((nestedIndex, element) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: kDefaultPadding / 2),
                  child: GestureDetector(
                    child: Hero(
                      tag: 'imageHero-${widget.index}-$nestedIndex',
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          imageUrl: element,
                          width: 150,
                          height: 150,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return FullScreenImage(
                            heroTag: 'imageHero-${widget.index}-$nestedIndex',
                            url: element);
                      }));
                    },
                  ),
                );
              }),
            ],
          );
        } else {
          // TODO: Error widget
          return const CircularProgressIndicator.adaptive();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: widget.sentByMe ? Alignment.topRight : Alignment.topLeft,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * .7,
        ),
        margin: const EdgeInsets.only(bottom: kDefaultPadding / 4),
        padding: const EdgeInsets.only(
          left: kDefaultPadding / 2,
          right: kDefaultPadding / 2,
          top: kDefaultPadding / 2,
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(15),
              topRight: const Radius.circular(15),
              bottomLeft: widget.sentByMe
                  ? const Radius.circular(15)
                  : const Radius.circular(0),
              bottomRight: widget.sentByMe
                  ? const Radius.circular(0)
                  : const Radius.circular(15),
            ),
            color: widget.sentByMe ? kSecondaryColor : kPrimaryColor),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (widget.images.isNotEmpty)
              getImageColumn(context)
            else
              Container(),
            Padding(
              padding: const EdgeInsets.only(
                  left: kDefaultPadding, bottom: kDefaultPadding / 2),
              child: Text(
                widget.timeStamp,
                style: const TextStyle(color: kGrey, fontSize: kParagraph1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
