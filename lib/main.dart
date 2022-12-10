import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:nailstudy_app_flutter/logic/courses/course_store.dart';
import 'package:nailstudy_app_flutter/logic/user/user_store.dart';
import 'package:nailstudy_app_flutter/screens/app_layout.dart';
import 'package:nailstudy_app_flutter/screens/login/login_screen.dart';
import 'package:provider/provider.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await initialization();
  await initializeDateFormatting('nl_NL', null)
      .then((_) => runApp(MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (context) => UserStore()),
              ChangeNotifierProvider(create: (context) => CourseStore()),
            ],
            child: const MyApp(),
          )));
}

Future<void> initialization() async {
  print('ready in 3...');
  await Future.delayed(const Duration(seconds: 1));
  FirebaseAuth.instance.authStateChanges().listen((User? user) {
    if (user != null) {
      user.reload();
    }
  });
  print('go!');
  FlutterNativeSplash.remove();
}

class MyApp extends StatefulWidget with WidgetsBindingObserver {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      FirebaseAuth.instance.authStateChanges().listen((User? user) {
        if (user != null) {
          user.reload();
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  Future<User?> getUser(BuildContext context) async {
    if (FirebaseAuth.instance.currentUser != null) {
      await Provider.of<UserStore>(context, listen: false)
          .fetchSelf(shouldNotify: false);
      return Future<User>.value(FirebaseAuth.instance.currentUser);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nail Study',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'SF Pro Display',
      ),
      home: FutureBuilder<User?>(
          future: getUser(context),
          builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
            if (snapshot.hasData) {
              User? user = snapshot.data;
              if (!Provider.of<UserStore>(context, listen: false).loading) {
                return AppLayout(uid: user?.uid);
              }
            }

            return const LoginScreen();
          }),
      builder: (context, child) {
        return MediaQuery(
          child: child!,
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        );
      },
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
