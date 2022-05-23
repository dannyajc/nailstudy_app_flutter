import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nailstudy_app_flutter/constants.dart';
import 'package:nailstudy_app_flutter/logic/courses/lesson_model.dart';
import 'package:nailstudy_app_flutter/logic/courses/subject_model.dart';
import 'package:nailstudy_app_flutter/logic/user/user_store.dart';
import 'package:nailstudy_app_flutter/screens/course/lesson_card.dart';
import 'package:nailstudy_app_flutter/screens/course/lesson_completed_screen.dart';
import 'package:nailstudy_app_flutter/screens/course/subject_paragraph.dart';
import 'package:nailstudy_app_flutter/utils/spacing.dart';
import 'package:collection/collection.dart';
import 'package:provider/provider.dart';

class LessonPage extends StatelessWidget {
  final Lesson lesson;
  final LessonType lessonType;
  final Subject subject;
  final int currentSubject;
  final PageController pageController;
  final int totalPages;
  final Function? onNextLesson;
  final Function finishLesson;

  const LessonPage({
    Key? key,
    required this.lesson,
    required this.lessonType,
    required this.subject,
    required this.currentSubject,
    required this.pageController,
    required this.totalPages,
    required this.onNextLesson,
    required this.finishLesson,
  }) : super(key: key);

  List<Widget> getParagraphs() {
    return subject.paragraphs
            ?.mapIndexed(
              (index, paragraph) => SubjectParagraph(
                  title: 'Stap ${index + 1} | ${paragraph.title}',
                  imageUrl:
                      // TODO: replace
                      'https://images.unsplash.com/photo-1533158628620-7e35717d36e8?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2400&q=80',
                  text: paragraph.description),
            )
            .toList() ??
        [];
  }

  @override
  Widget build(BuildContext context) {
    final hasBackButton = currentSubject != 0;

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 5,
                    blurRadius: 10,
                  ),
                ],
              ),
              child: CachedNetworkImage(
                imageUrl:
                    'https://images.unsplash.com/photo-1533158628620-7e35717d36e8?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2400&q=80',
                imageBuilder: (context, imageProvider) => Container(
                  width: MediaQuery.of(context).size.width - 40,
                  height: 200.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(8.0),
                    image: DecorationImage(
                        image: imageProvider, fit: BoxFit.cover),
                  ),
                ),
                placeholder: (context, url) =>
                    const CircularProgressIndicator.adaptive(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                addVerticalSpace(),
                Text(
                  lessonType == LessonType.theory ? 'Theorie' : 'Praktijk',
                  style: const TextStyle(
                      fontSize: kParagraph1, color: kSecondaryColor),
                ),
                Text(
                  subject.title,
                  style: const TextStyle(
                      fontSize: kHeader2,
                      fontWeight: FontWeight.bold,
                      color: kSecondaryColor),
                ),
                addVerticalSpace(),
                // TODO Paragraphs
                if (subject.isIntroduction) ...[
                  Text(subject.description,
                      style:
                          const TextStyle(fontSize: kParagraph1, color: kGrey)),
                  addVerticalSpace(),
                  const Divider(
                    indent: 30,
                    endIndent: 30,
                  ),
                  addVerticalSpace()
                ],
                if (!subject.isIntroduction) ...getParagraphs(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    (hasBackButton)
                        ? Expanded(
                            flex: 1,
                            child: CupertinoButton(
                              padding: const EdgeInsets.all(0),
                              color: kPrimaryColor,
                              borderRadius: BorderRadius.circular(8.0),
                              onPressed: () {
                                pageController.previousPage(
                                    duration: const Duration(milliseconds: 400),
                                    curve: Curves.easeInOut);
                              },
                              child: Container(
                                height: 70,
                                padding: EdgeInsets.symmetric(
                                    horizontal: hasBackButton ? 10 : 30),
                                child: Row(
                                  mainAxisAlignment: hasBackButton
                                      ? MainAxisAlignment.center
                                      : MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Vorige',
                                      style: TextStyle(
                                          fontSize: kSubtitle1,
                                          color: kSecondaryColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    (hasBackButton)
                                        ? Container()
                                        : const Icon(
                                            Icons.east,
                                            color: kSecondaryColor,
                                          )
                                  ],
                                ),
                              ),
                            ),
                          )
                        : Container(),
                    (hasBackButton)
                        ? const SizedBox(
                            width: 10,
                          )
                        : Container(),
                    Expanded(
                      flex: 1,
                      child: CupertinoButton(
                        padding: const EdgeInsets.all(0),
                        color: kPrimaryColor,
                        borderRadius: BorderRadius.circular(8.0),
                        onPressed: () {
                          // Add 1 to currentSubject
                          // TODO: Fix this when updating subject number has been correctly implemented
                          // if (onNextLesson != null) onNextLesson!(context);
                          var currentCourse =
                              Provider.of<UserStore>(context, listen: false)
                                  .currentCourse;

                          if (currentSubject == totalPages - 1) {
                            if (currentCourse != null &&
                                currentCourse.currentLessonNumber <=
                                    lesson.lessonNumber &&
                                lessonType == LessonType.practice) {
                              finishLesson(context);
                            }
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) => LessonCompletedScreen(
                                          lessonType: lessonType,
                                        )));
                          } else {
                            pageController.nextPage(
                                duration: const Duration(milliseconds: 400),
                                curve: Curves.easeInOut);
                          }
                        },
                        child: Container(
                          height: 70,
                          padding: EdgeInsets.symmetric(
                              horizontal: hasBackButton ? 10 : 30),
                          child: Row(
                            mainAxisAlignment: hasBackButton
                                ? MainAxisAlignment.center
                                : MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                currentSubject == totalPages - 1
                                    ? 'Afronden'
                                    : 'Volgende',
                                style: const TextStyle(
                                    fontSize: kSubtitle1,
                                    color: kSecondaryColor,
                                    fontWeight: FontWeight.bold),
                              ),
                              (hasBackButton)
                                  ? Container()
                                  : const Icon(
                                      Icons.east,
                                      color: kSecondaryColor,
                                    )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                addVerticalSpace(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
