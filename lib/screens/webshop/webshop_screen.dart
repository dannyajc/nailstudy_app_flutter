import 'package:flutter/material.dart';
import 'package:nailstudy_app_flutter/constants.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebshopScreen extends StatelessWidget {
  const WebshopScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: WebView(
        initialUrl: 'https://www.gailsnailacademy.nl/webshop/',
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
