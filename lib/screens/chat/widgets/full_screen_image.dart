import 'package:flutter/material.dart';

class FullScreenImage extends StatelessWidget {
  final String heroTag;
  final String url;
  const FullScreenImage({Key? key, required this.heroTag, required this.url})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Center(
          child: Hero(
            tag: heroTag,
            child: Image.network(
              url,
            ),
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
