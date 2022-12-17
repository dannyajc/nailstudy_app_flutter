import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nailstudy_app_flutter/constants.dart';
import 'package:nailstudy_app_flutter/logic/user/user_store.dart';
import 'package:nailstudy_app_flutter/screens/app_layout.dart';
import 'package:nailstudy_app_flutter/utils/spacing.dart';
import 'package:nailstudy_app_flutter/widgets/primary_button.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool firstNameValid = true;
  bool lastNameValid = true;
  bool phoneValid = true;
  bool emailValid = true;
  bool passwordValid = true;
  bool loading = false;
  bool? acceptedTerms = null;

  void registerToFirebase(BuildContext context) {
    setState(() {
      passwordValid = passwordController.text.isNotEmpty;
      emailValid = emailController.text.isNotEmpty &&
          RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
              .hasMatch(emailController.text);
      phoneValid = phoneController.text.isNotEmpty;
      firstNameValid = firstNameController.text.isNotEmpty;
      lastNameValid = lastNameController.text.isNotEmpty;
      acceptedTerms = acceptedTerms ?? false;
    });

    if (passwordValid &&
        emailValid &&
        firstNameValid &&
        lastNameValid &&
        phoneValid &&
        (acceptedTerms != null && acceptedTerms == true)) {
      Provider.of<UserStore>(context, listen: false)
          .registerUser(
              firstNameController.text.trim(),
              lastNameController.text.trim(),
              emailController.text.trim(),
              passwordController.text.trim(),
              phoneController.text.trim())
          .then((value) => {
                if (!Provider.of<UserStore>(context, listen: false).loading)
                  {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => const AppLayout()))
                  }
              });
    }
  }

  @override
  void dispose() {
    super.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
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
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 40, left: 20, right: 20),
            child: SizedBox(
              height: MediaQuery.of(context).size.height -
                  kTabBarHeight -
                  MediaQuery.of(context).padding.top -
                  50,
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
                  if (!firstNameValid || !lastNameValid)
                    const Text('Voer uw volledige naam in',
                        style: TextStyle(
                            fontSize: kParagraph1, color: kErrorColor)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 1,
                        child: CupertinoTextField(
                          controller: firstNameController,
                          placeholder: 'Voornaam',
                          padding: const EdgeInsets.all(kDefaultPadding),
                          decoration: BoxDecoration(
                              color: kLightGrey,
                              borderRadius:
                                  BorderRadius.circular(kDefaultBorderRadius)),
                          autocorrect: false,
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        flex: 1,
                        child: CupertinoTextField(
                          controller: lastNameController,
                          placeholder: 'Achternaam',
                          padding: const EdgeInsets.all(kDefaultPadding),
                          decoration: BoxDecoration(
                              color: kLightGrey,
                              borderRadius:
                                  BorderRadius.circular(kDefaultBorderRadius)),
                          autocorrect: false,
                        ),
                      ),
                    ],
                  ),
                  addVerticalSpace(),
                  if (!emailValid)
                    const Text('Geen geldig emailadres',
                        style: TextStyle(
                            fontSize: kParagraph1, color: kErrorColor)),
                  CupertinoTextField(
                    controller: emailController,
                    placeholder: 'E-mailadres',
                    padding: const EdgeInsets.all(kDefaultPadding),
                    decoration: BoxDecoration(
                        color: kLightGrey,
                        borderRadius:
                            BorderRadius.circular(kDefaultBorderRadius)),
                    autocorrect: false,
                  ),
                  addVerticalSpace(),
                  if (!passwordValid)
                    const Text('Geen geldig wachtwoord',
                        style: TextStyle(
                            fontSize: kParagraph1, color: kErrorColor)),
                  CupertinoTextField(
                    controller: passwordController,
                    placeholder: 'Wachtwoord',
                    padding: const EdgeInsets.all(kDefaultPadding),
                    decoration: BoxDecoration(
                        color: kLightGrey,
                        borderRadius:
                            BorderRadius.circular(kDefaultBorderRadius)),
                    obscureText: true,
                    autocorrect: false,
                  ),
                  addVerticalSpace(),
                  if (!phoneValid)
                    const Text('Geen geldig telefoonnummer',
                        style: TextStyle(
                            fontSize: kParagraph1, color: kErrorColor)),
                  CupertinoTextField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    placeholder: 'Telefoonnummer',
                    padding: const EdgeInsets.all(kDefaultPadding),
                    decoration: BoxDecoration(
                        color: kLightGrey,
                        borderRadius:
                            BorderRadius.circular(kDefaultBorderRadius)),
                    autocorrect: false,
                  ),
                  addVerticalSpace(),
                  if (acceptedTerms != null && acceptedTerms == false)
                    const Text('U moet akkoord gaan met de voorwaarden',
                        style: TextStyle(
                            fontSize: kParagraph1, color: kErrorColor)),
                  CheckboxListTile(
                      contentPadding: EdgeInsets.zero,
                      title: const Text(
                          'Ik ga akkoord met de voorwaarden.\nZie website.'),
                      activeColor: Colors.amber,
                      value: acceptedTerms ?? false,
                      onChanged: (newValue) {
                        setState(() {
                          acceptedTerms = newValue!;
                        });
                      },
                      controlAffinity: ListTileControlAffinity.leading),
                  const Spacer(),
                  Center(
                    child: GestureDetector(
                      onTapUp: (_) {
                        Navigator.pop(context);
                      },
                      child: const Text('Al een account? Log in!',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: kParagraph1,
                              color: kSecondaryColor)),
                    ),
                  ),
                  addVerticalSpace(),
                  PrimaryButton(
                    label: 'Registreren',
                    onPress: () {
                      registerToFirebase(context);
                    },
                    loading: Provider.of<UserStore>(context).loading,
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
