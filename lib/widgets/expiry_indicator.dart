import 'package:flutter/material.dart';
import 'package:nailstudy_app_flutter/constants.dart';

class ExpiryIndicator extends StatelessWidget {
  final int daysLeft;

  const ExpiryIndicator({
    Key? key,
    required this.daysLeft,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var concatString = '';

    if (daysLeft < 14) {
      concatString = '$daysLeft dagen over';
    }
    if (daysLeft >= 14) {
      var weeks = (daysLeft / 7);
      concatString = '${weeks.round()} weken over';
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(
          Icons.schedule,
          size: 15,
          color: daysLeft < 7 ? Colors.red : kGrey,
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          concatString,
          style: Theme.of(context)
              .textTheme
              .bodyText2!
              .copyWith(color: daysLeft < 7 ? Colors.red : kGrey),
        ),
      ],
    );
  }
}
