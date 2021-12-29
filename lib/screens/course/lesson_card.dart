import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nailstudy_app_flutter/constants.dart';
import 'package:nailstudy_app_flutter/screens/course/course_detail_page.dart';
import 'package:nailstudy_app_flutter/screens/course/lesson_page.dart';
import 'package:nailstudy_app_flutter/utils/spacing.dart';

enum LessonType { theory, practice }

class LessonCard extends StatelessWidget {
  final lessonType;
  final finishedLesson;
  final available;

  const LessonCard(
      {Key? key,
      @required this.lessonType,
      this.finishedLesson = false,
      this.available = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, CupertinoPageRoute(builder: (context) => LessonPage()));
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.only(right: kDefaultPadding),
            // TODO: Change course image
            child: CachedNetworkImage(
              imageUrl:
                  'https://images.unsplash.com/photo-1533158628620-7e35717d36e8?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2400&q=80',
              imageBuilder: (context, imageProvider) => Container(
                width: 80.0,
                height: 80.0,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(8.0),
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                    colorFilter: !available
                        ? ColorFilter.mode(
                            Colors.black.withOpacity(0.4),
                            BlendMode.darken,
                          )
                        : null,
                  ),
                ),
                child: !available
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: BackdropFilter(
                          filter:
                              new ImageFilter.blur(sigmaX: 1.5, sigmaY: 1.5),
                          child: new Container(
                            decoration: new BoxDecoration(
                              color: Colors.white.withOpacity(0.0),
                            ),
                            child: Icon(
                              Icons.lock,
                              color: kPrimaryColor,
                              size: 30,
                            ),
                          ),
                        ),
                      )
                    : null,
              ),
              placeholder: (context, url) =>
                  const CircularProgressIndicator.adaptive(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          Flexible(
            flex: 1,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(lessonType == LessonType.theory ? 'Theorie' : 'Praktijk',
                      style:
                          const TextStyle(fontSize: kParagraph1, color: kGrey)),
                  const Text('Basic Acrylic Nails',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: kSubtitle1,
                          color: kSecondaryColor)),
                  addVerticalSpace(height: 5.0),
                  Row(
                    children: [
                      const Icon(
                        Icons.class__outlined,
                        color: kGrey,
                        size: 20,
                      ),
                      Text(
                          LessonType == LessonType.theory
                              ? '10 onderwerpen'
                              : '8 stappen',
                          style:
                              TextStyle(fontSize: kParagraph1, color: kGrey)),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Icon(
            finishedLesson ? Icons.check_circle : Icons.play_circle_outline,
            size: 40,
            color: finishedLesson ? kGrey : kPrimaryColor,
          )
        ],
      ),
    );
  }
}
