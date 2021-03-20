import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:letbike/general/dbServices.dart';
import '../app/homePage.dart';
import '../general/pallete.dart';
import 'components/chat_input_field.dart';
import "components/messageImage.dart";
import "components/messageText.dart";

ItemInfo itemInfo;

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
  static const routeName = "/chatScreen";
}

class _ChatScreenState extends State<ChatScreen>
    with SingleTickerProviderStateMixin {
  Future<List<Message>> messages;

  @override
  void initState() {
    itemInfo = ModalRoute.of(context).settings.arguments;
    messages = DatabaseServices.getMessagesBetween(9, 10);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: buildChatBody(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          SizedBox(
            width: 15,
          ),
          CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(
                "https://www.surforma.com/media/filer_public_thumbnails/filer_public/4b/00/4b007d44-3443-4338-ada5-47d0b99db7ad/l167.jpg__800x600_q95_crop_subsampling-2_upscale.jpg"),
            child: Icon(
              FontAwesomeIcons.user,
              color: Colors.white,
              size: 20,
            ),
          ),
          SizedBox(width: kDefaultPadding * 0.75),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                itemInfo.item.sellerId.toString(),
                style: TextStyle(fontSize: 20),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget buildChatBody() {
    return Column(
      children: [
        Expanded(
          child: Padding(
              padding: const EdgeInsets.fromLTRB(
                  kDefaultPadding, 1, kDefaultPadding, 0),
              child: FutureBuilder<List<Message>>(
                future: messages,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, i) {
                          return buildMessage(snapshot.data[i]);
                        });
                  } else if (snapshot.hasError) {
                    return Text('Sorry there is an error');
                  }
                  return Center(child: CircularProgressIndicator());
                },
              )),
        ),
        ChatInputField(),
      ],
    );
  }

  Widget buildMessage(Message message) {
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
                FontAwesomeIcons.user,
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
            imageMessage(context, message.message.substring(3)),
          ],
          if (message.message.substring(0, 3) != "_._") ...[
            textMessage(
                context, message.message, message.from == itemInfo.me.id),
          ]
        ],
      ),
    );
  }
}