import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:nailstudy_app_flutter/constants.dart';
import 'package:nailstudy_app_flutter/screens/chat/widgets/full_screen_image.dart';
import 'package:collection/collection.dart';

class MessageImageBubble extends StatefulWidget {
  final int index;
  final List<String> images;
  final bool sentByMe;

  const MessageImageBubble({
    Key? key,
    required this.index,
    required this.images,
    required this.sentByMe,
  }) : super(key: key);

  @override
  State<MessageImageBubble> createState() => _MessageImageBubbleState();
}

class _MessageImageBubbleState extends State<MessageImageBubble> {
  final ref = FirebaseStorage.instance.ref();
  var images = [];

  Widget getImageColumn(BuildContext context) {
    return Column(
      children: [
        ...images.mapIndexed((nestedIndex, element) {
          return Padding(
            padding: const EdgeInsets.only(bottom: kDefaultPadding / 2),
            child: GestureDetector(
              child: Hero(
                tag: 'imageHero-${widget.index}-$nestedIndex',
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    element,
                    width: 150,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                ),
                // child: Image.network(
                //   'https://images.unsplash.com/photo-1657299170240-a1f811379b57?ixlib=rb-1.2.1&ixid=MnwxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2670&q=80',
                //   fit: BoxFit.scaleDown,
                // ),
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return FullScreenImage(
                      heroTag: 'imageHero-${widget.index}-$nestedIndex',
                      url:
                          'https://images.unsplash.com/photo-1657299170240-a1f811379b57?ixlib=rb-1.2.1&ixid=MnwxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2670&q=80');
                }));
              },
            ),
          );
        }),
      ],
    );
    // return images.map((element) {
    //   return GestureDetector(
    //     child: Hero(
    //       tag: 'imageHero-$index',

    //       child: ClipRRect(
    //         borderRadius: BorderRadius.circular(10),
    //         child: Image.network(
    //           'https://images.unsplash.com/photo-1657299170240-a1f811379b57?ixlib=rb-1.2.1&ixid=MnwxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2670&q=80',
    //           width: 70,
    //           height: 70,
    //           fit: BoxFit.cover,
    //         ),
    //       ),
    //       // child: Image.network(
    //       //   'https://images.unsplash.com/photo-1657299170240-a1f811379b57?ixlib=rb-1.2.1&ixid=MnwxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2670&q=80',
    //       //   fit: BoxFit.scaleDown,
    //       // ),
    //     ),
    //     onTap: () {
    //       Navigator.push(context, MaterialPageRoute(builder: (_) {
    //         return FullScreenImage(
    //             heroTag: 'imageHero-$index',
    //             url:
    //                 'https://images.unsplash.com/photo-1657299170240-a1f811379b57?ixlib=rb-1.2.1&ixid=MnwxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2670&q=80');
    //       }));
    //     },
    //   );
    // }).toList();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var downloadUrls = [];

    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      var q = await Future.wait(widget.images.map((element) {
        var image = ref.child(
            'files/704a969f-0e65-4d51-8aae-c5b19061d8c38461776682177399395.jpg');
        return image.getDownloadURL();
        // downloadUrls.add(await image.getDownloadURL());
        // await widget.images.map((element) async {
        //   print("HALLO");
        //   var image = ref.child('files/$element');
        //   downloadUrls.add(await image.getDownloadURL());
        // });
        // images = downloadUrls;
      }).toList());
      setState(() {
        images = q;
      });
    });
    // });
  }

  @override
  Widget build(BuildContext context) {
    // const ref = FirebaseStorage.instance.ref().child()

    return Align(
      alignment: widget.sentByMe ? Alignment.topRight : Alignment.topLeft,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * .7,
          // maxHeight: MediaQuery.of(context).size.height * .3),
        ),
        margin: const EdgeInsets.only(bottom: kDefaultPadding / 4),
        padding: const EdgeInsets.only(
            left: kDefaultPadding / 2,
            right: kDefaultPadding / 2,
            top: kDefaultPadding / 2),
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
            if (images.isNotEmpty) getImageColumn(context) else Container(),
            // GestureDetector(
            //   child: Hero(
            //     tag: 'imageHero-$index',

            //     child: ClipRRect(
            //       borderRadius: BorderRadius.circular(10),
            //       child: Image.network(
            //         'https://images.unsplash.com/photo-1657299170240-a1f811379b57?ixlib=rb-1.2.1&ixid=MnwxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2670&q=80',
            //         width: 150,
            //         height: 150,
            //         fit: BoxFit.cover,
            //       ),
            //     ),
            //     // child: Image.network(
            //     //   'https://images.unsplash.com/photo-1657299170240-a1f811379b57?ixlib=rb-1.2.1&ixid=MnwxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2670&q=80',
            //     //   fit: BoxFit.scaleDown,
            //     // ),
            //   ),
            //   onTap: () {
            //     Navigator.push(context, MaterialPageRoute(builder: (_) {
            //       return FullScreenImage(
            //           heroTag: 'imageHero-$index',
            //           url:
            //               'https://images.unsplash.com/photo-1657299170240-a1f811379b57?ixlib=rb-1.2.1&ixid=MnwxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2670&q=80');
            //     }));
            //   },
            // ),
            const Padding(
              padding: EdgeInsets.only(left: kDefaultPadding),
              child: Text(
                // TODO: Fix time
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
