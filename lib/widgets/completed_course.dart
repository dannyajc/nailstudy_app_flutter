import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nailstudy_app_flutter/constants.dart';
import 'package:nailstudy_app_flutter/logic/courses/course_model.dart';
import 'package:nailstudy_app_flutter/logic/user/user_course_model.dart';
import 'package:nailstudy_app_flutter/utils/spacing.dart';
import 'package:nailstudy_app_flutter/widgets/completed_indicator.dart';

class CompletedCourse extends StatelessWidget {
  final UserCourseModel userProgress;
  final CourseModel course;

  const CompletedCourse({
    required this.userProgress,
    required this.course,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: kDefaultPadding),
          // TODO: Change course image
          child: CachedNetworkImage(
            imageUrl:
                'https://images.unsplash.com/photo-1533158628620-7e35717d36e8?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2400&q=80',
            imageBuilder: (context, imageProvider) => Container(
              width: 90.0,
              height: 90.0,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(kDefaultBorderRadius),
                image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
              ),
            ),
            placeholder: (context, url) =>
                const CircularProgressIndicator.adaptive(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(userProgress.licenseCode,
                style: const TextStyle(fontSize: kParagraph1, color: kGrey)),
            Text(course.name,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: kSubtitle1,
                    color: kSecondaryColor)),
            addVerticalSpace(height: 5.0),
            CompletedIndicator(state: userProgress.active)
          ],
        ),
      ],
    );
  }
}
