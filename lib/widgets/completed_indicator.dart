import 'package:flutter/material.dart';
import 'package:nailstudy_app_flutter/constants.dart';

class CompletedIndicator extends StatelessWidget {
  final int state;
  const CompletedIndicator({Key? key, required this.state}) : super(key: key);

  String getIndicatorText() {
    switch (state) {
      case 1:
        return "Inactief";
      case 2:
        return "Geannuleerd";
      case 3:
        return "Verlopen";
      default:
        return "Afgerond";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: kCompletedColor, borderRadius: BorderRadius.circular(8.0)),
      height: 25,
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: kDefaultPadding, vertical: 2.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(getIndicatorText(),
                style: const TextStyle(
                    fontSize: kParagraph1, color: Colors.white)),
            if (state == 0)
              const Icon(
                Icons.check,
                color: Colors.white,
                size: 10,
              ),
          ],
        ),
      ),
    );
  }
}
