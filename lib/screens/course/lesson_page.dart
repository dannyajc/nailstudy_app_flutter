import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nailstudy_app_flutter/constants.dart';
import 'package:nailstudy_app_flutter/screens/course/subject_paragraph.dart';
import 'package:nailstudy_app_flutter/utils/spacing.dart';

class LessonPage extends StatelessWidget {
  final int currentSubject;
  final PageController pageController;

  const LessonPage({
    Key? key,
    required this.currentSubject,
    required this.pageController,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final hasBackButton = currentSubject != 0;

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 5,
                    blurRadius: 10,
                  ),
                ],
              ),
              child: CachedNetworkImage(
                imageUrl:
                    'https://images.unsplash.com/photo-1533158628620-7e35717d36e8?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2400&q=80',
                imageBuilder: (context, imageProvider) => Container(
                  width: MediaQuery.of(context).size.width - 40,
                  height: 200.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(8.0),
                    image: DecorationImage(
                        image: imageProvider, fit: BoxFit.cover),
                  ),
                ),
                placeholder: (context, url) =>
                    const CircularProgressIndicator.adaptive(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                addVerticalSpace(),
                const Text(
                  'Theorie',
                  style:
                      TextStyle(fontSize: kParagraph1, color: kSecondaryColor),
                ),
                const Text(
                  'Hoe starten met Basis Acryl nagels',
                  style: TextStyle(
                      fontSize: kHeader2,
                      fontWeight: FontWeight.bold,
                      color: kSecondaryColor),
                ),
                addVerticalSpace(),
                const SubjectParagraph(
                  title: 'Stap 1',
                  text:
                      'Dit is een beschrijving van de cursus. Een erg lange tekst maken we er van, Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lore hrijving van de cursus. Een erg lange tekst maken we er van, Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lore hrijving van de cursus. Een erg lange tekst maken we er van, Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lore',
                ),
                const SubjectParagraph(
                  title: 'Stap 2',
                  imageUrl:
                      'https://images.unsplash.com/photo-1533158628620-7e35717d36e8?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2400&q=80',
                  text:
                      'Dit is een beschrijving van de cursus. Een erg lange tekst maken we er van, Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lore hrijving van de cursus. Een erg lange tekst maken we er van, Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lore hrijving van de cursus. Een erg lange tekst maken we er van, Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lore',
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    (hasBackButton)
                        ? Expanded(
                            flex: 1,
                            child: CupertinoButton(
                              padding: const EdgeInsets.all(0),
                              color: kPrimaryColor,
                              borderRadius: BorderRadius.circular(8.0),
                              onPressed: () {
                                pageController.previousPage(
                                    duration: const Duration(milliseconds: 400),
                                    curve: Curves.easeInOut);
                              },
                              child: Container(
                                height: 70,
                                padding: EdgeInsets.symmetric(
                                    horizontal: hasBackButton ? 10 : 30),
                                child: Row(
                                  mainAxisAlignment: hasBackButton
                                      ? MainAxisAlignment.center
                                      : MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Vorige onderwerp',
                                      style: TextStyle(
                                          fontSize: kSubtitle1,
                                          color: kSecondaryColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    (hasBackButton)
                                        ? Container()
                                        : const Icon(
                                            Icons.east,
                                            color: kSecondaryColor,
                                          )
                                  ],
                                ),
                              ),
                            ),
                          )
                        : Container(),
                    (hasBackButton)
                        ? const SizedBox(
                            width: 10,
                          )
                        : Container(),
                    Expanded(
                      flex: 1,
                      child: CupertinoButton(
                        padding: const EdgeInsets.all(0),
                        color: kPrimaryColor,
                        borderRadius: BorderRadius.circular(8.0),
                        onPressed: () {
                          pageController.nextPage(
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.easeInOut);
                        },
                        child: Container(
                          height: 70,
                          padding: EdgeInsets.symmetric(
                              horizontal: hasBackButton ? 10 : 30),
                          child: Row(
                            mainAxisAlignment: hasBackButton
                                ? MainAxisAlignment.center
                                : MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Volgende onderwerp',
                                style: TextStyle(
                                    fontSize: kSubtitle1,
                                    color: kSecondaryColor,
                                    fontWeight: FontWeight.bold),
                              ),
                              (hasBackButton)
                                  ? Container()
                                  : const Icon(
                                      Icons.east,
                                      color: kSecondaryColor,
                                    )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                addVerticalSpace(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
