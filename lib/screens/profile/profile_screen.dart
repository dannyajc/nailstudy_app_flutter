import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nailstudy_app_flutter/constants.dart';
import 'package:nailstudy_app_flutter/logic/courses/course_store.dart';
import 'package:nailstudy_app_flutter/logic/user/user_store.dart';
import 'package:nailstudy_app_flutter/screens/profile/add_license_screen.dart';
import 'package:nailstudy_app_flutter/utils/spacing.dart';
import 'package:nailstudy_app_flutter/widgets/progress_course.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
        title: const Text('Profiel',
            style: TextStyle(fontSize: kHeader2, color: kSecondaryColor)),
      ),
      body: SafeArea(
          child: Stack(children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CachedNetworkImage(
              imageUrl:
                  'https://images.unsplash.com/photo-1533158628620-7e35717d36e8?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2400&q=80',
              width: MediaQuery.of(context).size.width,
              height: 200,
              fit: BoxFit.cover,
              placeholder: (context, url) =>
                  const CircularProgressIndicator.adaptive(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(top: 70, left: 20, right: 20),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      'Danny Janssen',
                      style: TextStyle(
                          color: kSecondaryColor,
                          fontSize: kHeader2,
                          fontWeight: FontWeight.bold),
                    ),
                    addVerticalSpace(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Jouw licenties',
                          style: TextStyle(
                            color: kSecondaryColor,
                            fontSize: kHeader2,
                          ),
                        ),
                        GestureDetector(
                          onTap: (() {
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    settings: const RouteSettings(
                                        name: "/addLicense"),
                                    builder: (context) =>
                                        const AddLicenseScreen()));
                          }),
                          child: const Text('Toevoegen',
                              style:
                                  TextStyle(fontSize: kHeader2, color: kGrey)),
                        )
                      ],
                    ),
                    addVerticalSpace(),
                    Consumer<UserStore>(builder: (context, userStore, child) {
                      if (userStore.user != null &&
                          userStore.user!.courses.isNotEmpty) {
                        return Consumer<CourseStore>(
                            builder: (context, courseStore, child) {
                          if (courseStore.loading) {
                            return const CircularProgressIndicator.adaptive();
                          }
                          return Column(
                            children: userStore.user!.courses.map((e) {
                              if (courseStore.courses != null) {
                                return Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: kDefaultPadding),
                                    child: ProgressCourse(
                                      onPressEnabled: false,
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
                  ],
                ),
              ),
            )
          ],
        ),
        Positioned(
          top: 150,
          right: MediaQuery.of(context).size.width / 2 - 50,
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                boxShadow: [
                  BoxShadow(
                    color: kSecondaryColor.withOpacity(.5),
                    blurRadius: 20.0,
                    spreadRadius: .5,
                  )
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  'assets/images/profile.jpg',
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ])),
    );
  }
}
