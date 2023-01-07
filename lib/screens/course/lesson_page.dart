import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
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

class LessonPage extends StatefulWidget {
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

  @override
  State<LessonPage> createState() => _LessonPageState();
}

class _LessonPageState extends State<LessonPage> {
  final ref = FirebaseStorage.instance.ref();

  Future<List<String>?> getDownloadUrls(List<String> paths) async {
    if (paths.isEmpty) {
      return null;
    }

    var futures = Future.wait<String>(paths.map((path) {
      return ref.child(path).getDownloadURL();
    }));

    return futures;
  }

  Future<String?> getBannerPhoto() async {
    var path = "";

    if (widget.subject.isIntroduction) {
      path = widget.lessonType == LessonType.theory
          ? (widget.lesson.theory.image ?? "")
          : (widget.lesson.practice.image ?? "");
    } else {
      path = widget.subject.image ?? "";
    }

    if (path.isEmpty) {
      return null;
    }

    return ref.child(path).getDownloadURL();
  }

  List<Widget> getParagraphs() {
    return widget.subject.paragraphs
            ?.mapIndexed(
              (index, paragraph) => FutureBuilder(
                  future: paragraph.images != null
                      ? getDownloadUrls(paragraph.images!)
                      : null,
                  builder: ((context, snapshot) => SubjectParagraph(
                      title: widget.lessonType == LessonType.practice
                          // 17-12-22 Removed paragraph.title here since it was not needed anymore
                          ? 'Stap ${index + 1}'
                          : paragraph.title,
                      imageUrls: snapshot.hasData
                          ? (snapshot.data as List<String>)
                          : null,
                      text: paragraph.description))),
            )
            .toList() ??
        [];
  }

  @override
  Widget build(BuildContext context) {
    final hasBackButton = widget.currentSubject != 0;

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
              child: FutureBuilder(
                future: getBannerPhoto(),
                builder: ((context, snapshot) {
                  if (snapshot.hasData) {
                    return CachedNetworkImage(
                      imageUrl: snapshot.data.toString(),
                      imageBuilder: (context, imageProvider) => Container(
                        width: MediaQuery.of(context).size.width - 40,
                        height: 200.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius:
                              BorderRadius.circular(kDefaultBorderRadius),
                          image: DecorationImage(
                              image: imageProvider, fit: BoxFit.cover),
                        ),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    );
                  }
                  return const SizedBox();
                }),
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
                  widget.lessonType == LessonType.theory
                      ? 'Theorie'
                      : 'Praktijk',
                  style: const TextStyle(
                      fontSize: kParagraph1, color: kSecondaryColor),
                ),
                Text(
                  widget.subject.title,
                  style: const TextStyle(
                      fontSize: kHeader2,
                      fontWeight: FontWeight.bold,
                      color: kSecondaryColor),
                ),
                addVerticalSpace(),
                if (widget.subject.description.isNotEmpty) ...[
                  Text(widget.subject.description.replaceAll('\\n', '\n'),
                      style:
                          const TextStyle(fontSize: kParagraph1, color: kGrey)),
                  addVerticalSpace(),
                  const Divider(
                    indent: 30,
                    endIndent: 30,
                  ),
                  addVerticalSpace()
                ],
                if (!widget.subject.isIntroduction) ...getParagraphs(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    (hasBackButton)
                        ? Expanded(
                            flex: 1,
                            child: CupertinoButton(
                              padding: const EdgeInsets.all(0),
                              color: kPrimaryColor,
                              borderRadius:
                                  BorderRadius.circular(kDefaultBorderRadius),
                              onPressed: () {
                                widget.pageController.previousPage(
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
                        borderRadius:
                            BorderRadius.circular(kDefaultBorderRadius),
                        onPressed: () {
                          // Add 1 to currentSubject
                          // TODO: Fix this when updating subject number has been correctly implemented
                          // if (onNextLesson != null) onNextLesson!(context);
                          var currentCourse =
                              Provider.of<UserStore>(context, listen: false)
                                  .currentCourse;

                          if (widget.currentSubject == widget.totalPages - 1) {
                            if (currentCourse != null &&
                                currentCourse.currentLessonNumber <=
                                    widget.lesson.lessonNumber &&
                                widget.lessonType == LessonType.practice) {
                              widget.finishLesson(context);
                            }
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) => LessonCompletedScreen(
                                          lessonType: widget.lessonType,
                                        )));
                          } else {
                            widget.pageController.nextPage(
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
                                widget.currentSubject == widget.totalPages - 1
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
