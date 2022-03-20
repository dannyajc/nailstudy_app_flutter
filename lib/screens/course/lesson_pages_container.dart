import 'package:flutter/material.dart';
import 'package:nailstudy_app_flutter/constants.dart';
import 'package:collection/collection.dart';
import 'package:nailstudy_app_flutter/logic/courses/lesson_model.dart';
import 'package:nailstudy_app_flutter/logic/courses/subject_model.dart';
import 'package:nailstudy_app_flutter/screens/course/lesson_card.dart';
import 'package:nailstudy_app_flutter/screens/course/lesson_page.dart';

class LessonPagerContainer extends StatefulWidget {
  final Lesson lesson;
  final LessonType lessonType;
  final List<Subject> subjects;
  const LessonPagerContainer(
      {Key? key,
      required this.lesson,
      required this.lessonType,
      required this.subjects})
      : super(key: key);

  @override
  _LessonPagerContainerState createState() => _LessonPagerContainerState();
}

class _LessonPagerContainerState extends State<LessonPagerContainer> {
  int currentSubject = 0;

  @override
  Widget build(BuildContext context) {
    // TODO: initial page to where the user left off
    final PageController controller = PageController();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kDefaultBackgroundColor,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: kSecondaryColor,
          ),
          iconSize: 20.0,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Text(
            (currentSubject == 0 &&
                    widget.subjects[currentSubject].isIntroduction)
                ? 'Les ${widget.lesson.lessonNumber} | Introductie'
                : 'Les ${widget.lesson.lessonNumber} | Onderwerp $currentSubject',
            style: const TextStyle(fontSize: kHeader2, color: kSecondaryColor)),
      ),
      body: PageView(
        controller: controller,
        children: <Widget>[
          ...widget.subjects.mapIndexed((index, subject) => LessonPage(
                lessonType: widget.lessonType,
                subject: subject,
                currentSubject: index,
                pageController: controller,
                totalPages: widget.subjects.length,
              ))
        ],
        onPageChanged: (index) {
          setState(() {
            currentSubject = index;
          });
        },
      ),
    );
  }
}
