import 'package:flutter/material.dart';
import '../pallete.dart';

class ChatMessages {
  static Widget textMessage(BuildContext context, String message, bool isMe) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: kDefaultPadding * 0.75,
        vertical: kDefaultPadding / 2,
      ),
      decoration: BoxDecoration(
        color: kPrimaryColor.withOpacity(isMe ? 1 : 0.1),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        message,
        style: TextStyle(
          color:
              isMe ? Colors.white : Theme.of(context).textTheme.bodyText1.color,
        ),
      ),
    );
  }

  static Widget imageMessage(BuildContext context, String path) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.65,
      child: Stack(
        alignment: Alignment.center,
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image(
                image: AssetImage(path),
              )),
        ],
      ),
    );
  }
}
