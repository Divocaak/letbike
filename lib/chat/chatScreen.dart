import 'package:flutter/material.dart';
import 'package:letbike/app/homePage.dart';
import 'package:letbike/app/itemPage.dart';
import '../general/widgets/chatBuildMessage.dart';
import '../general/general.dart';
import 'dart:async';

ChatUsers chatUsers;

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
  static const routeName = "/chatScreen";
}

class _ChatScreenState extends State<ChatScreen>
    with SingleTickerProviderStateMixin {
  Stream<List<Message>> messagesStream;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    chatUsers = ModalRoute.of(context).settings.arguments;
    messagesStream = DatabaseServices.getMessages(
        chatUsers.userA.id, chatUsers.userB, chatUsers.itemInfo.item.id);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            SizedBox(
              width: 15,
            ),
            Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    color: kSecondaryColor,
                    border: Border.all(color: kSecondaryColor),
                    borderRadius: BorderRadius.all(Radius.circular(50))),
                child: TextButton(
                  child: Icon(Icons.arrow_back, color: kWhite),
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed(
                        ItemPage.routeName,
                        arguments: chatUsers.itemInfo);
                  },
                )),
            SizedBox(width: kDefaultPadding * 0.75),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  chatUsers.itemInfo.item.name,
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
            SizedBox(
              width: kDefaultPadding * .75,
            ),
            sellButton(chatUsers),
            SizedBox(
              width: kDefaultPadding * .75,
            ),
            Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    color: kSecondaryColor,
                    border: Border.all(color: kSecondaryColor),
                    borderRadius: BorderRadius.all(Radius.circular(50))),
                child: TextButton(
                  child: Icon(Icons.person_search, color: kWhite),
                  onPressed: () {
                    otherPersonInfo();
                  },
                )),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
                padding: const EdgeInsets.fromLTRB(
                    kDefaultPadding, 1, kDefaultPadding, 0),
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
                  },
                )),
          ),
          ChatInputField(chatUsers),
        ],
      ),
      backgroundColor: kBlack,
    );
  }

  Widget sellButton(ChatUsers chatUsers) {
    if (chatUsers.itemInfo.me.id == chatUsers.itemInfo.item.sellerId) {
      if (chatUsers.itemInfo.item.status == 1) {
        return Container(
            alignment: Alignment.centerRight,
            width: 40,
            height: 40,
            decoration: BoxDecoration(
                color: kSecondaryColor,
                border: Border.all(color: kSecondaryColor),
                borderRadius: BorderRadius.all(Radius.circular(50))),
            child: TextButton(
              child: Icon(Icons.money_off, color: kWhite),
              onPressed: () {
                DecideBox.showDecideBox(
                    context,
                    "Opravdu?",
                    Text("Opravdu chcete zrušit prodej předmětu této osobě?",
                        style: TextStyle(color: kBlack)), () {
                  Future<String> updateRes = DatabaseServices.updateItemStatus(
                      chatUsers.itemInfo.item.id, 0, 0);
                  AlertBox.showAlertBox(
                      context,
                      "Oznámení",
                      FutureBuilder<String>(
                        future: updateRes,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Text(snapshot.data,
                                style: TextStyle(color: kBlack));
                          } else if (snapshot.hasError) {
                            return Text('Sorry there is an error',
                                style: TextStyle(color: kBlack));
                          }
                          return Center(child: CircularProgressIndicator());
                        },
                      ), after: () {
                    Navigator.of(context).pushReplacementNamed(
                        HomePage.routeName,
                        arguments: HomeArguments(
                            chatUsers.userA, ItemParams.createEmpty()));
                  });
                });
              },
            ));
      } else if (chatUsers.itemInfo.item.status == 0) {
        return Container(
            alignment: Alignment.centerRight,
            width: 40,
            height: 40,
            decoration: BoxDecoration(
                color: kSecondaryColor,
                border: Border.all(color: kSecondaryColor),
                borderRadius: BorderRadius.all(Radius.circular(50))),
            child: TextButton(
              child: Icon(Icons.attach_money, color: kWhite),
              onPressed: () {
                DecideBox.showDecideBox(
                    context,
                    "Opravdu?",
                    Text("Opravdu chcete prodat tento předmět této osobě?",
                        style: TextStyle(color: kWhite)), () {
                  Future<String> updateRes = DatabaseServices.updateItemStatus(
                      chatUsers.itemInfo.item.id, 1, chatUsers.userB);
                  AlertBox.showAlertBox(
                      context,
                      "Oznámení",
                      FutureBuilder<String>(
                        future: updateRes,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Text(snapshot.data,
                                style: TextStyle(color: kWhite));
                          } else if (snapshot.hasError) {
                            return Text('Sorry there is an error',
                                style: TextStyle(color: kWhite));
                          }
                          return Center(child: CircularProgressIndicator());
                        },
                      ), after: () {
                    Navigator.of(context).pushReplacementNamed(
                        HomePage.routeName,
                        arguments: HomeArguments(
                            chatUsers.userA, ItemParams.createEmpty()));
                  });
                });
              },
            ));
      }
    } else {
      return SizedBox(
        width: 1,
      );
    }

    return SizedBox(width: 1);
  }

  Widget otherPersonInfo() {
    return AlertBox.showAlertBox(
        context,
        "Informace",
        Column(
          children: [
            TextButton(
              child: Text("Kontaktní údaje",
                  style: TextStyle(color: kPrimaryColor)),
              onPressed: () {
                AlertBox.showAlertBox(
                    context, "Kontaktní údaje", otherUserInfo());
              },
            ),
            TextButton(
              child: Text(
                "Recenze",
                style: TextStyle(color: kPrimaryColor),
              ),
              onPressed: () {
                AlertBox.showAlertBox(context, "Recenze", otherUserRating());
              },
            )
          ],
        ));
  }

  Widget otherUserInfo() {
    Future<User> otherUser = DatabaseServices.getUserInfo(chatUsers.userB);
    return Expanded(
        child: FutureBuilder<User>(
            future: otherUser,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Container(
                    width: 200,
                    height: 200,
                    child: ListView(children: [
                      Center(
                          child: FadeInImage.assetNetwork(
                              placeholder:
                                  "Načítám obrázek (možná neexsituje :/)",
                              image: imgsFolder +
                                  "/users/" +
                                  snapshot.data.id.toString() +
                                  "/0.jpg")),
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
                          "PSČ: " + snapshot.data.postal.toString())
                    ]));
              } else if (snapshot.hasError) {
                return Text('Sorry there is an error');
              }
              return Center(child: CircularProgressIndicator());
            }));
  }

  Widget otherUserRating() {
    Future<List<Rating>> ratings = DatabaseServices.getRatings(chatUsers.userB);
    return Container(
        height: 300,
        width: 400,
        child: FutureBuilder<List<Rating>>(
          future: ratings,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, i) {
                    return RatingRow.buildRow(snapshot.data[i].ratingValue,
                        snapshot.data[i].ratingText);
                  });
            } else if (!snapshot.hasData) {
              return Container(
                  alignment: Alignment.topCenter,
                  child: Text("Zatím tu nic není :(",
                      style: TextStyle(color: kWhite)));
            } else if (snapshot.hasError) {
              return Text('Sorry there is an error',
                  style: TextStyle(color: kWhite));
            }
            return Center(child: CircularProgressIndicator());
          },
        ));
  }
}
