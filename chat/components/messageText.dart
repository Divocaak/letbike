import 'package:flutter/material.dart';
import '../../general/pallete.dart';

Widget textMessage(BuildContext context, String message, bool isMe) {
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
