import 'package:flutter/material.dart';
import '../pallete.dart';
import '../general.dart';

class ChatMessages {
  static Widget message(BuildContext context, bool isMe, Message message) {
    return Container(
        padding: EdgeInsets.symmetric(
          horizontal: kDefaultPadding * 0.75,
          vertical: kDefaultPadding / 2,
        ),
        decoration: BoxDecoration(
          color: isMe ? kPrimaryColor : kSecondaryColor,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Stack(children: [
          Text(
            message.message,
            style: TextStyle(
              color: isMe
                  ? Colors.white
                  : Theme.of(context).textTheme.bodyText1.color,
            ),
          ),
          messageImage(message)
        ]));
  }

  static Widget messageImage(Message message) {
    if (message.img == 1) {
      return FadeInImage.assetNetwork(
        placeholder: "Načítám obrázek (možná neexsituje :/)",
        image: (imgsFolder +
            "/messages/" +
            (message.from.toString() +
                message.to.toString() +
                message.message.hashCode.toString()) +
            "/0.jpg"),
        height: 250,
        width: 250,
      );
    } else {
      return SizedBox(
        height: 1,
      );
    }
  }
}
