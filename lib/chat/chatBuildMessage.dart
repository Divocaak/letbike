import 'package:flutter/material.dart';
import 'package:letbike/general/pallete.dart';
import 'package:letbike/general/objects.dart';
import 'package:letbike/remote/settings.dart';
import 'package:letbike/widgets/images.dart';

class ChatBuildMessage {
  static Widget buildMessage(context, Message message, ChatUsers chatUsers) {
    //bool myMessage = message.from == chatUsers.userA.id;
    bool img = message.img == 1 ? true : false;
    return Container(
        /*  margin: EdgeInsets.fromLTRB(
            myMessage ? 200 : 15, 2, myMessage ? 15 : 200, 2), */
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
          //color: myMessage ? kPrimaryColor : kSecondaryColor,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
            /* crossAxisAlignment:
                myMessage ? CrossAxisAlignment.end : CrossAxisAlignment.start, */
            children: [
              Text(message.message,
                  //textAlign: myMessage ? TextAlign.right : TextAlign.left,
                  style: TextStyle(
                      //color: myMessage ? kWhite : kBlack,
                      )),
              (img
                  ? ServerImage().build(imgsFolder +
                      "/messages/" +
                      (message.from.toString() +
                          message.to.toString() +
                          message.message.hashCode.toString()) +
                      "/0.jpg")
                  : Container())
            ]));
  }
}
