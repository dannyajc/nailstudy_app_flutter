import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:nailstudy_app_flutter/logic/courses/course_store.dart';
import 'package:nailstudy_app_flutter/logic/user/user_store.dart';
import 'package:nailstudy_app_flutter/screens/app_layout.dart';
import 'package:nailstudy_app_flutter/screens/chat/chat_screen.dart';
import 'package:nailstudy_app_flutter/screens/course/course_detail_page.dart';
import 'package:nailstudy_app_flutter/screens/course/lesson_pages_container.dart';
import 'package:nailstudy_app_flutter/screens/home/home_screen.dart';
import 'package:nailstudy_app_flutter/screens/login/login_screen.dart';
import 'package:nailstudy_app_flutter/screens/login/register_screen.dart';
import 'package:nailstudy_app_flutter/screens/profile/profile_screen.dart';
import 'package:nailstudy_app_flutter/screens/webshop/webshop_screen.dart';
import 'package:provider/provider.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FlutterNativeSplash.removeAfter(initialization);
  initializeDateFormatting('nl_NL', null).then((_) => runApp(MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => UserStore()),
          ChangeNotifierProvider(create: (context) => CourseStore()),
        ],
        child: const MyApp(),
      )));
  // runApp(ChangeNotifierProvider(
  //     create: (context) => UserStore(), child: const MyApp()));
}

void initialization(BuildContext context) async {
  print('ready in 3...');
  await Future.delayed(const Duration(seconds: 1));
  print('go!');
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
      home: const LoginScreen(),
      // initialRoute: '/applayout',
      routes: {
        // '/home': (context) => const AppLayout(),
        // '/login': (context) => const LoginScreen(),
        // '/register': (context) => const RegisterScreen(),
        // '/chat': (context) => const ChatScreen(),
        // '/webshop': (context) => const WebshopScreen(),
        // '/profile': (context) => const ProfileScreen(),
        // '/courseDetail': (context) => const CourseDetailPage(),
        // '/lessonPager': (context) => const LessonPagerContainer(),
      },
    );
  }
}
