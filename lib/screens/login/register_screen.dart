import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nailstudy_app_flutter/constants.dart';
import 'package:nailstudy_app_flutter/utils/spacing.dart';
import 'package:nailstudy_app_flutter/widgets/primary_button.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
            const Text('Creëer je account',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: kHeader1,
                    color: kSecondaryColor)),
            addVerticalSpace(),
            const Text(
                'Vul hieronder je gegevens in om aan de slag te gaan met Nail Study',
                style: TextStyle(fontSize: kParagraph1, color: kGrey)),
            addVerticalSpace(),
            CupertinoTextField(
              placeholder: 'Naam',
              padding: const EdgeInsets.all(kDefaultPadding),
              decoration: BoxDecoration(
                  color: kLightGrey, borderRadius: BorderRadius.circular(8.0)),
              autocorrect: false,
            ),
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
            CupertinoTextField(
              placeholder: 'Telefoonnummer',
              padding: const EdgeInsets.all(kDefaultPadding),
              decoration: BoxDecoration(
                  color: kLightGrey, borderRadius: BorderRadius.circular(8.0)),
              autocorrect: false,
            ),
            addVerticalSpace(),
            CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Ik ga akkoord met de voorwaarden'),
                value: false,
                onChanged: (newValue) {},
                controlAffinity: ListTileControlAffinity.leading),
            const Spacer(),
            const Align(
              alignment: Alignment.center,
              child: Text('Al een account? Log in!',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: kParagraph1,
                      color: kSecondaryColor)),
            ),
            addVerticalSpace(),
            PrimaryButton(
              onPress: () {},
            )
          ],
        ),
      )),
    );
  }
}
