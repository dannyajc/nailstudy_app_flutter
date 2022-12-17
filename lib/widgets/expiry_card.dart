import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nailstudy_app_flutter/constants.dart';
import 'package:nailstudy_app_flutter/logic/courses/course_model.dart';
import 'package:nailstudy_app_flutter/logic/user/user_course_model.dart';

class ExpiryCard extends StatelessWidget {
  final UserCourseModel userProgress;
  const ExpiryCard({
    Key? key,
    required this.userProgress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime expiryDate =
        DateFormat("d-M-yyyy HH:mm:ss").parse(userProgress.expiryDate);
    var daysLeft = expiryDate.difference(DateTime.now()).inDays.toInt();

    var header = '';
    var descP1 = 'Je hebt nog ';
    var descP2 = ' om deze cursus af te ronden';

    if (daysLeft < 14) {
      header = '$daysLeft dagen over';
    }
    if (daysLeft >= 14) {
      var weeks = (daysLeft / 7);
      header = '${weeks.round()} weken over';
    }
    if (daysLeft == 0) {
      header = 'Vandaag';
      descP1 = 'Vandaag is de laatste dag om je cursus af te ronden';
    }
    if (daysLeft < 0) {
      header = 'Verlopen (${daysLeft.abs()} dagen geleden)';
      descP1 = 'Deze cursus is verlopen';
    }

    return Container(
      width: MediaQuery.of(context).size.width,
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(kDefaultBorderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 5,
            blurRadius: 10,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Icon(
              Icons.schedule,
              size: 40,
              color: kSecondaryColor,
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(left: kDefaultPadding),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      header,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: kParagraph1,
                          color: kSecondaryColor),
                    ),
                    RichText(
                        text: TextSpan(children: [
                      TextSpan(
                          text: descP1,
                          style: const TextStyle(
                              fontSize: kParagraph1, color: kSecondaryColor)),
                      TextSpan(
                          text: daysLeft >= 1 ? header : '',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: kParagraph1,
                              color: kSecondaryColor)),
                      TextSpan(
                          text: daysLeft >= 1 ? descP2 : '',
                          style: const TextStyle(
                              fontSize: kParagraph1, color: kSecondaryColor)),
                    ])),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
