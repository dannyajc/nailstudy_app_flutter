import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nailstudy_app_flutter/constants.dart';
import 'package:nailstudy_app_flutter/utils/shadow_image.dart';
import 'package:nailstudy_app_flutter/utils/spacing.dart';

class SubjectParagraph extends StatelessWidget {
  final List<String>? imageUrls;
  final String text;
  final String title;

  const SubjectParagraph(
      {Key? key, this.imageUrls, required this.text, required this.title})
      : super(key: key);

  List<Widget> getImages() {
    return imageUrls!.map((e) => ShadowImage(image: e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: kSubtitle1, color: kSecondaryColor),
        ),
        addVerticalSpace(),
        imageUrls != null && imageUrls!.isNotEmpty
            ? Column(children: [...getImages()])
            : Container(
                height: 0,
              ),
        Text(
          text.replaceAll('\\n', '\n'),
          style: const TextStyle(fontSize: kParagraph1, color: kGrey),
        ),
        addVerticalSpace(),
        const Divider(
          indent: 30,
          endIndent: 30,
        ),
        addVerticalSpace()
      ],
    );
  }
}
