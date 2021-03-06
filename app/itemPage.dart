import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:letbike/chat/chatScreen.dart';
import '../general/general.dart';

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
    chats = DatabaseServices.getChats(itemInfo.item.id);
    return Scaffold(
      body: Stack(
        children: [
          Scaffold(
              backgroundColor: kBlack,
              body: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Swiper(
                      itemBuilder: (BuildContext context, int index) {
                        return Ink.image(
                            image: NetworkImage(imgsFolder +
                                "/items/" +
                                (itemInfo.item.name.hashCode +
                                        itemInfo.item.sellerId)
                                    .toString() +
                                "/" +
                                index.toString() +
                                ".jpg"));
                      },
                      itemCount: int.parse(itemInfo.item.imgs),
                      pagination: new SwiperPagination(),
                      control: new SwiperControl(color: kPrimaryColor),
                    ),
                    width: MediaQuery.of(context).size.width,
                    height: 400,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Container(),
                      ),
                      Expanded(
                        flex: 25,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                itemInfo.item.name,
                                style: TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                    color: kWhite),
                                textAlign: TextAlign.left,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                itemInfo.item.description,
                                style: TextStyle(fontSize: 20, color: kWhite),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text("Přidáno: " + itemInfo.item.dateStart,
                                  style:
                                      TextStyle(fontSize: 15, color: kWhite)),
                              Container(
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    itemInfo.item.price.toString() + " Kč",
                                    style: TextStyle(
                                        fontSize: 35,
                                        fontWeight: FontWeight.bold,
                                        color: kWhite),
                                  ),
                                ),
                              ),
                            ]),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(),
                      ),
                    ],
                  )
                ],
              )),
          IgnorePointer(
            ignoring: volume == 0 ? true : false,
            child: Container(
              color: Colors.black.withOpacity(volume),
              child: Stack(
                children: [
                  Positioned(
                      bottom: 40,
                      right: 150,
                      child: CircularButton(
                          kSecondaryColor.withOpacity(volume * 2),
                          45,
                          Icons.info,
                          kWhite.withOpacity(volume * 2), () {
                        AlertBox.showAlertBox(
                            context,
                            "Parametry",
                            Container(
                                height: 300,
                                width: 250,
                                child: ItemParam(itemInfo.item.itemParams)));
                      })),
                  Positioned(
                      bottom: 120,
                      right: 120,
                      child: CircularButton(
                          kSecondaryColor.withOpacity(volume * 2),
                          45,
                          Icons.arrow_back,
                          kWhite.withOpacity(volume * 2), () {
                        Navigator.of(context).pop();
                      })),
                  Positioned(
                    bottom: 150,
                    right: 40,
                    child: CircularButton(
                        kSecondaryColor.withOpacity(volume * 2),
                        45,
                        Icons.chat,
                        kWhite.withOpacity(volume * 2), () {
                      startChat();
                    }),
                  )
                ],
              ),
            ),
          ),
          Positioned(
              height: 275,
              width: 275,
              right: -75,
              bottom: -75,
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  CircularButton(kPrimaryColor, 60, Icons.menu, kWhite, () {
                    if (animationController.isCompleted) {
                      animationController.reverse();
                      volume = 0;
                    } else {
                      animationController.forward();
                      volume = 0.5;
                    }
                  })
                ],
              ))
        ],
      ),
    );
  }

  void startChat() {
    if (itemInfo.item.sellerId != itemInfo.me.id) {
      Navigator.of(context).pushReplacementNamed(ChatScreen.routeName,
          arguments: ChatUsers(itemInfo, itemInfo.me, itemInfo.item.sellerId));
    } else {
      AlertBox.showAlertBox(
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
                    return Text('Sorry there is an error');
                  }
                  return Center(child: CircularProgressIndicator());
                },
              )));
    }
  }

  Widget _buildCard(Chat chat, context) {
    if (chat.username == "0") {
      return Text("Žádné chaty", style: TextStyle(color: kWhite));
    } else {
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
}
