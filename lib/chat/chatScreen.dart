import 'dart:async';
import 'package:flutter/material.dart';
import 'package:letbike/db/dbAccount.dart';
import 'package:letbike/db/dbChat.dart';
import 'package:letbike/db/dbItem.dart';
import 'package:letbike/db/dbRating.dart';
import 'package:letbike/db/dbSign.dart';
import 'package:letbike/db/remoteSettings.dart';
import 'package:letbike/widgets/images.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:letbike/app/homePage.dart';
import 'package:letbike/item/itemPage.dart';
import 'package:letbike/chat/chatBuildMessage.dart';
import 'package:letbike/widgets/textInput.dart';
import 'package:letbike/widgets/ratingRow.dart';
import 'package:letbike/widgets/errorWidgets.dart';
import 'package:letbike/widgets/buttonCircular.dart';
import 'package:letbike/widgets/alertBox.dart';
import 'package:letbike/widgets/accountInfoFIeld.dart';
import 'package:letbike/general/objects.dart';
import 'package:letbike/general/pallete.dart';

ChatUsers chatUsers;

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
  static const routeName = "/chatScreen";
}

class _ChatScreenState extends State<ChatScreen>
    with SingleTickerProviderStateMixin {
  Stream<List<Message>> messagesStream;

  List<Asset> images = [];

  Future<void> loadAssets() async {
    setState(() {
      images = [];
    });

    List<Asset> resultList;
    String error;

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 1,
        enableCamera: true,
      );
    } on Exception catch (e) {
      error = e.toString();
    }
    if (!mounted) return;

    setState(() {
      images = resultList.length < 1 ? [] : resultList;
      if (error != null)
        ModalWindow.showModalWindow(
            context, "Error", Text("Error", style: TextStyle(color: kWhite)));
    });
  }

  TextEditingController chatInputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    chatUsers = ModalRoute.of(context).settings.arguments;
    messagesStream = DatabaseChat.getMessages(
        chatUsers.userA.id, chatUsers.userB, chatUsers.itemInfo.item.id);
    bool cancelTrade = (chatUsers.itemInfo.item.status == 1 ? true : false);
    return Scaffold(
        backgroundColor: kBlack,
        appBar: AppBar(
            backgroundColor: kPrimaryColor,
            automaticallyImplyLeading: false,
            title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CircularButton(
                      kSecondaryColor,
                      40,
                      Icons.arrow_back,
                      kWhite,
                      () => Navigator.of(context).pushReplacementNamed(
                          ItemPage.routeName,
                          arguments: chatUsers.itemInfo)),
                  Text(chatUsers.itemInfo.item.name,
                      style: TextStyle(fontSize: 20)),
                  CircularButton(
                      kSecondaryColor, 40, Icons.person_search, kWhite, () {
                    otherPersonInfo();
                  }),
                  (chatUsers.itemInfo.me.id == chatUsers.itemInfo.item.sellerId
                      ? CircularButton(
                          kSecondaryColor,
                          40,
                          (cancelTrade ? Icons.money_off : Icons.attach_money),
                          kWhite,
                          () =>
                              (cancelTrade ? cancelTradeBtn() : acceptTrade()))
                      : Container())
                ])),
        body: Column(children: [
          Expanded(
              child: StreamBuilder(
                  stream: messagesStream,
                  builder: (context, stream) {
                    if (stream.hasData) {
                      return ListView.builder(
                          itemCount: stream.data.length,
                          itemBuilder: (context, i) {
                            return ChatBuildMessage.buildMessage(
                                context, stream.data[i], chatUsers);
                          });
                    } else {
                      return Center(child: CircularProgressIndicator());
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
                child:
                    CircularButton(kSecondaryColor, 40, Icons.send, kWhite, () {
                  if (images.length != 0 || chatInputController.text != "") {
                    DatabaseChat.sendMessage(
                        chatUsers.userA.id,
                        chatUsers.userB,
                        chatUsers.itemInfo.item.id,
                        chatInputController.text,
                        images);

                    if (images.length != 0) {
                      setState(() {
                        images = [];
                      });
                    }

                    if (chatInputController.text != "") {
                      chatInputController.clear();
                    }
                  }
                }))
          ])
        ]));
  }

  Widget cancelTradeBtn() {
    return ModalWindow.showModalWindow(
        context,
        "Opravdu?",
        Text("Opravdu chcete zrušit předmětu této osobě?",
            style: TextStyle(color: kWhite)), onTrue: () {
      Future<String> updateRes =
          DatabaseItem.updateItemStatus(chatUsers.itemInfo.item.id, 0, 0);
      ModalWindow.showModalWindow(
          context,
          "Oznámení",
          FutureBuilder<String>(
              future: updateRes,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(snapshot.data, style: TextStyle(color: kWhite));
                } else if (snapshot.hasError) {
                  return ErrorWidgets.futureBuilderError();
                }
                return Center(child: CircularProgressIndicator());
              }),
          after: () => Navigator.of(context).pushReplacementNamed(
              HomePage.routeName,
              arguments: HomeArguments(chatUsers.userA, {})));
    });
  }

  Widget acceptTrade() {
    return ModalWindow.showModalWindow(
        context,
        "Opravdu?",
        Text("Opravdu chcete prodat předmět této osobě?",
            style: TextStyle(color: kWhite)), onTrue: () {
      Future<String> updateRes = DatabaseItem.updateItemStatus(
          chatUsers.itemInfo.item.id, 1, chatUsers.userB);
      ModalWindow.showModalWindow(
          context,
          "Oznámení",
          FutureBuilder<String>(
              future: updateRes,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(snapshot.data, style: TextStyle(color: kWhite));
                } else if (snapshot.hasError) {
                  return ErrorWidgets.futureBuilderError();
                }
                return Center(child: CircularProgressIndicator());
              }),
          after: () => Navigator.of(context).pushReplacementNamed(
              HomePage.routeName,
              arguments: HomeArguments(chatUsers.userA, {})));
    });
  }

  Widget otherPersonInfo() {
    Future<User> otherUser = DatabaseAccount.getUserInfo(chatUsers.userB);
    Future<List<Rating>> ratings = DatabaseRating.getRatings(chatUsers.userB);

    return ModalWindow.showModalWindow(
        context,
        "Informace",
        Container(
          width: 500,
          height: 700,
          child: FutureBuilder<List>(
              future: Future.wait([otherUser, ratings]),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<Widget> ratings = [];
                  for (dynamic rating in snapshot.data[1])
                    ratings.add(RatingRow.buildRow(
                        rating.ratingValue, rating.ratingText));

                  return ListView(
                      children: [
                            ServerImage.build(imgsFolder +
                                "/users/" +
                                snapshot.data[0].id.toString() +
                                "/0.jpg"),
                            AccountInfoField.infoField("Uživatelské jméno: " +
                                snapshot.data[0].username),
                            AccountInfoField.infoField(
                                "E-mail: " + snapshot.data[0].email),
                            AccountInfoField.infoField(
                                "Křestní jméno: " + snapshot.data[0].fName),
                            AccountInfoField.infoField(
                                "Příjmení: " + snapshot.data[0].lName),
                            AccountInfoField.infoField("Telefon: " +
                                snapshot.data[0].phone.toString()),
                            AccountInfoField.infoField(
                                "Ulice a č.p.: " + snapshot.data[0].addressA),
                            AccountInfoField.infoField(
                                "Obec: " + snapshot.data[0].addressB),
                            AccountInfoField.infoField(
                                "Země: " + snapshot.data[0].addressC),
                            AccountInfoField.infoField(
                                "PSČ: " + snapshot.data[0].postal.toString()),
                          ] +
                          ratings);
                } else if (snapshot.hasError) {
                  return ErrorWidgets.futureBuilderError();
                }
                return Center(child: CircularProgressIndicator());
              }),
        ));
  }
}
