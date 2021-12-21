import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nailstudy_app_flutter/constants.dart';
import 'package:nailstudy_app_flutter/screens/home/widgets/progress_card.dart';
import 'package:nailstudy_app_flutter/utils/spacing.dart';
import 'package:nailstudy_app_flutter/widgets/expiry_indicator.dart';
import 'package:nailstudy_app_flutter/widgets/progress_course.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:percent_indicator/percent_indicator.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screen = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: kDefaultBackgroundColor,
      body: SafeArea(
        child: Container(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Hello, Danny!',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: kHeader2,
                            color: kSecondaryColor)),
                    Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: kLightGrey,
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.notifications_outlined,
                          color: kSecondaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
                const Flexible(
                  child: Text('Klaar om weer verder te leren?',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: kHeader1,
                          color: kSecondaryColor)),
                ),
                const SizedBox(
                  height: kDefaultPadding,
                ),
                ProgressCard(screen: screen),
                addVerticalSpace(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('Lopende cursussen',
                        style: TextStyle(
                            fontSize: kHeader2, color: kSecondaryColor)),
                    //TODO BUTTON
                    Text('Toon alles',
                        style: TextStyle(fontSize: kHeader2, color: kGrey))
                  ],
                ),
                addVerticalSpace(),
                ProgressCourse(),
              ],
            )),
      ),
    );
  }
}
