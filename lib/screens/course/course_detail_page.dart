import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nailstudy_app_flutter/constants.dart';
import 'package:nailstudy_app_flutter/logic/courses/course_model.dart';
import 'package:nailstudy_app_flutter/logic/courses/lesson_model.dart';
import 'package:nailstudy_app_flutter/logic/user/user_course_model.dart';
import 'package:nailstudy_app_flutter/logic/user/user_store.dart';
import 'package:nailstudy_app_flutter/screens/course/lesson_card.dart';
import 'package:nailstudy_app_flutter/utils/spacing.dart';
import 'package:nailstudy_app_flutter/widgets/expandable_text.dart';
import 'package:nailstudy_app_flutter/widgets/expiry_card.dart';
import 'package:nailstudy_app_flutter/widgets/progress_course.dart';
import 'package:provider/provider.dart';

class CourseDetailPage extends StatelessWidget {
  final CourseModel course;
  final UserCourseModel userProgress;
  const CourseDetailPage(
      {Key? key, required this.course, required this.userProgress})
      : super(key: key);

  void nextLesson(BuildContext context) {
    Provider.of<UserStore>(context, listen: false)
        .updateSubjectNumber(course.id ?? '0');
  }

  void finishLesson(BuildContext context) {
    // Provider.of<UserStore>(context, listen: false)
    //     .finishLesson(course.id ?? '0');
  }

  Widget getLesson(Lesson lesson) {
    return Column(children: [
      Align(
        alignment: Alignment.centerLeft,
        child: Text('Les ${lesson.lessonNumber}',
            style:
                const TextStyle(fontSize: kSubtitle1, color: kSecondaryColor)),
      ),
      addVerticalSpace(),
      LessonCard(
        lesson: lesson,
        material: lesson.theory,
        lessonType: LessonType.theory,
        finishedLesson: userProgress.currentLessonNumber > lesson.lessonNumber,
        available: userProgress.currentLessonNumber >= lesson.lessonNumber,
        // Only allow this function when you are going through the subjects of your current lesson. The subject number shouldn't be updating when you are on lesson 3 but clicking around in lesson 1.
        onNextLesson: userProgress.currentLessonNumber == lesson.lessonNumber
            ? nextLesson
            : null,
        finishLesson: finishLesson,
      ),
      addVerticalSpace(),
      LessonCard(
        lesson: lesson,
        material: lesson.practice,
        lessonType: LessonType.practice,
        finishedLesson: userProgress.currentLessonNumber > lesson.lessonNumber,
        available: userProgress.currentLessonNumber >= lesson.lessonNumber,
        // Only allow this function when you are going through the subjects of your current lesson. The subject number shouldn't be updating when you are on lesson 3 but clicking around in lesson 1.
        onNextLesson: userProgress.currentLessonNumber == lesson.lessonNumber
            ? nextLesson
            : null,
        finishLesson: finishLesson,
      ),
      addVerticalSpace(),
      const Divider(
        indent: 30,
        endIndent: 30,
      ),
      addVerticalSpace()
    ]);
  }

  @override
  Widget build(BuildContext context) {
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
        title: const Text('Details',
            style: TextStyle(fontSize: kHeader2, color: kSecondaryColor)),
      ),
      body: SingleChildScrollView(
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
                children: [
                  addVerticalSpace(),
                  ProgressCourse(
                      course: course,
                      userProgress: userProgress,
                      detailScreenVersion: true),
                  addVerticalSpace(),
                  ExpiryCard(
                    userProgress: userProgress,
                  ),
                  addVerticalSpace(),
                  ExpandableText(course.description),
                  addVerticalSpace(),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Lessen (${course.lessons?.length ?? 0})',
                        style: const TextStyle(
                            fontSize: kHeader2, color: kSecondaryColor)),
                  ),
                  addVerticalSpace(),
                  course.lessons != null
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ...course.lessons!.map((e) => getLesson(e))
                          ],
                        )
                      : Container()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
