import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:letbike/remote/dbChat.dart';
import 'package:letbike/remote/items.dart';
import 'package:letbike/remote/ratings.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'package:letbike/chat/chatBuildMessage.dart';
import 'package:letbike/widgets/textInput.dart';
import 'package:letbike/widgets/ratingRow.dart';
import 'package:letbike/widgets/errorWidgets.dart';
import 'package:letbike/widgets/buttonCircular.dart';
import 'package:letbike/widgets/alertBox.dart';
import 'package:letbike/general/objects.dart';
import 'package:letbike/general/pallete.dart';

// TODO refactor
class ChatScreen extends StatefulWidget {
  ChatScreen(
      {Key? key,
      required Item item,
      required User loggedUser,
      required User secondUser})
      : _item = item,
        _loggedUser = loggedUser,
        _secondUser = secondUser,
        super(key: key);

  final Item _item;
  final User _loggedUser;
  final User _secondUser;

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen>
    with SingleTickerProviderStateMixin {
  late Stream<List<Message>>? messagesStream;

  List<Asset> images = [];

  Future<void> loadAssets() async {
    setState(() => images = []);

    List<Asset>? resultList;
    String? error;

    try {
      resultList =
          await MultiImagePicker.pickImages(maxImages: 1, enableCamera: true);
    } on Exception catch (e) {
      error = e.toString();
    }
    if (!mounted) return;

    setState(() {
      images = resultList!.length < 1 ? [] : resultList;
      if (error != null)
        ModalWindow.showModalWindow(
            context, "Error", Text("Error", style: TextStyle(color: kWhite)));
    });
  }

  TextEditingController chatInputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    messagesStream = DatabaseChat.getMessages(
        widget._loggedUser, widget._secondUser, widget._item);
    bool cancelTrade = (widget._item.status == 2 ? true : false);
    return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
            backgroundColor: kBlack,
            appBar: AppBar(
                backgroundColor: kPrimaryColor,
                automaticallyImplyLeading: false,
                title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CircularButton(kSecondaryColor, 40, Icons.arrow_back,
                          kWhite, () => Navigator.of(context).pop()),
                      Text(widget._item.name, style: TextStyle(fontSize: 20)),
                      CircularButton(kSecondaryColor, 40, Icons.person_search,
                          kWhite, () => otherPersonInfo()),
                      (widget._loggedUser.uid == widget._item.sellerId
                          ? CircularButton(
                              kSecondaryColor,
                              40,
                              (cancelTrade
                                  ? Icons.money_off
                                  : Icons.attach_money),
                              kWhite,
                              () => (cancelTrade
                                  ? cancelTradeBtn()
                                  : acceptTrade()))
                          : Container())
                    ])),
            body: Column(children: [
              Expanded(
                  child: StreamBuilder(
                      stream: messagesStream,
                      builder: (context, stream) {
                        if (stream.hasData) {
                          return ListView.builder(
                              itemCount: (stream.data as List).length,
                              itemBuilder: (context, i) =>
                                  ChatBuildMessage.buildMessage(
                                      context,
                                      (stream.data as List)[i],
                                      widget._loggedUser));
                        } else {
                          return Center(child: Image.asset("assets/load.gif"));
                        }
                      })),
              Row(children: [
                Expanded(
                    child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: TextInput(
                            icon: Icons.chat,
                            hint: "Napište zprávu",
                            controller: chatInputController))),
                CircularButton(
                    kSecondaryColor, 40, Icons.image, kWhite, loadAssets),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: CircularButton(
                        kSecondaryColor, 40, Icons.send, kWhite, () {
                      if (images.length != 0 ||
                          chatInputController.text != "") {
                        /* DatabaseChat.sendMessage(
                            chatUsers.userA.id,
                            chatUsers.userB,
                            chatUsers.itemInfo.item.id,
                            chatInputController.text,
                            images); */

                        if (images.length != 0) {
                          setState(() => images = []);
                        }

                        if (chatInputController.text != "") {
                          chatInputController.clear();
                        }
                      }
                    }))
              ])
            ])));
  }

  Widget cancelTradeBtn() => ModalWindow.showModalWindow(
          context,
          "Opravdu?",
          Text("Opravdu chcete zrušit prodej předmětu této osobě?",
              style: TextStyle(color: kWhite)), onTrue: () {
        Future<bool> updateRes =
            RemoteItems.updateItemStatus(widget._item.id, 1, soldTo: "");
        ModalWindow.showModalWindow(
            context,
            "Oznámení",
            FutureBuilder<bool>(
                future: updateRes,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: Image.asset("assets/load.gif"));
                  } else {
                    if (snapshot.hasData) {
                      return Text("Zrušeno!", style: TextStyle(color: kWhite));
                    } else if (snapshot.hasError) {
                      return ErrorWidgets.futureBuilderError();
                    } else {
                      return ErrorWidgets.futureBuilderEmpty();
                    }
                  }
                }),
            after: () => Navigator.of(context).pop());
      });

  Widget acceptTrade() => ModalWindow.showModalWindow(
          context,
          "Opravdu?",
          Text("Opravdu chcete prodat předmět této osobě?",
              style: TextStyle(color: kWhite)), onTrue: () {
        Future<bool> updateRes = RemoteItems.updateItemStatus(
            widget._item.id, 2,
            soldTo: widget._secondUser.uid);
        ModalWindow.showModalWindow(
            context,
            "Oznámení",
            FutureBuilder<bool>(
                future: updateRes,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: Image.asset("assets/load.gif"));
                  } else {
                    if (snapshot.hasData) {
                      return Text("Prodáno!", style: TextStyle(color: kWhite));
                    } else if (snapshot.hasError) {
                      return ErrorWidgets.futureBuilderError();
                    } else {
                      return ErrorWidgets.futureBuilderEmpty();
                    }
                  }
                }),
            after: () => Navigator.of(context).pop());
      });

  Widget otherPersonInfo() {
    //Future<User>? otherUser = DatabaseAccount.getUserInfo(chatUsers.userB);
    Future<List<Rating>>? ratings =
        RemoteRatings.getRatings(widget._secondUser.uid);

    return ModalWindow.showModalWindow(
        context,
        "Informace",
        Container(
            width: 500,
            height: 700,
            child: ListView(children: [
              /* FutureBuilder(
                  future: otherUser,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(children: [
                        ServerImage().build(imgsFolder +
                            "/users/" +
                            snapshot.data.id.toString() +
                            "/0.jpg"),
                        AccountInfoField.infoField(
                            "Uživatelské jméno: " + snapshot.data.username),
                        AccountInfoField.infoField(
                            "E-mail: " + snapshot.data.email),
                        AccountInfoField.infoField(
                            "Křestní jméno: " + snapshot.data.fName),
                        AccountInfoField.infoField(
                            "Příjmení: " + snapshot.data.lName),
                        AccountInfoField.infoField(
                            "Telefon: " + snapshot.data.phone.toString()),
                        AccountInfoField.infoField(
                            "Ulice a č.p.: " + snapshot.data.addressA),
                        AccountInfoField.infoField(
                            "Obec: " + snapshot.data.addressB),
                        AccountInfoField.infoField(
                            "Země: " + snapshot.data.addressC),
                        AccountInfoField.infoField(
                            "PSČ: " + snapshot.data.postal.toString()),
                      ]);
                    } else if (snapshot.hasError) {
                      return ErrorWidgets.futureBuilderError();
                    }
                    return Center(child: Image.asset("assets/load.gif"));
                  }), */
              FutureBuilder<List<Rating>>(
                  future: ratings,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: Image.asset("assets/load.gif"));
                    } else {
                      if (snapshot.hasData) {
                        return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, i) =>
                                RatingRow.buildRow(snapshot.data![i]));
                      } else if (snapshot.hasError) {
                        return ErrorWidgets.futureBuilderError();
                      } else {
                        return ErrorWidgets.futureBuilderEmpty();
                      }
                    }
                  })
            ])));
  }
}
