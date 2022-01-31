import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nailstudy_app_flutter/constants.dart';
import 'package:nailstudy_app_flutter/screens/app_layout.dart';
import 'package:nailstudy_app_flutter/screens/login/register_screen.dart';
import 'package:nailstudy_app_flutter/utils/spacing.dart';
import 'package:nailstudy_app_flutter/widgets/primary_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
      resizeToAvoidBottomInset: false,
      backgroundColor: kDefaultBackgroundColor,
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.only(bottom: 40, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('Welkom bij Nail Study',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: kHeader2,
                    color: kSecondaryColor)),
            const Text('Log in met je e-mail',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: kHeader1,
                    color: kSecondaryColor)),
            addVerticalSpace(),
            const Text(
                'Log hieronder in met je e-mailaders. Heb je nog geen account? Klik dan onderin op \'Registreren\'',
                style: TextStyle(fontSize: kParagraph1, color: kGrey)),
            addVerticalSpace(),
            CupertinoTextField(
              placeholder: 'E-mailadres',
              padding: const EdgeInsets.all(kDefaultPadding),
              decoration: BoxDecoration(
                  color: kLightGrey, borderRadius: BorderRadius.circular(8.0)),
              autocorrect: false,
            ),
            addVerticalSpace(),
            CupertinoTextField(
              placeholder: 'Wachtwoord',
              padding: const EdgeInsets.all(kDefaultPadding),
              decoration: BoxDecoration(
                  color: kLightGrey, borderRadius: BorderRadius.circular(8.0)),
              obscureText: true,
              autocorrect: false,
            ),
            addVerticalSpace(),
            Align(
              alignment: Alignment.centerRight,
              child: Text('Wachtwoord vergeten',
                  style:
                      TextStyle(fontSize: kParagraph1, color: kSecondaryColor)),
            ),
            Spacer(),
            Align(
              alignment: Alignment.center,
              child: TextButton(
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => const RegisterScreen()));
                },
                child: Text('Registreren',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: kParagraph1,
                        color: kSecondaryColor)),
              ),
            ),
            addVerticalSpace(),
            PrimaryButton(onPress: () {
              Navigator.push(context,
                  CupertinoPageRoute(builder: (context) => const AppLayout()));
            })
          ],
        ),
      )),
    );
  }
}
