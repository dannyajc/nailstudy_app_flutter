import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:nailstudy_app_flutter/constants.dart';
import 'package:nailstudy_app_flutter/screens/course/lesson_card.dart';
import 'package:nailstudy_app_flutter/screens/images/image_selection_screen.dart';
import 'package:nailstudy_app_flutter/utils/spacing.dart';

class LessonCompletedScreen extends StatelessWidget {
  final LessonType lessonType;

  const LessonCompletedScreen({Key? key, required this.lessonType})
      : super(key: key);

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
      ),
      body: Container(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Stack(clipBehavior: Clip.none, children: [
          Positioned(
            top: -100,
            left: 0,
            right: 0,
            child: Container(
              child: Lottie.asset(
                'assets/lottie/completed.json',
                repeat: false,
                width: MediaQuery.of(context).size.width,
              ),
            ),
          ),
          Positioned(
            top: 200,
            left: 0,
            right: 0,
            bottom: 0,
            child: ListView(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              children: [
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Je hebt het volgende afgerond',
                    style:
                        TextStyle(fontSize: kSubtitle1, color: kSecondaryColor),
                  ),
                ),
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Basis Acryl',
                    style: TextStyle(
                        fontSize: kHeader1,
                        color: kSecondaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                // Lesson type
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    lessonType == LessonType.theory ? 'Theorie' : 'Praktijk',
                    style: const TextStyle(fontSize: kParagraph1, color: kGrey),
                  ),
                ),
                addVerticalSpace(),
                addVerticalSpace(),
                lessonType == LessonType.practice
                    ? const Align(
                        alignment: Alignment.center,
                        child: Text('Foto\'s opsturen naar de opleider',
                            style: TextStyle(
                                fontSize: kSubtitle1, color: kSecondaryColor)),
                      )
                    : Container(),
                addVerticalSpace(),
                lessonType == LessonType.practice
                    ? const Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Dien 3 foto\'s van je gemaakte nagel(s) in zodat de opleider je voortgang kan beoordelen, je nagel kan goedkeuren om door te gaan naar de volgende les of je feedback kan geven',
                          style: TextStyle(fontSize: kParagraph1, color: kGrey),
                          textAlign: TextAlign.center,
                        ),
                      )
                    : Container(),
                addVerticalSpace(),
                addVerticalSpace(),
                CupertinoButton(
                  padding: const EdgeInsets.all(0),
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.circular(8.0),
                  onPressed: () {
                    if (lessonType == LessonType.theory) {
                      Navigator.popUntil(
                          context, ModalRoute.withName('/courseDetail'));
                    } else {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) =>
                                  const ImageSelectionScreen()));
                    }
                  },
                  child: Container(
                    height: 70,
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        lessonType == LessonType.practice
                            ? const Padding(
                                padding: EdgeInsets.only(right: 8.0),
                                child: Icon(
                                  Icons.insert_photo_outlined,
                                  color: kSecondaryColor,
                                ),
                              )
                            : Container(),
                        Text(
                          lessonType == LessonType.theory
                              ? 'Terug naar lessen'
                              : 'Foto\'s indienen',
                          style: const TextStyle(
                            fontSize: kSubtitle1,
                            color: kSecondaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                addVerticalSpace(),
                lessonType == LessonType.practice
                    ? const Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Overslaan',
                          style: TextStyle(
                              fontSize: kSubtitle1,
                              color: kSecondaryColor,
                              decoration: TextDecoration.underline),
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
