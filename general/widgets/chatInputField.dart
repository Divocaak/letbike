import 'dart:ui';

import 'package:flutter/material.dart';
import '../dbServices.dart';
import '../widgets.dart';
import '../pallete.dart';
import '../general.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class ChatInputField extends StatefulWidget {
  final ChatUsers chatUsers;
  const ChatInputField(this.chatUsers);

  @override
  _ChatInputFieldState createState() => _ChatInputFieldState();
}

class _ChatInputFieldState extends State<ChatInputField> {
  List<Asset> images = [];

  Future<void> loadAssets() async {
    setState(() {
      images = [];
    });

    List<Asset> resultList;
    String error;

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 1,
        enableCamera: true,
      );
    } on Exception catch (e) {
      error = e.toString();
    }
    if (!mounted) return;

    setState(() {
      images = resultList.length < 1 ? [] : resultList;
      if (error != null) AlertBox.showAlertBox(context, "Error", Text("Error"));
    });
  }

  TextEditingController chatInputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    chatInputController.text = "";
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: kDefaultPadding,
        vertical: kDefaultPadding / 2,
      ),
      //Barva dolní části
      decoration: BoxDecoration(
        color: Color(0xFF1E1F1D),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 4),
            blurRadius: 32,
            color: Color(0xFF087949).withOpacity(0.08),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: kDefaultPadding * 0.75,
                ),
                decoration: BoxDecoration(
                  //Barva Input Okna
                  color: Color(0xFF424040).withOpacity(1),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Row(
                  children: [
                    SizedBox(width: kDefaultPadding / 2),
                    Expanded(
                      child: TextField(
                        controller: chatInputController,
                        decoration: InputDecoration(
                            hintText: "Napište zprávu",
                            border: InputBorder.none,
                            hintStyle:
                                TextStyle(color: kWhite.withOpacity(.5))),
                        style: TextStyle(color: kWhite),
                      ),
                    ),
                    SizedBox(
                      width: kDefaultPadding,
                    ),
                    Stack(children: [
                      TextButton(
                        child: Icon(Icons.attach_file, color: kWhite),
                        onPressed: () {
                          loadAssets();
                        },
                      ),
                      Positioned(
                          top: 5,
                          right: 5,
                          child: Container(
                            width: 20,
                            height: 20,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: kPrimaryColor,
                                border: Border.all(color: kSecondaryColor),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50))),
                            child: Text(
                              images != null ? images.length.toString() : "0",
                              style: TextStyle(
                                  color: kWhite, fontWeight: FontWeight.bold),
                            ),
                          ))
                    ]),
                    Container(
                        child: TextButton(
                            child: Icon(Icons.send, color: kWhite),
                            onPressed: () {
                              if (images.length != 0 ||
                                  chatInputController.text != "") {
                                setState(() {
                                  DatabaseServices.sendMessage(
                                      widget.chatUsers.userA.id,
                                      widget.chatUsers.userB,
                                      widget.chatUsers.itemInfo.item.id,
                                      chatInputController.text,
                                      images);
                                });

                                if (images.length != 0) {
                                  setState(() {
                                    images = [];
                                  });
                                }

                                if (chatInputController.text != "") {
                                  chatInputController.clear();
                                }
                              } else {
                                print("Message is empty");
                              }
                            }))
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
