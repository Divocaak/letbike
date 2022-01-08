import 'package:emojis/emojis.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:letbike/chatScreen.dart';
import 'package:letbike/general/objects/item.dart';
import 'package:letbike/remote/chats.dart';
import 'package:letbike/remote/items.dart';
import 'package:letbike/widgets/errorWidgets.dart';
import 'package:letbike/widgets/images.dart';
import 'package:letbike/widgets/mainButtonEssentials.dart';
import 'package:letbike/widgets/alertBox.dart';
import 'package:letbike/general/pallete.dart';
import 'package:letbike/remote/settings.dart';

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
  late Future<List<String>?> chats;

  late AnimationController animationController;

  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 250));
    animationController.addListener(() => setState(() {}));

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
                      (widget._loggedUser.uid +
                          widget._item.name.hashCode.toString()) +
                      "/" +
                      i.toString() +
                      ".jpg")
              ])),
          Padding(
              padding: EdgeInsets.only(left: 10, top: 15),
              child: Text("Přidáno: " + widget._item.dateStart,
                  style: TextStyle(fontSize: 15, color: kWhite))),
          Padding(
              padding: EdgeInsets.only(left: 25, top: 10),
              child: Text(widget._item.price.toString() + " Kč",
                  style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: kWhite))),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Center(
                  child: Text(widget._item.name,
                      style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: kWhite)))),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Text(widget._item.description ?? "",
                  style: TextStyle(fontSize: 20, color: kWhite)))
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
                      secondUserUid: widget._item.sellerId)));
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
                          child: FutureBuilder<List<String>?>(
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
                                        itemBuilder: (context, i) => TextButton(
                                            onPressed: () => Navigator.of(context)
                                                .push(MaterialPageRoute(
                                                    builder: (context) =>
                                                        ChatScreen(
                                                            item: widget._item,
                                                            loggedUser: widget
                                                                ._loggedUser,
                                                            secondUserUid: snapshot
                                                                .data![i]))),
                                            child: Text(snapshot.data![i],
                                                style:
                                                    TextStyle(color: kWhite))));
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
    Future<List<String>?> _chats =
        RemoteChats.getChats(widget._item.id, widget._item.sellerId);
    await Future.delayed(Duration(seconds: 1));
    chats = _chats;
    setState(() {});
  }
}
