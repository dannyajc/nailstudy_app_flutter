import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nailstudy_app_flutter/constants.dart';
import 'package:nailstudy_app_flutter/logic/user/user_store.dart';
import 'package:provider/provider.dart';

class ProgressCard extends StatelessWidget {
  const ProgressCard({
    Key? key,
    required this.screen,
  }) : super(key: key);

  final Size screen;

  int? getAllCourses(BuildContext context) {
    var amountOfCourses =
        Provider.of<UserStore>(context, listen: false).user?.courses.length;
    return amountOfCourses;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screen.width,
      height: 100,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15), color: kPrimaryColor),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SvgPicture.asset('assets/icons/check-green.svg'),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(left: kDefaultPadding),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Jouw vooruitgang',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: kParagraph1,
                          color: kSecondaryColor),
                    ),
                    Text(
                      'Je hebt in totaal ${getAllCourses(context)} cursussen gevolgd. ' +
                          ((getAllCourses(context) ?? 0) > 0
                              ? 'Goed bezig!'
                              : ''),
                      style: const TextStyle(
                          fontSize: kParagraph1, color: kSecondaryColor),
                    ),
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
