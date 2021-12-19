import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:letbike/remote/chats.dart';
import 'package:letbike/remote/items.dart';
import 'package:letbike/remote/ratings.dart';
import 'package:letbike/widgets/images.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'package:letbike/chat/chatBuildMessage.dart';
import 'package:letbike/widgets/textInput.dart';
import 'package:letbike/widgets/ratingRow.dart';
import 'package:letbike/widgets/errorWidgets.dart';
import 'package:letbike/widgets/buttonCircular.dart';
import 'package:letbike/widgets/alertBox.dart';
import 'package:letbike/general/objects.dart';
import 'package:letbike/general/pallete.dart';

// ignore: must_be_immutable
class ChatScreen extends StatefulWidget {
  ChatScreen(
      {Key? key,
      required Item item,
      required User loggedUser,
      required String secondUserUid})
      : _item = item,
        _loggedUser = loggedUser,
        _secondUserUid = secondUserUid,
        super(key: key);

  final Item _item;
  final User _loggedUser;
  final String _secondUserUid;
  List<Asset> _images = [];

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController chatInputController = TextEditingController();

  final ImagePickerController imagePickerController = ImagePickerController();

  late Stream<List<Message>?>? messagesStream;

  @override
  Widget build(BuildContext context) {
    messagesStream = RemoteChats.getMessages(
        widget._loggedUser.uid, widget._secondUserUid, widget._item);
    bool cancelTrade = (widget._item.status == 2 ? true : false);
    return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
            backgroundColor: kBlack,
            appBar: AppBar(
                backgroundColor: cancelTrade ? kGreen : kPrimaryColor,
                automaticallyImplyLeading: false,
                title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CircularButton(kSecondaryColor, 40, Icons.arrow_back,
                          kWhite, () => Navigator.of(context).pop()),
                      Text(widget._item.name, style: TextStyle(fontSize: 20)),
                      CircularButton(
                          kSecondaryColor, 40, Icons.person_search, kWhite, () {
                        Future<List<Rating>>? ratings =
                            RemoteRatings.getRatings(widget._secondUserUid);

                        return ModalWindow.showModalWindow(
                            context,
                            "Hodnocení uživatele",
                            Container(
                                width: 500,
                                height: 200,
                                child: FutureBuilder<List<Rating>?>(
                                    future: ratings,
                                    builder: (context, snapshot) => (snapshot
                                                .connectionState ==
                                            ConnectionState.waiting
                                        ? Center(
                                            child:
                                                Image.asset("assets/load.gif"))
                                        : (snapshot.hasData
                                            ? ListView.builder(
                                                itemCount:
                                                    snapshot.data!.length,
                                                itemBuilder: (context, i) =>
                                                    RatingRow.buildRow(
                                                        snapshot.data![i]))
                                            : (snapshot.hasError
                                                ? ErrorWidgets.futureBuilderError()
                                                : ErrorWidgets.futureBuilderEmpty()))))));
                      }),
                      (widget._loggedUser.uid == widget._item.sellerId
                          ? CircularButton(
                              kSecondaryColor,
                              40,
                              (cancelTrade
                                  ? Icons.money_off
                                  : Icons.attach_money),
                              kWhite,
                              () => ModalWindow.showModalWindow(
                                      context,
                                      "Opravdu?",
                                      Text(
                                          "Opravdu chcete " +
                                              (cancelTrade
                                                  ? "zrušit prodej předmětu"
                                                  : "prodat předmět") +
                                              " této osobě?",
                                          style: TextStyle(color: kWhite)),
                                      onTrue: () {
                                    Future<bool?> updateRes =
                                        RemoteItems.updateItemStatus(
                                            widget._item.id,
                                            cancelTrade ? 1 : 2,
                                            soldTo: cancelTrade
                                                ? ""
                                                : widget._secondUserUid);
                                    ModalWindow.showModalWindow(
                                        context,
                                        "Oznámení",
                                        FutureBuilder<bool?>(
                                            future: updateRes,
                                            builder: (context, snapshot) => (snapshot
                                                        .connectionState ==
                                                    ConnectionState.waiting
                                                ? Center(
                                                    child: Image.asset(
                                                        "assets/load.gif"))
                                                : (snapshot.hasData
                                                    ? Text(
                                                        cancelTrade
                                                            ? "Zrušeno!"
                                                            : "Prodáno!",
                                                        style: TextStyle(
                                                            color: kWhite))
                                                    : (snapshot.hasError
                                                        ? ErrorWidgets
                                                            .futureBuilderError()
                                                        : ErrorWidgets.futureBuilderEmpty())))),
                                        after: () => Navigator.of(context).pop());
                                  }))
                          : Container())
                    ])),
            body: Column(children: [
              Expanded(
                  child: StreamBuilder(
                      stream: messagesStream,
                      builder: (context, stream) =>
                          (stream.connectionState == ConnectionState.waiting
                              ? Center(child: Image.asset("assets/load.gif"))
                              : (stream.hasData
                                  ? ListView.builder(
                                      itemCount: (stream.data as List).length,
                                      itemBuilder: (context, i) =>
                                          ChatBuildMessage.buildMessage(
                                              context,
                                              (stream.data as List)[i],
                                              widget._loggedUser))
                                  : (stream.hasError
                                      ? ErrorWidgets.futureBuilderError()
                                      : ErrorWidgets.futureBuilderEmpty()))))),
              Row(children: [
                Expanded(
                    child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: TextInput(
                            icon: Icons.chat,
                            hint: "Napište zprávu",
                            controller: chatInputController))),
                CircularButton(
                    widget._images.length > 0 ? kPrimaryColor : kSecondaryColor,
                    40,
                    Icons.image,
                    kWhite,
                    () => imagePickerController.loadAssets(
                        this,
                        widget._images,
                        1,
                        mounted,
                        context,
                        (List<Asset> a) => widget._images = a)),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: CircularButton(
                        kSecondaryColor, 40, Icons.send, kWhite, () {
                      if (widget._images.length > 0 ||
                          chatInputController.text != "") {
                        RemoteChats.sendMessage(
                            widget._loggedUser.uid,
                            widget._secondUserUid,
                            widget._item.id,
                            chatInputController.text,
                            widget._images);

                        widget._images = [];
                        chatInputController.clear();

                        setState(() {});
                      }
                    }))
              ])
            ])));
  }
}
