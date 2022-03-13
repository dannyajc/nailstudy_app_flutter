import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nailstudy_app_flutter/constants.dart';
import 'package:nailstudy_app_flutter/logic/courses/course_store.dart';
import 'package:nailstudy_app_flutter/logic/user/user_store.dart';
import 'package:nailstudy_app_flutter/screens/home/widgets/progress_card.dart';
import 'package:nailstudy_app_flutter/utils/spacing.dart';
import 'package:nailstudy_app_flutter/widgets/completed_course.dart';
import 'package:nailstudy_app_flutter/widgets/progress_course.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    Provider.of<CourseStore>(context, listen: false).fetchAllCourses();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screen = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: kDefaultBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 120,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: kDefaultPadding),
                              child: CachedNetworkImage(
                                imageUrl:
                                    'https://images.unsplash.com/photo-1533158628620-7e35717d36e8?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2400&q=80',
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                  width: 35.0,
                                  height: 35.0,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(8.0),
                                    image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                placeholder: (context, url) =>
                                    const CircularProgressIndicator.adaptive(),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                            ),
                            Consumer<UserStore>(
                              builder: (context, value, child) => value.user !=
                                      null
                                  ? Text('Hallo, ${value.user?.firstName}!',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: kHeader2,
                                          color: kSecondaryColor))
                                  : Container(),
                            ),
                            // TODO: Notification Icon
                            // Container(
                            //   width: 35,
                            //   height: 35,
                            //   decoration: BoxDecoration(
                            //     borderRadius: BorderRadius.circular(8.0),
                            //     color: kLightGrey,
                            //   ),
                            //   child: const Center(
                            //     child: Icon(
                            //       Icons.notifications_outlined,
                            //       color: kSecondaryColor,
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                        addVerticalSpace(),
                        const Flexible(
                          child: Text('Klaar om weer verder te leren?',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: kHeader1,
                                  color: kSecondaryColor)),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
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
                              style:
                                  TextStyle(fontSize: kHeader2, color: kGrey))
                        ],
                      ),
                      addVerticalSpace(),
                      Consumer<UserStore>(builder: (context, userStore, child) {
                        if (userStore.user != null &&
                            userStore.user!.courses.isNotEmpty) {
                          return Consumer<CourseStore>(
                              builder: (context, courseStore, child) {
                            return Column(
                              children: userStore.user!.courses.map((e) {
                                if (courseStore.courses != null) {
                                  return Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: kDefaultPadding),
                                      child: ProgressCourse(
                                        userProgress: e,
                                        course: courseStore.courses!.firstWhere(
                                            (element) =>
                                                element.id == e.courseId),
                                      ));
                                } else {
                                  return Container();
                                }
                              }).toList(),
                            );
                          });
                        } else {
                          return Container();
                        }
                      }),
                      addVerticalSpace(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text('Voltooide cursussen',
                              style: TextStyle(
                                  fontSize: kHeader2, color: kSecondaryColor)),
                          //TODO BUTTON
                          Text('Toon alles',
                              style:
                                  TextStyle(fontSize: kHeader2, color: kGrey))
                        ],
                      ),
                      addVerticalSpace(),
                      SizedBox(
                          height: 100,
                          child: ShaderMask(
                            shaderCallback: (Rect rect) {
                              return const LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  Colors.purple,
                                  Colors.transparent,
                                  Colors.transparent,
                                  Colors.purple
                                ],
                                stops: [0.0, 0.05, 0.95, 1.0],
                              ).createShader(rect);
                            },
                            blendMode: BlendMode.dstOut,
                            child: GridView.count(
                              primary: false,
                              scrollDirection: Axis.horizontal,
                              childAspectRatio: .35,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              crossAxisCount: 1,
                              children: const <Widget>[
                                CompletedCourse(),
                                CompletedCourse(),
                                CompletedCourse(),
                                CompletedCourse(),
                              ],
                            ),
                          )),
                    ],
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
