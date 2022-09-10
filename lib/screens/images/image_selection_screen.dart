import 'dart:io';
import 'package:collection/collection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:nailstudy_app_flutter/constants.dart';
import 'package:nailstudy_app_flutter/logic/chat/message_dao.dart';
import 'package:nailstudy_app_flutter/logic/chat/message_model.dart';
import 'package:nailstudy_app_flutter/logic/user/user_store.dart';
import 'package:nailstudy_app_flutter/utils/spacing.dart';
import 'package:provider/provider.dart';

class ImageSelectionScreen extends StatefulWidget {
  const ImageSelectionScreen({Key? key}) : super(key: key);

  @override
  _ImageSelectionScreenState createState() => _ImageSelectionScreenState();
}

class _ImageSelectionScreenState extends State<ImageSelectionScreen> {
  List<XFile> _imageFileList = [];

  final ImagePicker _picker = ImagePicker();
  String? _retrieveDataError;

  final messageDao = MessageDao();

  void _onImageButtonPressed(ImageSource source,
      {BuildContext? context, bool isMultiImage = false}) async {
    if (isMultiImage) {
      try {
        final pickedFileList = await _picker.pickMultiImage();
        setState(() {
          _imageFileList = pickedFileList!;
        });
      } catch (e) {
        setState(() {});
      }
    } else {
      try {
        final pickedFile = await _picker.pickImage(
          source: source,
        );
        setState(() {
          _imageFileList.add(pickedFile!);
        });
      } catch (e) {
        setState(() {});
      }
    }
  }

  Widget _previewImages() {
    final Text? retrieveError = _getRetrieveErrorWidget();
    var imageWidth =
        (MediaQuery.of(context).size.width - (kDefaultPadding * 2) - 15) / 3;

    if (retrieveError != null) {
      return retrieveError;
    }
    if (_imageFileList.isNotEmpty) {
      // return Container(
      //   height: 200,
      //   child: Row(
      //       children: _imageFileList.map((e) {
      //     return DottedBorder(
      //         borderType: BorderType.RRect,
      //         radius: const Radius.circular(20),
      //         dashPattern: [10, 10],
      //         color: Colors.grey,
      //         strokeWidth: 2,
      //         child: Card(
      //           color: Colors.amber,
      //           shape: RoundedRectangleBorder(
      //             borderRadius: BorderRadius.circular(10),
      //           ),
      //           child: const Center(child: Text("hi")),
      //         ));
      //   }).toList()),
      // );

      return Row(
        children: _imageFileList.mapIndexed((index, e) {
          return Container(
            padding: const EdgeInsets.only(right: 5),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.file(
                    File(e.path),
                    height: imageWidth * 1.4,
                    width: imageWidth,
                    fit: BoxFit.fitHeight,
                  ),
                ),
                addVerticalSpace(),
                GestureDetector(
                  child: const Icon(
                    Icons.highlight_off_outlined,
                    color: kGrey,
                    size: 30,
                  ),
                  onTap: () {
                    setState(() {
                      _imageFileList = List.from(_imageFileList)
                        ..removeAt(index);
                    });
                  },
                )
              ],
            ),
          );
        }).toList(),
      );
    } else {
      return Center(
        child: Column(
          children: [
            Lottie.asset('assets/lottie/manicure.json', width: 250),
            const Text(
              'Je hebt nog geen foto\'s gekozen.',
              textAlign: TextAlign.center,
            )
          ],
        ),
      );
    }
  }

  Future<void> retrieveLostData() async {
    final LostDataResponse response = await _picker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        _imageFileList = response.files!;
      });
    } else {
      _retrieveDataError = response.exception!.code;
    }
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Text? _getRetrieveErrorWidget() {
    if (_retrieveDataError != null) {
      final Text result = Text(_retrieveDataError!);
      _retrieveDataError = null;
      return result;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kDefaultBackgroundColor,
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: TextButton(
                onPressed: () async {
                  if (_imageFileList.isEmpty) {
                    Navigator.popUntil(
                        context, ModalRoute.withName('/courseDetail'));
                  } else {
                    var chatId =
                        await Provider.of<UserStore>(context, listen: false)
                            .getChatId();
                    if (chatId != null) {
                      _imageFileList.forEach((element) async {
                        final destination = 'files/${element.name}';

                        try {
                          final ref = FirebaseStorage.instance.ref(destination);
                          File file = File(element.path);

                          await ref.putFile(file);

                          Navigator.popUntil(
                              context, ModalRoute.withName('/courseDetail'));
                        } catch (e) {
                          print('error occured');
                        }
                      });

                      var currentCourse =
                          Provider.of<UserStore>(context, listen: false)
                              .currentCourse;

                      var now = DateTime.now().toLocal();
                      var formatter = DateFormat("d-M-yyyy HH:mm:ss");
                      var formattedDate = formatter.format(now);

                      var submission = Message(
                          senderId:
                              FirebaseAuth.instance.currentUser?.uid ?? '',
                          receiverId: adminId,
                          timeStamp: formattedDate,
                          images: _imageFileList.map((e) => e.name).toList(),
                          courseId: currentCourse?.courseId,
                          submitForApprovalLevel:
                              currentCourse?.currentLessonNumber);

                      messageDao.initiateChat(
                          FirebaseAuth.instance.currentUser?.uid ?? "",
                          adminId,
                          chatId);
                      messageDao.sendMessage(submission, chatId);

                      if (currentCourse != null &&
                          FirebaseAuth.instance.currentUser != null) {
                        Provider.of<UserStore>(context, listen: false)
                            .setNewPendingApproval(currentCourse.courseId);
                      }
                    }
                  }
                },
                child: Text(
                  _imageFileList.isNotEmpty ? 'Verstuur' : 'Overslaan',
                  style: const TextStyle(color: kSecondaryColor),
                )),
          )
        ],
        centerTitle: true,
      ),
      body: !Provider.of<UserStore>(context, listen: true).loading
          ? Padding(
              padding: const EdgeInsets.all(kDefaultPadding),
              child: _previewImages(),
            )
          : const Center(child: CircularProgressIndicator.adaptive()),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          _imageFileList.length < 3
              ? Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: FloatingActionButton(
                    onPressed: () {
                      _onImageButtonPressed(
                        ImageSource.gallery,
                        context: context,
                        isMultiImage: true,
                      );
                    },
                    heroTag: 'image1',
                    tooltip: 'Pick Multiple Image from gallery',
                    child: const Icon(Icons.photo_library),
                  ),
                )
              : Container(),
          _imageFileList.length < 3
              ? Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: FloatingActionButton(
                    onPressed: () {
                      _onImageButtonPressed(ImageSource.camera,
                          context: context);
                    },
                    heroTag: 'image2',
                    tooltip: 'Take a Photo',
                    child: const Icon(Icons.camera_alt),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
