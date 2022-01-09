import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:letbike/general/settings.dart';
import 'package:letbike/widgets/images.dart';

class Message {
  bool myMessage;
  String message;
  int img;
  String imgPath;

  Message(this.myMessage, this.message, this.img, this.imgPath);

  factory Message.fromJson(Map<String, dynamic> json) => Message(
      json["isMyMessage"],
      json["message"],
      int.parse(json["img"]),
      (json["imgPath"] + json["message"].hashCode.toString()));

  Widget buildMessage(context, User loggedUser) => Container(
      margin:
          EdgeInsets.fromLTRB(myMessage ? 200 : 15, 2, myMessage ? 15 : 200, 2),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
          color: myMessage ? kPrimaryColor : kSecondaryColor,
          borderRadius: BorderRadius.circular(30)),
      child: Column(
          crossAxisAlignment:
              myMessage ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(message,
                textAlign: myMessage ? TextAlign.right : TextAlign.left,
                style: TextStyle(color: myMessage ? kWhite : kBlack)),
            (img == 1
                ? ServerImage()
                    .build(imgsFolder + "messages/" + imgPath + "/0.jpg")
                : Container())
          ]));
}
