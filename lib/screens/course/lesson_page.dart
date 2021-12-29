import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nailstudy_app_flutter/constants.dart';
import 'package:nailstudy_app_flutter/screens/course/course_detail_page.dart';
import 'package:nailstudy_app_flutter/screens/course/lesson_card.dart';
import 'package:nailstudy_app_flutter/utils/spacing.dart';
import 'package:nailstudy_app_flutter/widgets/expandable_text.dart';
import 'package:nailstudy_app_flutter/widgets/expiry_card.dart';
import 'package:nailstudy_app_flutter/widgets/progress_course.dart';

class LessonPage extends StatelessWidget {
  const LessonPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kDefaultBackgroundColor,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: kSecondaryColor,
          ),
          iconSize: 20.0,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: const Text('Les 1 | Onderwerp 3',
            style: TextStyle(fontSize: kHeader2, color: kSecondaryColor)),
      ),
      body: SingleChildScrollView(
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
                    style: TextStyle(
                        fontSize: kParagraph1, color: kSecondaryColor),
                  ),
                  const Text(
                    'Hoe starten met Basis Acryl nagels',
                    style: TextStyle(
                        fontSize: kHeader2,
                        fontWeight: FontWeight.bold,
                        color: kSecondaryColor),
                  ),
                  addVerticalSpace(),
                  const Text(
                    'Dit is een beschrijving van de cursus. Een erg lange tekst maken we er van, Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lore hrijving van de cursus. Een erg lange tekst maken we er van, Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lore hrijving van de cursus. Een erg lange tekst maken we er van, Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lore',
                    style: TextStyle(fontSize: kParagraph1, color: kGrey),
                  ),
                  addVerticalSpace(),
                  CachedNetworkImage(
                    imageUrl:
                        'https://images.unsplash.com/photo-1533158628620-7e35717d36e8?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2400&q=80',
                    imageBuilder: (context, imageProvider) => Container(
                      width: MediaQuery.of(context).size.width - 40,
                      height: 200.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(8.0),
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.fitWidth),
                      ),
                    ),
                    placeholder: (context, url) =>
                        const CircularProgressIndicator.adaptive(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
