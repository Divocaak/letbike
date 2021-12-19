import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:letbike/general/pallete.dart';
import 'package:letbike/general/objects.dart';
import 'package:letbike/remote/settings.dart';
import 'package:letbike/widgets/images.dart';

class ChatBuildMessage {
  static Widget buildMessage(context, Message message, User loggedUser) =>
      Container(
          margin: EdgeInsets.fromLTRB(
              message.myMessage ? 200 : 15, 2, message.myMessage ? 15 : 200, 2),
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          decoration: BoxDecoration(
              color: message.myMessage ? kPrimaryColor : kSecondaryColor,
              borderRadius: BorderRadius.circular(30)),
          child: Column(
              crossAxisAlignment: message.myMessage
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                Text(message.message,
                    textAlign:
                        message.myMessage ? TextAlign.right : TextAlign.left,
                    style:
                        TextStyle(color: message.myMessage ? kWhite : kBlack)),
                (message.img == 1
                    ? ServerImage().build(
                        imgsFolder + "messages/" + message.imgPath + "/0.jpg")
                    : Container())
              ]));
}
