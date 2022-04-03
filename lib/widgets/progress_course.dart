import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nailstudy_app_flutter/constants.dart';
import 'package:nailstudy_app_flutter/logic/courses/course_model.dart';
import 'package:nailstudy_app_flutter/logic/user/user_course_model.dart';
import 'package:nailstudy_app_flutter/screens/course/course_detail_page.dart';
import 'package:nailstudy_app_flutter/widgets/expiry_indicator.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:intl/intl.dart';

class ProgressCourse extends StatelessWidget {
  final UserCourseModel userProgress;
  final CourseModel course;
  final bool detailScreenVersion;
  final bool onPressEnabled;

  const ProgressCourse(
      {Key? key,
      required this.userProgress,
      required this.course,
      this.detailScreenVersion = false,
      this.onPressEnabled = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime expiryDate =
        DateFormat("d-M-yyyy HH:mm:ss").parse(userProgress.expiryDate);

    var progressPercentage =
        userProgress.currentLessonNumber / (course.lessons?.length ?? 0);

    return GestureDetector(
      onTap: () {
        detailScreenVersion || !onPressEnabled
            ? null
            : Navigator.push(
                context,
                CupertinoPageRoute(
                    settings: const RouteSettings(name: "/courseDetail"),
                    builder: (context) => CourseDetailPage(
                        course: course, userProgress: userProgress)));
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.only(
                right: detailScreenVersion ? 0 : kDefaultPadding),
            // TODO: Change course image
            child: !detailScreenVersion
                ? CachedNetworkImage(
                    imageUrl:
                        'https://images.unsplash.com/photo-1533158628620-7e35717d36e8?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2400&q=80',
                    imageBuilder: (context, imageProvider) => Container(
                      width: 70.0,
                      height: 70.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(8.0),
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.cover),
                      ),
                    ),
                    placeholder: (context, url) =>
                        const CircularProgressIndicator.adaptive(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  )
                : null,
          ),
          Flexible(
            flex: 1,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      detailScreenVersion
                          ? 'License code ${userProgress.licenseCode}'
                          : userProgress.licenseCode,
                      style:
                          const TextStyle(fontSize: kParagraph1, color: kGrey)),
                  Text(course.name,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: detailScreenVersion ? kHeader2 : kSubtitle1,
                          color: kSecondaryColor)),
                  detailScreenVersion
                      ? const Text('6 of 12 classes left',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: kParagraph1, color: kSecondaryColor))
                      : ExpiryIndicator(
                          daysLeft: expiryDate
                              .difference(DateTime.now())
                              .inDays
                              .toInt(),
                        )
                ],
              ),
            ),
          ),
          CircularPercentIndicator(
            radius: 60.0,
            lineWidth: 3.0,
            animation: true,
            percent: (progressPercentage.isNaN || progressPercentage == 0)
                ? .02
                : progressPercentage,
            center: Text(
              // TODO CALCULATE PERCENTAGE
              '${progressPercentage.isNaN ? 0.0 : progressPercentage * 100}%',
              style: const TextStyle(fontSize: 12, color: kSecondaryColor),
            ),
            circularStrokeCap: CircularStrokeCap.butt,
            backgroundColor: kLightGrey,
            progressColor: kCompletedColor,
          ),
        ],
      ),
    );
  }
}
