import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nailstudy_app_flutter/constants.dart';
import 'package:nailstudy_app_flutter/logic/user/user_store.dart';
import 'package:nailstudy_app_flutter/screens/app_layout.dart';
import 'package:nailstudy_app_flutter/screens/login/register_screen.dart';
import 'package:nailstudy_app_flutter/utils/spacing.dart';
import 'package:nailstudy_app_flutter/widgets/primary_button.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool emailValid = true;
  bool passwordValid = true;

  void loginToFirebase(BuildContext context) {
    if (emailController.text.isEmpty ||
        !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(emailController.text)) {
      setState(() {
        emailValid = false;
      });
    } else {
      setState(() {
        emailValid = true;
      });
    }

    if (passwordController.text.isEmpty) {
      setState(() {
        passwordValid = false;
      });
    } else {
      setState(() {
        passwordValid = true;
      });
    }

    if (passwordValid && emailValid) {
      firebaseAuth
          .signInWithEmailAndPassword(
              email: emailController.text, password: passwordController.text)
          .then((result) async {
        Provider.of<UserStore>(context, listen: false).fetchSelf().then((_) => {
              if (!Provider.of<UserStore>(context, listen: false).loading)
                {
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) =>
                              AppLayout(uid: result.user?.uid)))
                }
            });
      }).catchError((error) {
        var content = '';
        switch (error.code) {
          case 'user-not-found':
            content = 'Er bestaat geen gebruiker met dit e-mailadres';
            break;
          case 'wrong-password':
            content = 'De ingevoerde inloggegevens zijn onjuist';
            break;
        }
        print(error.message);
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Oops.."),
                content: Text(content),
                actions: [
                  TextButton(
                    child: const Text("Ok"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              );
            });
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: Remove
    emailController.text = 'danny1_janssen@msn.com';
    passwordController.text = 'test123';
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kDefaultBackgroundColor,
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
            if (!emailValid)
              const Text('Geen geldig e-mailadres',
                  style: TextStyle(fontSize: kParagraph1, color: kErrorColor)),
            CupertinoTextField(
              controller: emailController,
              placeholder: 'E-mailadres',
              padding: const EdgeInsets.all(kDefaultPadding),
              decoration: BoxDecoration(
                  color: kLightGrey, borderRadius: BorderRadius.circular(8.0)),
              autocorrect: false,
            ),
            addVerticalSpace(),
            if (!passwordValid)
              const Text('Geen geldig wachtwoord',
                  style: TextStyle(fontSize: kParagraph1, color: kErrorColor)),
            CupertinoTextField(
              controller: passwordController,
              placeholder: 'Wachtwoord',
              padding: const EdgeInsets.all(kDefaultPadding),
              decoration: BoxDecoration(
                  color: kLightGrey, borderRadius: BorderRadius.circular(8.0)),
              obscureText: true,
              autocorrect: false,
            ),
            addVerticalSpace(),
            const Align(
              alignment: Alignment.centerRight,
              child: Text('Wachtwoord vergeten',
                  style:
                      TextStyle(fontSize: kParagraph1, color: kSecondaryColor)),
            ),
            const Spacer(),
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
                child: const Text('Registreren',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: kParagraph1,
                        color: kSecondaryColor)),
              ),
            ),
            addVerticalSpace(),
            PrimaryButton(
                label: 'Log in',
                onPress: () {
                  loginToFirebase(context);
                },
                loading: Provider.of<UserStore>(context, listen: false).loading)
          ],
        ),
      )),
    );
  }
}
