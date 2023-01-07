import 'dart:async';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nailstudy_app_flutter/constants.dart';
import 'package:nailstudy_app_flutter/logic/courses/course_store.dart';
import 'package:nailstudy_app_flutter/logic/user/user_store.dart';
import 'package:nailstudy_app_flutter/screens/login/login_screen.dart';
import 'package:nailstudy_app_flutter/screens/profile/add_license_screen.dart';
import 'package:nailstudy_app_flutter/utils/spacing.dart';
import 'package:nailstudy_app_flutter/widgets/progress_course.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ref = FirebaseStorage.instance.ref();
  List<XFile> _imageFileList = [];

  final ImagePicker _picker = ImagePicker();
  String? _retrieveDataError;

  void _onImageButtonPressed(ImageSource source, BuildContext context,
      {bool isMultiImage = false}) async {
    {
      try {
        final pickedFile = await _picker.pickImage(
          source: source,
        );
        if (pickedFile != null) {
          final destination = 'files/${pickedFile.name}';
          final ref = FirebaseStorage.instance.ref(destination);
          File file = File(pickedFile.path);

          await ref.putFile(file);

          Provider.of<UserStore>(context, listen: false)
              .modifyAvatar(destination);
          Timer(const Duration(seconds: 2), () {
            Provider.of<UserStore>(context, listen: false).fetchSelf();
          });
        }
      } catch (e) {
        _getRetrieveErrorWidget();
        setState(() {});
      }
    }
  }

  Future<void> retrieveLostData() async {
    final LostDataResponse response = await _picker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        _imageFileList = response.files!;
      });
    } else {
      _retrieveDataError = response.exception!.code;
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Er ging iets mis.."),
              content: Text(_retrieveDataError!),
              actions: [
                TextButton(
                  child: const Text("Ok"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
    }
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _getRetrieveErrorWidget() {
    if (_retrieveDataError != null) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Er ging iets mis.."),
              content: Text(_retrieveDataError!),
              actions: [
                TextButton(
                  child: const Text("Ok"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
    }
  }

  Future<String?> getDownloadUrl(avatar) async {
    if (avatar == "") {
      return null;
    }
    var image = ref.child(avatar);
    return image.getDownloadURL();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kDefaultBackgroundColor,
        centerTitle: true,
        title: const Text('Profiel',
            style: TextStyle(fontSize: kHeader2, color: kSecondaryColor)),
        actions: [
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: Builder(
                  builder: (context) => IconButton(
                        icon: const Icon(
                          Icons.menu,
                          color: kGrey,
                        ),
                        onPressed: () => Scaffold.of(context).openEndDrawer(),
                      )))
        ],
      ),
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: kPrimaryColor,
              ),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  'Profiel',
                  style: TextStyle(fontSize: kHeader1, color: kSecondaryColor),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.logout,
                color: kSecondaryColor,
              ),
              minLeadingWidth: 10,
              title: const Text('Uitloggen',
                  style: TextStyle(fontSize: kHeader2, color: kSecondaryColor)),
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
                  CupertinoPageRoute(
                    builder: (BuildContext context) {
                      return const LoginScreen();
                    },
                  ),
                  (_) => false,
                );
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.portrait,
                color: kSecondaryColor,
              ),
              minLeadingWidth: 10,
              title: const Text('Profielfoto wijzigen',
                  style: TextStyle(fontSize: kHeader2, color: kSecondaryColor)),
              onTap: () async {
                _onImageButtonPressed(
                  ImageSource.gallery,
                  context,
                  isMultiImage: true,
                );
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
          child: Stack(children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // TODO: Replace banner photo?
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
                    Text(
                      (Provider.of<UserStore>(context).user?.firstName ?? '') +
                          ' ' +
                          (Provider.of<UserStore>(context).user?.lastName ??
                              ''),
                      style: const TextStyle(
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
                          if (courseStore.loading || userStore.loading) {
                            return const CircularProgressIndicator.adaptive();
                          }
                          return Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                children: userStore.user!.courses.map((e) {
                                  if (courseStore.courses != null &&
                                      e.active == 0) {
                                    var course = courseStore.courses!
                                        .firstWhereOrNull((element) =>
                                            element.id == e.courseId);
                                    if (course != null) {
                                      return Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: kDefaultPadding),
                                          child: ProgressCourse(
                                            onPressEnabled: false,
                                            userProgress: e,
                                            course: course,
                                          ));
                                    }
                                    return Container();
                                  } else {
                                    return Container();
                                  }
                                }).toList(),
                              ),
                            ),
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
                child:
                    Consumer<UserStore>(builder: (context, userStore, child) {
                  return userStore.loading && userStore.user != null
                      ? const CircularProgressIndicator.adaptive()
                      : FutureBuilder(
                          future: getDownloadUrl(userStore.user!.avatar),
                          builder: ((context, snapshot) {
                            return snapshot.hasData
                                ? CachedNetworkImage(
                                    imageUrl: snapshot.data.toString(),
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                  )
                                : Image.asset(
                                    'assets/images/default_avatar.png',
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  );
                          }),
                        );
                }),
              ),
            ),
          ),
        ),
      ])),
    );
  }
}
