import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class ShadowImage extends StatelessWidget {
  final String image;
  const ShadowImage({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: kDefaultPadding),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        boxShadow: [
          BoxShadow(
            color: kSecondaryColor.withOpacity(.1),
            blurRadius: 20.0,
            spreadRadius: .2,
          )
        ],
      ),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: CachedNetworkImage(
            imageUrl: image,
            width: MediaQuery.of(context).size.width - 40,
            height: 200.0,
            fit: BoxFit.cover,
            placeholder: (context, url) =>
                const CircularProgressIndicator.adaptive(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          )),
    );
  }
}
