import 'package:flutter/material.dart';
import '../widgets.dart';
import '../pallete.dart';
import '../objects.dart';

class ChatBuildMessage {
  static Widget buildMessage(context, Message message, ChatUsers chatUsers) {
    bool myMessage = message.from == chatUsers.userA.id;
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Row(
        mainAxisAlignment:
            myMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!myMessage) ...[
            SizedBox(width: kDefaultPadding / 2),
          ],
          if (myMessage) ...[
            SizedBox(
              width: 34 + kDefaultPadding / 2,
            ),
          ],
          ChatMessages.message(context, myMessage, message),
        ],
      ),
    );
  }
}
