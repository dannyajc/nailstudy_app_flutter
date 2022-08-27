import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nailstudy_app_flutter/constants.dart';
import 'package:nailstudy_app_flutter/logic/courses/course_model.dart';
import 'package:nailstudy_app_flutter/logic/courses/course_store.dart';
import 'package:nailstudy_app_flutter/logic/user/user_course_model.dart';
import 'package:nailstudy_app_flutter/logic/user/user_store.dart';
import 'package:nailstudy_app_flutter/screens/home/widgets/progress_card.dart';
import 'package:nailstudy_app_flutter/utils/spacing.dart';
import 'package:nailstudy_app_flutter/widgets/completed_course.dart';
import 'package:nailstudy_app_flutter/widgets/progress_course.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<CompletedCourse> getCompletedAndInvalidCourses(
      List<UserCourseModel> userCourses, List<CourseModel>? courses) {
    var completedCourses = [];
    userCourses.forEach((e) {
      if (courses != null &&
          courses.isNotEmpty &&
          (e.finished || e.active != 0)) {
        var course =
            courses.firstWhereOrNull((element) => element.id == e.courseId);
        if (course != null) {
          completedCourses.add(CompletedCourse(
            userProgress: e,
            course: course,
          ));
        }
      }
    });
    return completedCourses.cast<CompletedCourse>();
  }

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
        child: RefreshIndicator(
          onRefresh: () async {
            await Provider.of<UserStore>(context, listen: false).fetchSelf();
            return Future.delayed(const Duration(seconds: 0));
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Container(
                constraints:
                    BoxConstraints(minHeight: screen.height - kTabBarHeight),
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                        const Text('Klaar om weer verder te leren?',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: kHeader1,
                                color: kSecondaryColor)),
                      ],
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
                                    fontSize: kHeader2,
                                    color: kSecondaryColor)),
                            //TODO BUTTON
                            Text('Toon alles',
                                style:
                                    TextStyle(fontSize: kHeader2, color: kGrey))
                          ],
                        ),
                        addVerticalSpace(),
                        Consumer<UserStore>(
                            builder: (context, userStore, child) {
                          if (userStore.user != null &&
                              userStore.user!.courses.isNotEmpty) {
                            return Consumer<CourseStore>(
                                builder: (context, courseStore, child) {
                              if (courseStore.loading) {
                                return const SizedBox(
                                  width: 50,
                                  height: 50,
                                  child: CircularProgressIndicator.adaptive(),
                                );
                              }
                              return Column(
                                children: userStore.user!.courses.map((e) {
                                  if (courseStore.courses != null &&
                                      courseStore.courses!.isNotEmpty &&
                                      e.active == 0 &&
                                      !e.finished) {
                                    var course = courseStore.courses!
                                        .firstWhereOrNull((element) =>
                                            element.id == e.courseId);
                                    if (course != null) {
                                      return Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: kDefaultPadding),
                                          child: ProgressCourse(
                                            userProgress: e,
                                            course: course,
                                          ));
                                    } else {
                                      return Container();
                                    }
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
                                    fontSize: kHeader2,
                                    color: kSecondaryColor)),
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
                              child: Consumer<UserStore>(
                                  builder: (context, userStore, child) {
                                if (userStore.user != null &&
                                    userStore.user!.courses.isNotEmpty) {
                                  return Consumer<CourseStore>(
                                      builder: (context, courseStore, child) {
                                    if (courseStore.loading) {
                                      return const SizedBox(
                                        width: 50,
                                        height: 50,
                                        child: CircularProgressIndicator
                                            .adaptive(),
                                      );
                                    }
                                    return GridView.count(
                                      primary: false,
                                      scrollDirection: Axis.horizontal,
                                      childAspectRatio: .35,
                                      crossAxisSpacing: 10,
                                      mainAxisSpacing: 0,
                                      crossAxisCount: 1,
                                      children: [
                                        ...getCompletedAndInvalidCourses(
                                            userStore.user!.courses,
                                            courseStore.courses)
                                      ],
                                    );
                                  });
                                } else {
                                  return Container();
                                }
                              }),
                            )),
                      ],
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
