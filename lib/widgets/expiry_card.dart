import 'package:flutter/material.dart';
import 'package:nailstudy_app_flutter/constants.dart';

class ExpiryCard extends StatelessWidget {
  const ExpiryCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 5,
            blurRadius: 10,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Icon(
              Icons.schedule,
              size: 40,
              color: kSecondaryColor,
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(left: kDefaultPadding),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '3 weken over',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: kParagraph1,
                          color: kSecondaryColor),
                    ),
                    RichText(
                        text: const TextSpan(children: [
                      TextSpan(
                          text: 'Je hebt nog ',
                          style: TextStyle(
                              fontSize: kParagraph1, color: kSecondaryColor)),
                      TextSpan(
                          text: '3 weken',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: kParagraph1,
                              color: kSecondaryColor)),
                      TextSpan(
                          text: ' om deze cursus af te ronden',
                          style: TextStyle(
                              fontSize: kParagraph1, color: kSecondaryColor)),
                    ])),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
