import 'package:flutter/material.dart';
import 'package:nailstudy_app_flutter/constants.dart';
import 'package:nailstudy_app_flutter/logic/user/user_store.dart';
import 'package:provider/provider.dart';

class ApprovalItem extends StatelessWidget {
  final String courseName;
  final String courseId;
  final String endUserId;

  const ApprovalItem({
    Key? key,
    required this.courseName,
    required this.courseId,
    required this.endUserId,
  }) : super(key: key);

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
              onPressed: () {
                Provider.of<UserStore>(context, listen: false)
                    .approveLesson(courseId, endUserId);
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.check_circle_outlined,
                size: 35,
                color: kAccentColor,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
