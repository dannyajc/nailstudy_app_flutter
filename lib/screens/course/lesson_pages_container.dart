import 'package:flutter/material.dart';
import 'package:nailstudy_app_flutter/constants.dart';
import 'package:collection/collection.dart';
import 'package:nailstudy_app_flutter/screens/course/lesson_page.dart';

class LessonPagerContainer extends StatefulWidget {
  final List<int> amountOfSubjects;
  const LessonPagerContainer({Key? key, this.amountOfSubjects = const []})
      : super(key: key);

  @override
  _LessonPagerContainerState createState() => _LessonPagerContainerState();
}

class _LessonPagerContainerState extends State<LessonPagerContainer> {
  int currentSubject = 0;

  @override
  Widget build(BuildContext context) {
    // TODO: initial page to where the user left off
    final PageController controller = PageController();
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
        title: Text('Les 1 | Onderwerp $currentSubject',
            style: const TextStyle(fontSize: kHeader2, color: kSecondaryColor)),
      ),
      body: PageView(
        controller: controller,
        children: <Widget>[
          ...widget.amountOfSubjects.mapIndexed((item, index) => LessonPage(
                currentSubject: index,
                pageController: controller,
                totalPages: widget.amountOfSubjects.length,
              ))
        ],
        onPageChanged: (index) {
          setState(() {
            currentSubject = index;
          });
        },
      ),
    );
  }
}
