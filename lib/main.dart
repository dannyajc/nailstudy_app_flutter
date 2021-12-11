import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:nailstudy_app_flutter/constants.dart';
import 'package:nailstudy_app_flutter/widgets/expiry_indicator.dart';
import 'package:percent_indicator/percent_indicator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          textTheme: GoogleFonts.montserratTextTheme(Theme.of(context)
              .textTheme
              .copyWith(headline6: const TextStyle(fontWeight: FontWeight.w300))
              .apply(
                bodyColor: Colors.white,
                displayColor: Colors.white,
              ))),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var screen = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('Hi! Danny', style: Theme.of(context).textTheme.headline5),
        elevation: 0,
        backgroundColor: kDefaultBackgroundColor,
        actions: [
          ClipOval(
              child: Material(
            color: kDefaultBackgroundColor, // Button color
            child: InkWell(
              splashColor: kPrimaryColor, // Splash color
              onTap: () {},
              child: const SizedBox(
                width: 56,
                height: 56,
                child: Icon(Icons.face),
              ),
            ),
          ))
        ],
      ),
      backgroundColor: kDefaultBackgroundColor,
      body: Container(
          padding: const EdgeInsets.all(kDefaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Lottie.asset('assets/lottie/live.json', width: 30),
                  Text('Lopende cursus',
                      style: Theme.of(context).textTheme.headline6),
                ],
              ),
              Container(
                width: screen.width,
                height: 220,
                child: Stack(children: [
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 180,
                      width: screen.width,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: kAccentColor2.withAlpha(40),
                                blurRadius: 15.0,
                                offset: const Offset(0.0, 15))
                          ],
                          borderRadius: BorderRadius.circular(35),
                          gradient: const LinearGradient(
                              colors: [
                                kAccentColor,
                                kAccentColor2,
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              stops: [0.0, 1.0],
                              tileMode: TileMode.clamp)),
                      child: Container(
                        padding: const EdgeInsets.all(kDefaultPadding * 1.2),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 200,
                              child: Text(
                                'Verder gaan met je cursus?',
                                style: Theme.of(context).textTheme.headline6,
                              ),
                            ),
                            Text(
                              'Gellak',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: LinearPercentIndicator(
                                    //leaner progress bar
                                    animation: true,
                                    animationDuration: 1000,
                                    lineHeight: 10.0,
                                    percent: 80 / 100,
                                    linearStrokeCap: LinearStrokeCap.roundAll,
                                    linearGradient: const LinearGradient(
                                        colors: [
                                          kAccentColor,
                                          kAccentColor2,
                                        ],
                                        begin: FractionalOffset(0.0, 0.0),
                                        end: FractionalOffset(1.0, 0.0),
                                        stops: [0.0, 1.0],
                                        tileMode: TileMode.clamp),
                                    backgroundColor: Colors.grey[300],
                                  ),
                                ),
                                const ExpiryIndicator(),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                      right: 0,
                      top: 0,
                      child: SvgPicture.asset(
                        'assets/images/sitting-1.svg',
                        height: 175,
                      )),
                ]),
              ),
            ],
          )),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
