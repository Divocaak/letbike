import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:letbike/chat/chatScreen.dart';
import 'package:letbike/db/dbChat.dart';
import 'package:letbike/db/dbItem.dart';
import 'package:letbike/widgets/images.dart';
import 'package:letbike/widgets/mainButtonEssentials.dart';
import 'package:letbike/widgets/errorWidgets.dart';
import 'package:letbike/widgets/alertBox.dart';
import 'package:letbike/item/widgets/itemParam.dart';
import 'package:letbike/general/objects.dart';
import 'package:letbike/general/pallete.dart';
import 'package:letbike/db/remoteSettings.dart';

double volume = 0;

class ItemPage extends StatefulWidget {
  @override
  _ItemPageState createState() => _ItemPageState();
  static const routeName = "/itemPage";
}

class _ItemPageState extends State<ItemPage>
    with SingleTickerProviderStateMixin {
  Future<List<Chat>> chats;
  ItemInfo itemInfo;

  AnimationController animationController;

  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 250));
    animationController.addListener(() {
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    itemInfo = ModalRoute.of(context).settings.arguments;
    chats = DatabaseChat.getChats(itemInfo.item.id);
    return Scaffold(
        backgroundColor: kBlack,
        floatingActionButton: MainButton(
            iconData: Icons.menu,
            onPressed: () {
              if (animationController.isCompleted) {
                animationController.reverse();
                volume = 0;
              } else {
                animationController.forward();
                volume = 0.5;
              }
            }),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        body: Stack(children: [
          ListView(children: [
            Container(
                height: 300,
                width: MediaQuery.of(context).size.width,
                child: CarouselSlider(
                    options: CarouselOptions(
                        aspectRatio: MediaQuery.of(context).size.width /
                            MediaQuery.of(context).size.height,
                        initialPage: 0,
                        viewportFraction: 1,
                        autoPlay: true,
                        autoPlayInterval: Duration(seconds: 3),
                        autoPlayAnimationDuration: Duration(seconds: 1)),
                    items: [
                      for (int i = 0; i < int.parse(itemInfo.item.imgs); i++)
                        ServerImage.build(imgsFolder +
                            "/items/" +
                            (itemInfo.item.name.hashCode +
                                    itemInfo.item.sellerId)
                                .toString() +
                            "/" +
                            i.toString() +
                            ".jpg")
                    ])),
            Padding(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Přidáno: " + itemInfo.item.dateStart,
                          style: TextStyle(fontSize: 15, color: kWhite)),
                      Text(itemInfo.item.price.toString() + " Kč",
                          style: TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                              color: kWhite))
                    ])),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Center(
                    child: Text(
                  itemInfo.item.name,
                  style: TextStyle(
                      fontSize: 40, fontWeight: FontWeight.bold, color: kWhite),
                ))),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Text(itemInfo.item.description,
                    style: TextStyle(fontSize: 20, color: kWhite)))
          ]),
          MainButtonClicked(buttons: [
            SecondaryButtonData(
                Icons.info,
                () => ModalWindow.showModalWindow(
                    context,
                    "Parametry",
                    Container(
                        height: 300,
                        width: 250,
                        child: ItemParam(itemInfo.item.itemParams)))),
            SecondaryButtonData(
                Icons.arrow_back, () => Navigator.of(context).pop()),
            SecondaryButtonData(Icons.chat, startChat),
            if (itemInfo.item.sellerId == itemInfo.me.id)
              SecondaryButtonData(
                  Icons.delete,
                  () => ModalWindow.showModalWindow(
                          context,
                          "Opravdu?",
                          Text("Přejete si inzerát odstranit?",
                              style: TextStyle(color: kWhite)), onTrue: () {
                        Future<String> deleteResponse =
                            DatabaseItem.updateItemStatus(
                                itemInfo.item.id, 9, itemInfo.item.soldTo);
                        ModalWindow.showModalWindow(
                            context,
                            "Oznámení",
                            FutureBuilder<String>(
                              future: deleteResponse,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Text(snapshot.data,
                                      style: TextStyle(color: kWhite));
                                } else if (snapshot.hasError) {
                                  return ErrorWidgets.futureBuilderError();
                                }
                                return Center(
                                    child: CircularProgressIndicator());
                              },
                            ));
                      }))
          ], volume: volume)
        ]));
  }

  void startChat() {
    if (itemInfo.item.sellerId != itemInfo.me.id) {
      Navigator.of(context).pushReplacementNamed(ChatScreen.routeName,
          arguments: ChatUsers(itemInfo, itemInfo.me, itemInfo.item.sellerId));
    } else {
      ModalWindow.showModalWindow(
          context,
          "Vyberte chat",
          Container(
              height: 500,
              width: 500,
              child: FutureBuilder<List<Chat>>(
                future: chats,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, i) {
                          return _buildCard(snapshot.data[i], context);
                        });
                  } else if (snapshot.hasError) {
                    return ErrorWidgets.futureBuilderError();
                  } else if (!snapshot.hasData) {
                    return ErrorWidgets.futureBuilderEmpty();
                  }
                  return Center(child: CircularProgressIndicator());
                },
              )));
    }
  }

  Widget _buildCard(Chat chat, context) {
    if (chat.email != itemInfo.me.username) {
      return TextButton(
          onPressed: () {
            Navigator.of(context).pushNamed(ChatScreen.routeName,
                arguments: ChatUsers(itemInfo, itemInfo.me, chat.id));
          },
          child: Text(chat.email + " (" + chat.username + ")",
              style: TextStyle(color: kWhite)));
    } else {
      return SizedBox(
        height: 1,
      );
    }
  }
}
