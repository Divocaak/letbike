import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:letbike/objects/chat.dart';
import 'package:letbike/objects/item.dart';
import 'package:letbike/objects/rating.dart';
import 'package:letbike/remote/ratings.dart';
import 'package:letbike/remote/saves.dart';
import 'package:letbike/widgets/button_rounded.dart';
import 'package:letbike/widgets/new/button_main.dart';
import 'package:letbike/widgets/error_widgets.dart';
import 'package:letbike/widgets/image_server.dart';
import 'package:letbike/general/settings.dart';
import 'package:letbike/widgets/new/future_card_list.dart';
import 'package:letbike/widgets/new/page_body.dart';

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

class _ItemPageState extends State<ItemPage> {
  late Future<List<Chat>?> chats;

  late bool localSavedVal;

  @override
  void initState() {
    Future<bool> remoteSavedVal =
        RemoteSaves.getSave(widget._loggedUser.uid, widget._item.id);

    localSavedVal = false;
    if (widget._item.sellerId != widget._loggedUser.uid) {
      remoteSavedVal.then((data) => localSavedVal = data,
          onError: (e) => localSavedVal = false);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) => PageBody(
      body: SingleChildScrollView(
          child: Column(children: [
        Container(
            height: 300,
            width: MediaQuery.of(context).size.width,
            child: int.parse(widget._item.imgs) > 1
                ? CarouselSlider(options: carouselOptions(context), items: [
                    for (int i = 0; i < int.parse(widget._item.imgs); i++)
                      ServerImage(
                          path:
                              "${imgsFolder}items/${widget._item.sellerId + widget._item.name.hashCode.toString()}/${i.toString()}.jpg")
                  ])
                : ServerImage(
                    path:
                        "${imgsFolder}items/${widget._item.sellerId + widget._item.name.hashCode.toString()}/0.jpg")),
        const SizedBox(height: 15),
        Text("Přidáno: ${widget._item.dateStart}",
            style: TextStyle(fontSize: 15, color: kWhite.withOpacity(.4))),
        const SizedBox(height: 15),
        Text("Očekávaná cena: ${widget._item.price.toString()} Kč",
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: kWhite.withOpacity(.6))),
        (widget._item.sellerId != widget._loggedUser.uid
            ? RoundedButton(
                buttonName:
                    "${!localSavedVal ? "Přidat do" : "Odebrat z"} oblíbených",
                onClick: () => setState(() {
                      localSavedVal = !localSavedVal;
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: FutureBuilder<String?>(
                              future: RemoteSaves.setSave(
                                  widget._loggedUser.uid,
                                  widget._item.id,
                                  localSavedVal),
                              builder: (context, snapshot) {
                                switch (snapshot.connectionState) {
                                  case ConnectionState.waiting:
                                    return Center(
                                        child: Image.asset("assets/load.gif"));
                                  default:
                                    if (snapshot.hasError || !snapshot.hasData)
                                      return ErrorWidgets.snackBarError();
                                    return Text(snapshot.data!);
                                }
                              })));
                    }))
            // TODO style
            : Text("Toto je váš inzerát")),
        Text(widget._item.name,
            style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: kPrimaryColor)),
        if (widget._item.description != null)
          Text(widget._item.description!,
              style: TextStyle(fontSize: 20, color: kWhite)),
        if (widget._item.sellerId != widget._loggedUser.uid) ...[
          const SizedBox(height: 15),
          Text("O prodejci",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: kSecondaryColor)),
          Text(widget._item.sellerName,
              style: TextStyle(fontSize: 20, color: kWhite)),
          Text(widget._item.sellerMail,
              style: TextStyle(fontSize: 15, color: kWhite)),
          FutureCardList(
              buildFunction: (object) => (object as Rating).buildRow(),
              fetchFunction: () =>
                  RemoteRatings.getRatings(widget._item.sellerId))
        ],
        const SizedBox(height: 15),
        // TODO item params
      ])),
      mainButton: MainButton(
          iconData: Icons.arrow_back,
          onPressed: () => Navigator.of(context).pop()));
  /* MainButtonClicked(buttons: [
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
                                                            item: widget._item,
                                                            loggedUser: widget
                                                                ._loggedUser,
                                                            chat: chat))),
                                            child: Text(
                                                chat.buyName +
                                                    " (" +
                                                    chat.buyMail +
                                                    ")",
                                                style:
                                                    TextStyle(color: kWhite)));
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
                            builder: (context, snapshot) => (snapshot
                                        .connectionState ==
                                    ConnectionState.waiting
                                ? Center(child: Image.asset("assets/load.gif"))
                                : (snapshot.hasData
                                    ? ErrorWidgets.snackBarMessage(
                                        "Stav předmětu změněn " +
                                            Emojis.checkMark,
                                        kWhite,
                                        Icons.done)
                                    : ErrorWidgets.snackBarError())))));
                  }))
      ])); */
}
