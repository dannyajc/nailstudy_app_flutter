import 'package:flutter/material.dart';
import 'package:nailstudy_app_flutter/screens/app_layout.dart';
import 'package:nailstudy_app_flutter/screens/chat/chat_screen.dart';
import 'package:nailstudy_app_flutter/screens/course/course_detail_page.dart';
import 'package:nailstudy_app_flutter/screens/course/lesson_pages_container.dart';
import 'package:nailstudy_app_flutter/screens/profile/profile_screen.dart';
import 'package:nailstudy_app_flutter/screens/webshop/webshop_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nail Study',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'SF Pro Display',
      ),
      home: const AppLayout(),
      // initialRoute: '/applayout',
      routes: {
        '/applayout': (context) => const AppLayout(),
        // '/': (context) => HomeScreen(),
        '/chat': (context) => const ChatScreen(),
        '/webshop': (context) => const WebshopScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/courseDetail': (context) => const CourseDetailPage(),
        '/lessonPager': (context) => const LessonPagerContainer(),
      },
    );
  }
}
