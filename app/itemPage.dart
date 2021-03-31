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
                                fontSize: 40, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            itemInfo.item.description,
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Přidáno: " + itemInfo.item.dateStart,
                            style: TextStyle(fontSize: 15),
                          ),
                          Container(
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                itemInfo.item.price.toString() + " Kč",
                                style: TextStyle(
                                    fontSize: 35, fontWeight: FontWeight.bold),
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
                                child: ListView.builder(
                                    itemCount: ParamRow.names.length,
                                    itemBuilder: (context, i) {
                                      return itemParam(
                                          context, i, itemInfo.item);
                                    })));
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
    return (chat.username == "0"
        ? Text("Žádné chaty")
        : TextButton(
            onPressed: () {
              Navigator.of(context).pushNamed(ChatScreen.routeName,
                  arguments: ChatUsers(itemInfo, itemInfo.me, chat.id));
            },
            child: Text(chat.email + " (" + chat.username + ")")));
  }

  Widget itemParam(context, int i, Item item) {
    int index = item.itemParams.params[ParamRow.keys[i]];
    if (index > 999) {
      index -= (999 +
          (item.itemParams.params["selecetedOther"] != null
              ? item.itemParams.params["selecetedOther"]
              : 0) +
          (item.itemParams.params["selectedParts"] != null
              ? item.itemParams.params["selectedParts"]
              : 0));
    }

    if (index > -1 && index < 999) {
      return Row(
        children: [
          Container(
              height: 40,
              width: 100,
              color: kPrimaryColor,
              alignment: Alignment.center,
              child: Text(ParamRow.names[i])),
          Container(
            height: 40,
            width: 100,
            color: kSecondaryColor,
            alignment: Alignment.center,
            child: Text(ParamRow.options[i][index]),
          )
        ],
      );
    } else {
      return SizedBox(
        height: 1,
      );
    }
  }
}

class ParamRow {
  static List<String> names = [
    "Použité",
    "Kategorie",
    "Typ komponentu",
    "Typ doplňku",
    "Jiné",
    "Typ kola",
    "Značka kola",
    "Značka výpletu",
    "Velikost kola",
    "Materiál",
    "Typ drátů",
    "Provedení náboje",
    "Provedení osy",
    "Typ brzd",
    "Uchycení disku",
    "Provedení kazety",
    "Značka ořechu",
    "Kompatibilita",
    "Značka",
    "Kompatibilita",
    "Materiál",
    "Osa",
    "Značka",
    "Počet rychlostí",
    "Značka",
    "Pohlaví",
    "Značka",
    "Velikost",
    "Typ vidlice",
    "Odpružení",
    "Kompatibilita",
    "Materiál",
    "Materiál sloupku",
    "Značka",
    "Umístění motoru",
    "Značka",
    "Typ brždění",
    "Značka",
    "Velikost koleček",
    "Počítač",
  ];

  static List<List<String>> options = [
    ["Ne", "Ano"],
    Category.categories,
    Category.parts,
    Category.accessories,
    Category.other,
    Bike.type,
    Bike.brand,
    Wheel.brand,
    Wheel.size,
    Wheel.material,
    ["Kulaté", "Ploché"],
    ["Přední", "Zadní"],
    Wheel.axis,
    ["Kotoučové", "V-Brzdy"],
    ["CenterLock", "6 děr"],
    ["Závit", "Ořech"],
    Wheel.nut,
    Wheel.compatibility,
    Cranks.brand,
    Cranks.compatibility,
    Cranks.material,
    Cranks.axis,
    Converter.brand,
    Converter.numOfSpeeds,
    Saddle.brand,
    Saddle.gender,
    Fork.brand,
    Fork.size,
    ["Odpružená", "Pevná"],
    ["Vzduchové", "Pružinové"],
    Fork.wheelCompatibility,
    Fork.material,
    Fork.materialColumn,
    EBike.brand,
    ["Středový", "Nábojový"],
    Trainer.brand,
    Trainer.brakes,
    Scooter.brand,
    Scooter.size,
    ["Ne", "Ano"]
  ];

  static List keys = [
    "used",
    "selectedCategory",
    "selectedParts",
    "selectedAccessories",
    "selectedOther",
    "bikeType",
    "bikeBrand",
    "wheelBrand",
    "wheelSize",
    "wheelMaterial",
    "wheeldSpokes",
    "wheeldType",
    "wheelAxis",
    "wheeldBrakesType",
    "wheeldBrakesDisc",
    "wheeldCassette",
    "wheelNut",
    "wheelCompatibility",
    "cranksBrand",
    "cranksCompatibility",
    "cranksMaterial",
    "cranksAxis",
    "converterBrand",
    "converterNumOfSpeeds",
    "saddleBrand",
    "saddleGender",
    "forkBrand",
    "forkSize",
    "forkSuspensionType",
    "forkSuspension",
    "forkWheelCoompatibility",
    "forkMaterial",
    "forkMaterialColumn",
    "eBikeBrand",
    "eBikeMotorPos",
    "trainerBrand",
    "trainerBrakes",
    "scooterBrand",
    "scooterSize",
    "scooterComputer"
  ];
}
