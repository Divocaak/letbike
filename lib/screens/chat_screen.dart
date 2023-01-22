import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:letbike/objects/chat.dart';
import 'package:letbike/objects/item.dart';
import 'package:letbike/objects/message.dart';
import 'package:letbike/remote/chats.dart';
import 'package:letbike/remote/items.dart';
import 'package:letbike/widgets/image_picker_controller.dart';
import 'package:letbike/widgets/text_input.dart';
import 'package:letbike/widgets/error_widgets.dart';
import 'package:letbike/widgets/new/button_circular.dart';
import 'package:letbike/widgets/alert_box.dart';
import 'package:letbike/general/settings.dart';

// ignore: must_be_immutable
class ChatScreen extends StatefulWidget {
  ChatScreen({Key? key, required Item item, required User loggedUser, required Chat chat})
      : _item = item,
        _loggedUser = loggedUser,
        _chat = chat,
        super(key: key);

  final Item _item;
  final User _loggedUser;
  final Chat _chat;
  List<XFile> _images = [];

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with SingleTickerProviderStateMixin {
  final TextEditingController chatInputController = TextEditingController();

  final ImagePickerController imagePickerController = ImagePickerController();

  late Stream<List<Message>?>? messagesStream;
  late bool cancelTrade;

  @override
  void initState() {
    messagesStream = RemoteChats.getMessages(widget._loggedUser.uid, widget._chat.buyId, widget._item);
    cancelTrade = (widget._item.status == 2 ? true : false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) => GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
          backgroundColor: kBlack,
          appBar: AppBar(
              backgroundColor: cancelTrade ? kGreen : kPrimaryColor,
              automaticallyImplyLeading: false,
              title: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                CircularButton(icon: Icons.arrow_back, onClick: () => Navigator.of(context).pop()),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(widget._item.name, style: TextStyle(fontSize: 20))),
                if (widget._item.seller.id == widget._loggedUser.uid)
                  CircularButton(
                      icon: Icons.person_search,
                      onClick: () => ModalWindow.showModalWindow(
                          context,
                          "O zájemci",
                          Column(children: [
                            Text(widget._chat.buyName, style: TextStyle(color: kWhite)),
                            Text(widget._chat.buyMail, style: TextStyle(color: kWhite)),
                            // TODO future card list
                            /* FutureBuilder<List<Rating>?>(
                                future: RemoteRatings.getRatings(
                                    widget._chat.buyId),
                                builder: (context, snapshot) {
                                  switch (snapshot.connectionState) {
                                    case ConnectionState.waiting:
                                      return Center(
                                          child:
                                              Image.asset("assets/load.gif"));
                                    default:
                                      if (snapshot.hasError)
                                        return ErrorWidgets
                                            .futureBuilderError();
                                      else if (!snapshot.hasData ||
                                          (snapshot.hasData &&
                                              snapshot.data!.length < 1))
                                        return ErrorWidgets
                                            .futureBuilderEmpty();
                                      return ListView.builder(
                                          itemCount: snapshot.data!.length,
                                          itemBuilder: (context, i) =>
                                              snapshot.data![i].buildRow());
                                  }
                                }) */
                          ]))),
                if (widget._loggedUser.uid == widget._item.seller.id) SizedBox(width: 10),
                if (widget._loggedUser.uid == widget._item.seller.id)
                  CircularButton(
                      icon: (cancelTrade ? Icons.money_off : Icons.attach_money),
                      onClick: () => ModalWindow.showModalWindow(
                              context,
                              "Opravdu?",
                              Text(
                                  "Opravdu chcete " +
                                      (cancelTrade ? "zrušit prodej předmětu" : "prodat předmět") +
                                      " této osobě?",
                                  style: TextStyle(color: kWhite)), onTrue: () {
                            Future<bool?> updateRes = RemoteItems.updateItemStatus(widget._item.id, cancelTrade ? 1 : 2,
                                soldTo: cancelTrade ? "" : widget._chat.buyId);
                            ModalWindow.showModalWindow(
                                context,
                                "Oznámení",
                                FutureBuilder<bool?>(
                                    future: updateRes,
                                    builder: (context, snapshot) {
                                      switch (snapshot.connectionState) {
                                        case ConnectionState.waiting:
                                          return Center(child: Image.asset("assets/load.gif"));
                                        default:
                                          if (snapshot.hasError)
                                            return ErrorWidgets.futureBuilderError();
                                          else if (!snapshot.hasData) return ErrorWidgets.futureBuilderEmpty();
                                          return Text(cancelTrade ? "Zrušeno!" : "Prodáno!",
                                              style: TextStyle(color: kWhite));
                                      }
                                    }),
                                after: () => Navigator.of(context).pop());
                          }))
              ])),
          body: SafeArea(
              child: Column(children: [
            Expanded(
                child: StreamBuilder(
                    stream: messagesStream,
                    builder: (context, stream) => (stream.connectionState == ConnectionState.waiting
                        ? Center(child: Image.asset("assets/load.gif"))
                        : (stream.hasData
                            ? ListView.builder(
                                itemCount: (stream.data as List).length,
                                itemBuilder: (context, i) =>
                                    (stream.data as List)[i].buildMessage(context, widget._loggedUser))
                            : (stream.hasError
                                ? ErrorWidgets.futureBuilderError()
                                : ErrorWidgets.futureBuilderEmpty()))))),
            Row(children: [
              Expanded(
                  child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: TextInput(icon: Icons.chat, hint: "Napište zprávu", controller: chatInputController))),
              CircularButton(
                  color: widget._images.length > 0 ? kPrimaryColor : kSecondaryColor,
                  icon: Icons.image,
                  onClick: () => imagePickerController.loadAssets(
                      this, widget._images, 1, mounted, context, (List<XFile> a) => widget._images = a)),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: CircularButton(
                      icon: Icons.send,
                      onClick: () {
                        if (widget._images.length > 0 || chatInputController.text != "") {
                          RemoteChats.sendMessage(widget._loggedUser.uid, widget._chat.buyId, widget._item.id,
                              chatInputController.text, widget._images);

                          widget._images = [];
                          chatInputController.clear();

                          setState(() {});
                        }
                      }))
            ])
          ]))));
}
