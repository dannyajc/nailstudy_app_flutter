import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nailstudy_app_flutter/constants.dart';
import 'package:nailstudy_app_flutter/logic/courses/course_store.dart';
import 'package:nailstudy_app_flutter/logic/user/user_store.dart';
import 'package:nailstudy_app_flutter/screens/profile/profile_screen.dart';
import 'package:nailstudy_app_flutter/utils/spacing.dart';
import 'package:nailstudy_app_flutter/widgets/numpad.dart';
import 'package:nailstudy_app_flutter/widgets/primary_button.dart';
import 'package:provider/provider.dart';

class AddLicenseScreen extends StatefulWidget {
  const AddLicenseScreen({Key? key}) : super(key: key);

  @override
  _AddLicenseScreenState createState() => _AddLicenseScreenState();
}

class _AddLicenseScreenState extends State<AddLicenseScreen> {
  final TextEditingController _myController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _myController.addListener(onChange);
  }

  String newText = '';
  void onChange() {
    String text = _myController.text;
    if (text.length < newText.length) {
      // handling backspace in keyboard
      newText = text;
    } else if (text.isNotEmpty && text != newText) {
      // handling typing new characters.
      String tempText = text.replaceAll("-", "");
      if (tempText.length % 4 == 0) {
        //do your text transforming
        newText = text.length == 14 ? text : '$text-';
        _myController.text = newText;
        _myController.selection = TextSelection(
            baseOffset: newText.length, extentOffset: newText.length);
      }
    }
  }

  void checkLicenseCode(String licenseCode) {
    Provider.of<UserStore>(context, listen: false)
        .activateCourse(licenseCode)
        .then(
      (value) {
        if (value == null) {
          showModalBottomSheet<void>(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(30),
              ),
            ),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            context: context,
            builder: (BuildContext context) {
              return Wrap(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(kDefaultPadding),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          height: 6,
                          width: 100,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2),
                              color: kPrimaryColor),
                        ),
                        addVerticalSpace(),
                        const Text('Er ging iets mis',
                            style: TextStyle(
                                fontSize: kHeader2, color: kSecondaryColor)),
                        addVerticalSpace(),
                        const Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: kDefaultPadding),
                          child: Text(
                            'Je licentiecode kon niet worden gevalideerd of is al door jou in gebruik.',
                            style:
                                TextStyle(fontSize: kSubtitle1, color: kGrey),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        addVerticalSpace()
                      ],
                    ),
                  ),
                ],
              );
            },
          );
        } else {
          Provider.of<CourseStore>(context, listen: false)
              .fetchAllCourses()
              .then((_) => showModalBottomSheet<void>(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(30),
                      ),
                    ),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    context: context,
                    builder: (BuildContext context) {
                      return Wrap(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Consumer<CourseStore>(
                                builder: (context, courseStore, child) {
                              var course = courseStore.courses?.firstWhere(
                                  (element) => element.id == value);
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    height: 6,
                                    width: 100,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(2),
                                        color: kPrimaryColor),
                                  ),
                                  addVerticalSpace(),
                                  const Text('Gelukt!',
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: kHeader1,
                                          color: kSecondaryColor)),
                                  addVerticalSpace(),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: kDefaultPadding),
                                        // TODO: Change course image
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              'https://images.unsplash.com/photo-1533158628620-7e35717d36e8?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2400&q=80',
                                          imageBuilder:
                                              (context, imageProvider) =>
                                                  Container(
                                            width: 70.0,
                                            height: 70.0,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.rectangle,
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              image: DecorationImage(
                                                  image: imageProvider,
                                                  fit: BoxFit.cover),
                                            ),
                                          ),
                                          placeholder: (context, url) =>
                                              const CircularProgressIndicator
                                                  .adaptive(),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error),
                                        ),
                                      ),
                                      Flexible(
                                        flex: 1,
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(licenseCode,
                                                  style: const TextStyle(
                                                      fontSize: kSubtitle1,
                                                      color: kGrey)),
                                              course != null
                                                  ? Text(course.name,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: kHeader2,
                                                          color:
                                                              kSecondaryColor))
                                                  : Container()
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  addVerticalSpace(),
                                  Text(
                                    course?.description ?? '',
                                    style: const TextStyle(
                                        fontSize: kSubtitle1, color: kGrey),
                                    textAlign: TextAlign.start,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 4,
                                  ),
                                  addVerticalSpace(),
                                  PrimaryButton(
                                    label: 'Sluiten',
                                    onPress: () {
                                      Navigator.push(
                                          context,
                                          CupertinoPageRoute(
                                              settings: const RouteSettings(
                                                  name: "/profileScreen"),
                                              builder: (context) =>
                                                  const ProfileScreen()));
                                    },
                                  )
                                ],
                              );
                            }),
                          ),
                        ],
                      );
                    },
                  ));
        }
      },
    );
  }

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
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text('Voeg een nieuwe cursus licentie toe',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: kHeader1,
                    color: kSecondaryColor)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                height: 40,
                child: Center(
                    child: TextField(
                  controller: _myController,
                  textAlign: TextAlign.center,
                  showCursor: false,
                  decoration: const InputDecoration(
                    hintText: "0000-0000-0000",
                    counterText: "",
                  ),
                  style: const TextStyle(fontSize: kHeader1),
                  // Disable the default soft keybaord
                  keyboardType: TextInputType.none,
                )),
              ),
            ),
            NumPad(
                buttonSize: 70,
                buttonColor: kLightGrey,
                iconColor: kSecondaryColor,
                controller: _myController,
                delete: () {
                  if (_myController.text.isNotEmpty) {
                    _myController.text = _myController.text
                        .substring(0, _myController.text.length - 1);
                  }
                },
                onSubmit: () {
                  checkLicenseCode(_myController.text);
                },
                loading: Provider.of<UserStore>(context, listen: true).loading),
          ],
        ),
      )),
    );
  }
}
