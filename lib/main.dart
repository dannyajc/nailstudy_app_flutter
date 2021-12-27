import 'package:flutter/material.dart';
import 'package:nailstudy_app_flutter/screens/chat/chat_screen.dart';
import 'package:nailstudy_app_flutter/screens/home/home_screen.dart';
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
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/chat': (context) => ChatScreen(),
        '/webshop': (context) => WebshopScreen(),
        '/profile': (context) => ProfileScreen(),
      },
    );
  }
}
