import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nailstudy_app_flutter/constants.dart';
import 'package:nailstudy_app_flutter/logic/courses/course_model.dart';
import 'package:nailstudy_app_flutter/logic/user/user_course_model.dart';
import 'package:nailstudy_app_flutter/logic/user/user_store.dart';
import 'package:nailstudy_app_flutter/screens/course/course_detail_page.dart';
import 'package:nailstudy_app_flutter/widgets/expiry_indicator.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ProgressCourse extends StatefulWidget {
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
  State<ProgressCourse> createState() => _ProgressCourseState();
}

class _ProgressCourseState extends State<ProgressCourse> {
  final ref = FirebaseStorage.instance.ref();

  Future<String?> getDownloadUrl(imageUrl) async {
    if (imageUrl == "") {
      return null;
    }
    var image = ref.child(imageUrl);
    return image.getDownloadURL();
  }

  @override
  Widget build(BuildContext context) {
    DateTime expiryDate =
        DateFormat("d-M-yyyy HH:mm:ss").parse(widget.userProgress.expiryDate);

    var progressPercentage = widget.userProgress.finished
        ? 1.0
        : (widget.userProgress.currentLessonNumber - 1) /
            (widget.course.lessons?.length ?? 0);

    return FutureBuilder(
        future: getDownloadUrl(widget.course.image),
        builder: ((context, snapshot) {
          return GestureDetector(
            onTap: widget.detailScreenVersion || !widget.onPressEnabled
                ? null
                : () {
                    Provider.of<UserStore>(context, listen: false)
                        .setCurrentUserCourse(widget.userProgress);
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            settings:
                                const RouteSettings(name: "/courseDetail"),
                            builder: (context) => CourseDetailPage(
                                course: widget.course,
                                userProgress: widget.userProgress,
                                courseImage: snapshot.data.toString())));
                  },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      right: widget.detailScreenVersion ? 0 : kDefaultPadding),
                  // TODO: Change course image
                  child: !widget.detailScreenVersion
                      ? CachedNetworkImage(
                          imageUrl: snapshot.hasData
                              ? snapshot.data.toString()
                              : kDefaultImage,
                          imageBuilder: (context, imageProvider) => Container(
                            width: 70.0,
                            height: 70.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius:
                                  BorderRadius.circular(kDefaultBorderRadius),
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
                            widget.detailScreenVersion
                                ? 'Licentie code ${widget.userProgress.licenseCode}'
                                : widget.userProgress.licenseCode,
                            style: const TextStyle(
                                fontSize: kParagraph1, color: kGrey)),
                        Text(widget.course.name,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: widget.detailScreenVersion
                                    ? kHeader2
                                    : kSubtitle1,
                                color: kSecondaryColor)),
                        widget.detailScreenVersion
                            ? Text(
                                '${(widget.course.lessons?.length ?? widget.userProgress.currentLessonNumber) - widget.userProgress.currentLessonNumber + 1} van ${widget.course.lessons?.length} lessen te gaan',
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontSize: kParagraph1,
                                    color: kSecondaryColor))
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
                    style:
                        const TextStyle(fontSize: 12, color: kSecondaryColor),
                  ),
                  circularStrokeCap: CircularStrokeCap.butt,
                  backgroundColor: kLightGrey,
                  progressColor: progressPercentage == 1.0
                      ? kAccentColor
                      : kCompletedColor,
                ),
              ],
            ),
          );
        }));
  }
}
