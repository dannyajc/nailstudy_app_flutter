import 'package:flutter/material.dart';
import 'package:nailstudy_app_flutter/constants.dart';
import 'package:nailstudy_app_flutter/utils/spacing.dart';

// KeyPad widget
// This widget is reusable and its buttons are customizable (color, size)
class NumPad extends StatelessWidget {
  final double buttonSize;
  final Color buttonColor;
  final Color iconColor;
  final TextEditingController controller;
  final Function delete;
  final Function onSubmit;
  final bool loading;

  const NumPad({
    Key? key,
    this.buttonSize = 70,
    this.buttonColor = Colors.indigo,
    this.iconColor = Colors.amber,
    required this.delete,
    required this.onSubmit,
    required this.controller,
    required this.loading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        addVerticalSpace(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          // implement the number keys (from 0 to 9) with the NumberButton widget
          // the NumberButton widget is defined in the bottom of this file
          children: [
            NumberButton(
              number: 1,
              size: buttonSize,
              color: buttonColor,
              controller: controller,
            ),
            NumberButton(
              number: 2,
              size: buttonSize,
              color: buttonColor,
              controller: controller,
            ),
            NumberButton(
              number: 3,
              size: buttonSize,
              color: buttonColor,
              controller: controller,
            ),
          ],
        ),
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            NumberButton(
              number: 4,
              size: buttonSize,
              color: buttonColor,
              controller: controller,
            ),
            NumberButton(
              number: 5,
              size: buttonSize,
              color: buttonColor,
              controller: controller,
            ),
            NumberButton(
              number: 6,
              size: buttonSize,
              color: buttonColor,
              controller: controller,
            ),
          ],
        ),
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            NumberButton(
              number: 7,
              size: buttonSize,
              color: buttonColor,
              controller: controller,
            ),
            NumberButton(
              number: 8,
              size: buttonSize,
              color: buttonColor,
              controller: controller,
            ),
            NumberButton(
              number: 9,
              size: buttonSize,
              color: buttonColor,
              controller: controller,
            ),
          ],
        ),
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // this button is used to delete the last number
            IconButton(
              onPressed: () => delete(),
              icon: Icon(
                Icons.backspace,
                color: iconColor,
              ),
              iconSize: buttonSize / 2,
            ),
            NumberButton(
              number: 0,
              size: buttonSize,
              color: buttonColor,
              controller: controller,
            ),
            loading
                ? const CircularProgressIndicator.adaptive()
                : IconButton(
                    onPressed: () => onSubmit(),
                    icon: Icon(
                      Icons.check,
                      color: iconColor,
                    ),
                    iconSize: buttonSize / 2,
                  ),
          ],
        ),
      ],
    );
  }
}

// define NumberButton widget
// its shape is round
class NumberButton extends StatelessWidget {
  final int number;
  final double size;
  final Color color;
  final TextEditingController controller;

  const NumberButton({
    Key? key,
    required this.number,
    required this.size,
    required this.color,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: GestureDetector(
        onTap: () {
          if (controller.text.length < 14) {
            controller.text += number.toString();
          }
        },
        child: Container(
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          child: Center(
            child: Text(
              number.toString(),
              style: const TextStyle(color: kSecondaryColor, fontSize: 20),
            ),
          ),
        ),
      ),
    );
  }
}
