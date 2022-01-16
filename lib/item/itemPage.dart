import 'package:emojis/emojis.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:letbike/chatScreen.dart';
import 'package:letbike/general/objects/chat.dart';
import 'package:letbike/general/objects/item.dart';
import 'package:letbike/general/objects/rating.dart';
import 'package:letbike/remote/chats.dart';
import 'package:letbike/remote/items.dart';
import 'package:letbike/remote/ratings.dart';
import 'package:letbike/remote/saves.dart';
import 'package:letbike/widgets/errorWidgets.dart';
import 'package:letbike/widgets/images.dart';
import 'package:letbike/widgets/mainButtonEssentials.dart';
import 'package:letbike/widgets/alertBox.dart';
import 'package:letbike/general/settings.dart';

double volume = 0;

class ItemPage extends StatefulWidget {
  ItemPage({Key? key, required Item item, required User loggedUser})
      : _item = item,
        _loggedUser = loggedUser,
        super(key: key);

  final Item _item;
  final User _loggedUser;

  @override
  _ItemPageState createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage>
    with SingleTickerProviderStateMixin {
  late Future<List<Chat>?> chats;

  late AnimationController animationController;

  late bool localSavedVal;
  late Future<bool> remoteSavedVal;

  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 250));
    animationController.addListener(() => setState(() {}));
    localSavedVal = false;
    remoteSavedVal =
        RemoteSaves.getSave(widget._loggedUser.uid, widget._item.id);

    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
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
        SafeArea(
            child: ListView(children: [
          Container(
              height: 300,
              width: MediaQuery.of(context).size.width,
              child: CarouselSlider(options: carouselOptions(context), items: [
                for (int i = 0; i < int.parse(widget._item.imgs); i++)
                  ServerImage().build(imgsFolder +
                      "items/" +
                      (widget._item.sellerId +
                          widget._item.name.hashCode.toString()) +
                      "/" +
                      i.toString() +
                      ".jpg")
              ])),
          Padding(
              padding: EdgeInsets.only(left: 10, top: 10),
              child: Text("Přidáno: " + widget._item.dateStart,
                  style:
                      TextStyle(fontSize: 15, color: kWhite.withOpacity(.4)))),
          Padding(
              padding: EdgeInsets.only(left: 25, top: 10, right: 25),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget._item.price.toString() + " Kč",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: kWhite.withOpacity(.6))),
                    if (widget._item.sellerId != widget._loggedUser.uid)
                      FutureBuilder<bool>(
                          future: remoteSavedVal,
                          builder: (context, snapshot) {
                            switch (snapshot.connectionState) {
                              case ConnectionState.waiting:
                                return Icon(Icons.hourglass_empty);
                              default:
                                if (snapshot.hasError)
                                  return Icon(Icons.error);
                                else if (!snapshot.hasData)
                                  return Icon(Icons.circle);
                                localSavedVal = snapshot.data as bool;
                                return IconButton(
                                    onPressed: () => setState(
                                        () => localSavedVal = !localSavedVal),
                                    icon: Icon(
                                        localSavedVal
                                            ? Icons.star
                                            : Icons.star_outline,
                                        color: kPrimaryColor,
                                        size: 30));
                            }
                          })
                  ])),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Center(
                  child: Text(widget._item.name,
                      style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: kPrimaryColor)))),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Text(widget._item.description ?? "",
                  style: TextStyle(fontSize: 20, color: kWhite))),
          if (widget._item.sellerId != widget._loggedUser.uid)
            Column(children: [
              Padding(
                  padding: EdgeInsets.only(top: 25, bottom: 10),
                  child: Center(
                    child: Text(
                      "O prodejci",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: kSecondaryColor),
                    ),
                  )),
              Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Center(
                      child: Text(widget._item.sellerName,
                          style: TextStyle(fontSize: 20, color: kWhite)))),
              Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Center(
                      child: Text(widget._item.sellerMail,
                          style: TextStyle(fontSize: 15, color: kWhite)))),
              Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Container(
                      height: MediaQuery.of(context).size.height / 2,
                      child: FutureBuilder<List<Rating>?>(
                          future:
                              RemoteRatings.getRatings(widget._item.sellerId),
                          builder: (context, snapshot) {
                            switch (snapshot.connectionState) {
                              case ConnectionState.waiting:
                                return Center(
                                    child: Image.asset("assets/load.gif"));
                              default:
                                if (snapshot.hasError)
                                  return ErrorWidgets.futureBuilderError();
                                else if (!snapshot.hasData ||
                                    (snapshot.hasData &&
                                        snapshot.data!.length < 1))
                                  return ErrorWidgets.futureBuilderEmpty();
                                return ListView.builder(
                                    itemCount: snapshot.data!.length,
                                    itemBuilder: (context, i) =>
                                        snapshot.data![i].buildRow());
                            }
                          })))
            ])
        ])),
        MainButtonClicked(buttons: [
          SecondaryButtonData(
              Icons.info,
              () => ModalWindow.showModalWindow(
                  context, "Parametry", widget._item.buildParams(context))),
          SecondaryButtonData(
              Icons.arrow_back, () => Navigator.of(context).pop()),
          SecondaryButtonData(Icons.chat, () {
            if (widget._item.sellerId != widget._loggedUser.uid) {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ChatScreen(
                      item: widget._item,
                      loggedUser: widget._loggedUser,
                      chat: Chat(widget._item.sellerId, "", ""))));
            } else {
              chats =
                  RemoteChats.getChats(widget._item.id, widget._item.sellerId);
              ModalWindow.showModalWindow(
                  context,
                  "Vyberte chat",
                  RefreshIndicator(
                      onRefresh: _pullRefresh,
                      backgroundColor: Colors.transparent,
                      color: kPrimaryColor,
                      strokeWidth: 5,
                      child: SizedBox.expand(
                          child: FutureBuilder<List<Chat>?>(
                              future: chats,
                              builder: (context, snapshot) {
                                switch (snapshot.connectionState) {
                                  case ConnectionState.waiting:
                                    return Center(
                                        child: Image.asset("assets/load.gif"));
                                  default:
                                    if (snapshot.hasError)
                                      return ErrorWidgets.futureBuilderError();
                                    else if (!snapshot.hasData ||
                                        (snapshot.hasData &&
                                            snapshot.data!.length < 1))
                                      return ErrorWidgets.futureBuilderEmpty();
                                    return ListView.builder(
                                        itemCount: snapshot.data!.length,
                                        itemBuilder: (context, i) {
                                          Chat chat = snapshot.data![i];
                                          return TextButton(
                                              onPressed: () => Navigator.of(
                                                      context)
                                                  .push(MaterialPageRoute(
                                                      builder: (context) =>
                                                          ChatScreen(
                                                              item:
                                                                  widget._item,
                                                              loggedUser: widget
                                                                  ._loggedUser,
                                                              chat: chat))),
                                              child: Text(
                                                  chat.buyName +
                                                      " (" +
                                                      chat.buyMail +
                                                      ")",
                                                  style: TextStyle(
                                                      color: kWhite)));
                                        });
                                }
                              }))));
            }
          }),
          if (widget._item.sellerId == widget._loggedUser.uid)
            SecondaryButtonData(
                Icons.delete,
                () => ModalWindow.showModalWindow(
                        context,
                        "Opravdu?",
                        Text("Přejete si inzerát odstranit?",
                            style: TextStyle(color: kWhite)), onTrue: () {
                      Future<bool?> deleteResponse =
                          RemoteItems.updateItemStatus(widget._item.id, 6);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: FutureBuilder<bool?>(
                              future: deleteResponse,
                              builder: (context, snapshot) =>
                                  (snapshot.connectionState ==
                                          ConnectionState.waiting
                                      ? Center(
                                          child: Image.asset("assets/load.gif"))
                                      : (snapshot.hasData
                                          ? ErrorWidgets.snackBarMessage(
                                              "Stav předmětu změněn " +
                                                  Emojis.checkMark,
                                              kWhite,
                                              Icons.done)
                                          : ErrorWidgets.snackBarError())))));
                    }))
        ], volume: volume)
      ]));

  Future<void> _pullRefresh() async {
    Future<List<Chat>?> _chats =
        RemoteChats.getChats(widget._item.id, widget._item.sellerId);
    await Future.delayed(Duration(seconds: 1));
    chats = _chats;
    setState(() {});
  }
}
