import 'package:flutter/material.dart';
import 'package:nailstudy_app_flutter/constants.dart';

class ApprovalItem extends StatelessWidget {
  final String courseName;
  const ApprovalItem({Key? key, required this.courseName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(courseName,
            style:
                const TextStyle(color: kSecondaryColor, fontSize: kSubtitle1)),
        Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.check_circle_outlined,
                size: 35,
                color: kAccentColor,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.cancel_outlined,
                size: 35,
                color: kErrorColor,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
