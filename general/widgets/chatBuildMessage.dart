import 'package:flutter/material.dart';
import '../dbServices.dart';
import '../widgets.dart';
import '../pallete.dart';

class ChatBuildMessage {
  static Widget buildMessage(context, Message message, ItemInfo itemInfo) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Row(
        mainAxisAlignment: message.from == itemInfo.me.id
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          if (message.from != itemInfo.me.id) ...[
            CircleAvatar(
              radius: 17,
              backgroundImage: NetworkImage(
                  "https://www.surforma.com/media/filer_public_thumbnails/filer_public/4b/00/4b007d44-3443-4338-ada5-47d0b99db7ad/l167.jpg__800x600_q95_crop_subsampling-2_upscale.jpg"),
              child: Icon(
                Icons.person,
                color: Colors.white,
                size: 17,
              ),
            ),
            SizedBox(width: kDefaultPadding / 2),
          ],
          if (message.from == itemInfo.me.id) ...[
            SizedBox(
              width: 34 + kDefaultPadding / 2,
            ),
          ],
          if (message.message.substring(0, 3) == "_._") ...[
            ChatMessages.imageMessage(context, message.message.substring(3)),
          ],
          if (message.message.substring(0, 3) != "_._") ...[
            ChatMessages.textMessage(
                context, message.message, message.from == itemInfo.me.id),
          ]
        ],
      ),
    );
  }
}
