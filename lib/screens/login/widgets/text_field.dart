import 'package:flutter/material.dart';
import 'package:nailstudy_app_flutter/constants.dart';

class TextField extends StatelessWidget {
  const TextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 60,
      decoration: BoxDecoration(
          color: kLightGrey,
          borderRadius: BorderRadius.circular(kDefaultBorderRadius)),
    );
  }
}
