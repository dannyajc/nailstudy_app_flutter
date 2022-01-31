import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nailstudy_app_flutter/constants.dart';

class PrimaryButton extends StatelessWidget {
  final VoidCallback onPress;
  const PrimaryButton({Key? key, required this.onPress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: const EdgeInsets.all(0),
      color: kPrimaryColor,
      borderRadius: BorderRadius.circular(8.0),
      onPressed: onPress,
      child: Container(
        alignment: Alignment.center,
        height: 70,
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Text(
          'Log in',
          style: const TextStyle(
              fontSize: kSubtitle1,
              color: kSecondaryColor,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
