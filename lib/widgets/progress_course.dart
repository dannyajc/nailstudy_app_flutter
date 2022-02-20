import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nailstudy_app_flutter/constants.dart';
import 'package:nailstudy_app_flutter/screens/course/course_detail_page.dart';
import 'package:nailstudy_app_flutter/widgets/expiry_indicator.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ProgressCourse extends StatelessWidget {
  final bool detailScreenVersion;
  const ProgressCourse({Key? key, this.detailScreenVersion = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        detailScreenVersion
            ? null
            : Navigator.push(
                context,
                CupertinoPageRoute(
                    settings: const RouteSettings(name: "/courseDetail"),
                    builder: (context) => const CourseDetailPage()));
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
                      width: 90.0,
                      height: 90.0,
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
                          ? 'License code 34834289'
                          : '#78K6HY5',
                      style:
                          const TextStyle(fontSize: kParagraph1, color: kGrey)),
                  Text('Basic Acrylic Nails',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: detailScreenVersion ? kHeader1 : kSubtitle1,
                          color: kSecondaryColor)),
                  detailScreenVersion
                      ? const Text('6 of 12 classes left',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: kSubtitle1, color: kSecondaryColor))
                      : const ExpiryIndicator(
                          daysLeft: 6,
                        )
                ],
              ),
            ),
          ),
          CircularPercentIndicator(
            radius: 60.0,
            lineWidth: 3.0,
            animation: true,
            percent: 0.7,
            center: const Text(
              // TODO CALCULATE PERCENTAGE
              "70.0%",
              style: TextStyle(fontSize: 12, color: kSecondaryColor),
            ),
            circularStrokeCap: CircularStrokeCap.butt,
            backgroundColor: kDefaultBackgroundColor,
            progressColor: kCompletedColor,
          ),
        ],
      ),
    );
  }
}
