import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nailstudy_app_flutter/constants.dart';
import 'package:nailstudy_app_flutter/utils/spacing.dart';

class SubjectParagraph extends StatelessWidget {
  final String? imageUrl;
  final String text;
  final String title;

  const SubjectParagraph(
      {Key? key, this.imageUrl, required this.text, required this.title})
      : super(key: key);

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
        imageUrl != null
            ? Column(
                children: [
                  CachedNetworkImage(
                    imageUrl: imageUrl!,
                    imageBuilder: (context, imageProvider) => Container(
                      width: MediaQuery.of(context).size.width - 40,
                      height: 200.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(8.0),
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.fitWidth),
                      ),
                    ),
                    placeholder: (context, url) =>
                        const CircularProgressIndicator.adaptive(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                  addVerticalSpace(),
                ],
              )
            : Container(
                height: 0,
              ),
        Text(
          text,
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
