import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nailstudy_app_flutter/constants.dart';
import 'package:nailstudy_app_flutter/logic/user/user_store.dart';
import 'package:nailstudy_app_flutter/logic/utils/auth_status.dart';
import 'package:nailstudy_app_flutter/screens/app_layout.dart';
import 'package:nailstudy_app_flutter/utils/spacing.dart';
import 'package:nailstudy_app_flutter/widgets/primary_button.dart';
import 'package:provider/provider.dart';

class PasswordResetScreen extends StatefulWidget {
  const PasswordResetScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<PasswordResetScreen> {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  TextEditingController emailController = TextEditingController();

  bool emailValid = true;
  bool loading = false;

  void resetPassword(BuildContext context) {
    setState(() {
      emailValid = emailController.text.isNotEmpty &&
          RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
              .hasMatch(emailController.text);
    });

    if (emailValid) {
      Provider.of<UserStore>(context, listen: false)
          .resetPassword(email: emailController.text.trim())
          .then((value) => {
                if (!Provider.of<UserStore>(context, listen: false).loading &&
                    Provider.of<UserStore>(context, listen: false).authStatus ==
                        AuthStatus.successful)
                  {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text("Uw verzoek is verstuurd"),
                            content: const Text(
                                "Als het opgegeven emailadres is gekoppeld aan een account is daar nu een mail naar verstuurd om uw wachtwoord opnieuw in te stellen. Mogelijk komt deze mail aan in uw spam-box."),
                            actions: [
                              TextButton(
                                child: const Text("Ok"),
                                onPressed: () {
                                  Navigator.of(context)
                                      .popUntil((route) => route.isFirst);
                                },
                              )
                            ],
                          );
                        })
                  }
                else
                  {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text("Oops.."),
                            content: const Text(
                                "Er is iets mis gegaan. Probeer het later opnieuw."),
                            actions: [
                              TextButton(
                                child: const Text("Ok"),
                                onPressed: () {
                                  Navigator.of(context)
                                      .popUntil((route) => route.isFirst);
                                },
                              )
                            ],
                          );
                        })
                  }
              });
    }
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
  }

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
        resizeToAvoidBottomInset: true,
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
                const Text('Wachtwoord vergeten',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: kHeader1,
                        color: kSecondaryColor)),
                addVerticalSpace(),
                const Text(
                    'Vul het emailadres in van het account waarvan je het wachtwoord bent vergeten',
                    style: TextStyle(fontSize: kParagraph1, color: kGrey)),
                addVerticalSpace(),
                if (!emailValid)
                  const Text('Geen geldig emailadres',
                      style:
                          TextStyle(fontSize: kParagraph1, color: kErrorColor)),
                CupertinoTextField(
                  controller: emailController,
                  placeholder: 'E-mailadres',
                  padding: const EdgeInsets.all(kDefaultPadding),
                  decoration: BoxDecoration(
                      color: kLightGrey,
                      borderRadius: BorderRadius.circular(8.0)),
                  autocorrect: false,
                ),
                addVerticalSpace(),
                const Spacer(),
                Center(
                  child: GestureDetector(
                    onTapUp: (_) {
                      Navigator.pop(context);
                    },
                    child: const Text('Terug naar log in',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: kParagraph1,
                            color: kSecondaryColor)),
                  ),
                ),
                addVerticalSpace(),
                PrimaryButton(
                  label: 'Versturen',
                  onPress: () {
                    resetPassword(context);
                  },
                  loading: Provider.of<UserStore>(context).loading,
                )
              ],
            ),
          ),
        ));
  }
}
