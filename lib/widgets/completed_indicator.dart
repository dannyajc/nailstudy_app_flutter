import 'package:flutter/material.dart';
import 'package:nailstudy_app_flutter/constants.dart';

class CompletedIndicator extends StatelessWidget {
  const CompletedIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: kCompletedColor, borderRadius: BorderRadius.circular(8.0)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 2.0),
        child: Row(
          children: const [
            Icon(
              Icons.check,
              color: Colors.white,
              size: 20,
            ),
            Text('Afgerond',
                style: TextStyle(fontSize: kParagraph1, color: Colors.white)),
          ],
        ),
      ),
    );
  }
}
