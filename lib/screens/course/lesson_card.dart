import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nailstudy_app_flutter/constants.dart';
import 'package:nailstudy_app_flutter/logic/courses/lesson_material_model.dart';
import 'package:nailstudy_app_flutter/logic/courses/lesson_model.dart';
import 'package:nailstudy_app_flutter/logic/courses/subject_model.dart';
import 'package:nailstudy_app_flutter/screens/course/lesson_pages_container.dart';
import 'package:nailstudy_app_flutter/utils/spacing.dart';

enum LessonType { theory, practice }

class LessonCard extends StatelessWidget {
  final Lesson lesson;
  final LessonMaterial material;
  final LessonType lessonType;
  final bool finishedLesson;
  final bool available;
  final Function? onNextLesson;
  final Function finishLesson;

  const LessonCard(
      {Key? key,
      required this.lesson,
      required this.material,
      required this.lessonType,
      required this.onNextLesson,
      required this.finishLesson,
      this.finishedLesson = false,
      this.available = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: !available
          ? () {
              showModalBottomSheet<void>(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(30),
                  ),
                ),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                context: context,
                builder: (BuildContext context) {
                  return Wrap(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(kDefaultPadding),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              height: 6,
                              width: 100,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(2),
                                  color: kPrimaryColor),
                            ),
                            addVerticalSpace(),
                            const Text('Rond eerst je les af',
                                style: TextStyle(
                                    fontSize: kHeader2,
                                    color: kSecondaryColor)),
                            addVerticalSpace(),
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: kDefaultPadding),
                              child: Text(
                                'Je moet eerst je andere lessen afronden voordat je deze kan starten.',
                                style: TextStyle(
                                    fontSize: kSubtitle1, color: kGrey),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            addVerticalSpace()
                          ],
                        ),
                      ),
                    ],
                  );
                },
              );
            }
          : () {
              Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (context) => LessonPagerContainer(
                            finishLesson: finishLesson,
                            onNextLesson: onNextLesson,
                            lesson: lesson,
                            lessonType: lessonType,
                            subjects: [
                              Subject(
                                  title: material.name,
                                  description: material.description,
                                  subjectNumber: 0,
                                  isIntroduction: true),
                              ...material.subjects ?? []
                            ],
                          )));
            },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: kDefaultPadding),
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
                          filter: ImageFilter.blur(sigmaX: 1.5, sigmaY: 1.5),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.0),
                            ),
                            child: const Icon(
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
                  Text(material.name,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
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
                          lessonType == LessonType.theory
                              ? '${material.subjects?.length ?? 0} onderwerpen'
                              : '${material.subjects?.length ?? 0} stappen',
                          style: const TextStyle(
                              fontSize: kParagraph1, color: kGrey)),
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
