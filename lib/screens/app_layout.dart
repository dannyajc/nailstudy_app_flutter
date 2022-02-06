import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nailstudy_app_flutter/constants.dart';
import 'package:nailstudy_app_flutter/logic/user/user_store.dart';
import 'package:nailstudy_app_flutter/screens/chat/chat_screen.dart';
import 'package:nailstudy_app_flutter/screens/home/home_screen.dart';
import 'package:nailstudy_app_flutter/screens/profile/profile_screen.dart';
import 'package:nailstudy_app_flutter/screens/webshop/webshop_screen.dart';
import 'package:provider/provider.dart';

class AppLayout extends StatefulWidget {
  final String? uid;
  const AppLayout({Key? key, this.uid}) : super(key: key);

  @override
  _AppLayoutState createState() => _AppLayoutState();
}

class _AppLayoutState extends State<AppLayout> {
  // int _currentIndex = 0;

  // final _page1 = GlobalKey<NavigatorState>();
  // final _page2 = GlobalKey<NavigatorState>();
  // final _page3 = GlobalKey<NavigatorState>();
  // final _page4 = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: CupertinoTabScaffold(
          tabBar: CupertinoTabBar(
            activeColor: Colors.black,
            inactiveColor: kGrey,
            backgroundColor: kLightGrey,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.chat_outlined),
                label: 'Chat',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.public_outlined),
                label: 'Webshop',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                label: 'Profiel',
              ),
            ],
          ),
          tabBuilder: (context, index) {
            switch (index) {
              case 0:
                return CupertinoTabView(builder: (context) {
                  return CupertinoPageScaffold(child: HomeScreen());
                });
              case 1:
                return CupertinoTabView(builder: (context) {
                  return const CupertinoPageScaffold(child: ChatScreen());
                });
              case 2:
                return CupertinoTabView(builder: (context) {
                  return const CupertinoPageScaffold(child: WebshopScreen());
                });
              case 3:
                return CupertinoTabView(builder: (context) {
                  return const CupertinoPageScaffold(child: ProfileScreen());
                });
              default:
                return CupertinoTabView(builder: (context) {
                  return const CupertinoPageScaffold(child: HomeScreen());
                });
            }
          }),
    );

    // return Scaffold(
    //   body: IndexedStack(
    //     index: _currentIndex,
    //     children: <Widget>[
    //       Navigator(
    //         key: _page1,
    //         onGenerateRoute: (route) => MaterialPageRoute(
    //           settings: route,
    //           builder: (context) => HomeScreen(),
    //         ),
    //       ),
    //       Navigator(
    //         key: _page2,
    //         onGenerateRoute: (route) => MaterialPageRoute(
    //           settings: route,
    //           builder: (context) => ChatScreen(),
    //         ),
    //       ),
    //       Navigator(
    //         key: _page3,
    //         onGenerateRoute: (route) => MaterialPageRoute(
    //           settings: route,
    //           builder: (context) => WebshopScreen(),
    //         ),
    //       ),
    //       Navigator(
    //         key: _page4,
    //         onGenerateRoute: (route) => MaterialPageRoute(
    //           settings: route,
    //           builder: (context) => ProfileScreen(),
    //         ),
    //       ),
    //     ],
    //   ),
    //   bottomNavigationBar: BottomNavigationBar(
    //     items: const <BottomNavigationBarItem>[
    //       BottomNavigationBarItem(
    //         icon: Icon(Icons.home_outlined),
    //         label: 'Home',
    //       ),
    //       BottomNavigationBarItem(
    //         icon: Icon(Icons.chat_outlined),
    //         label: 'Chat',
    //       ),
    //       BottomNavigationBarItem(
    //         icon: Icon(Icons.public_outlined),
    //         label: 'Webshop',
    //       ),
    //       BottomNavigationBarItem(
    //         icon: Icon(Icons.person_outline),
    //         label: 'Profiel',
    //       ),
    //     ],
    //     currentIndex: _currentIndex,
    //     selectedItemColor: Colors.black,
    //     unselectedItemColor: kGrey,
    //     showUnselectedLabels: true,
    //     type: BottomNavigationBarType.fixed,
    //     backgroundColor: kLightGrey,
    //     onTap: (index) {
    //       setState(() {
    //         _currentIndex = index;
    //       });
    //     },
    //   ),
    // );
  }
}
