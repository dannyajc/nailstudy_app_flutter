import 'package:flutter/material.dart';

class ExpiryIndicator extends StatelessWidget {
  const ExpiryIndicator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.schedule,
          size: 15,
          color: Colors.red,
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          '2 dagen over',
          style: Theme.of(context)
              .textTheme
              .bodyText2!
              .copyWith(color: Colors.red),
        ),
      ],
    );
  }
}
