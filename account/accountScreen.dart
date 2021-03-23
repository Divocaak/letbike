import 'package:flutter/material.dart';
import 'accountSettings.dart';
import '../general/pallete.dart';
import '../general/dbServices.dart';
import '../general/widgets.dart';

double volume = 0;
int textHeight = 50;

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
  static const routeName = "/AccountScreen";
}

class _AccountScreenState extends State<AccountScreen>
    with SingleTickerProviderStateMixin {
  Future<List<Item>> items;
  User user;

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
    user = ModalRoute.of(context).settings.arguments;
    items = DatabaseServices.getAllItems(user.id.toString());
    return Scaffold(
        body: Stack(children: [
      ListView(
        padding: const EdgeInsets.all(5),
        children: [
          Container(
            height: 50,
            margin: EdgeInsets.only(top: 50),
            child: const Center(
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://www.surforma.com/media/filer_public_thumbnails/filer_public/4b/00/4b007d44-3443-4338-ada5-47d0b99db7ad/l167.jpg__800x600_q95_crop_subsampling-2_upscale.jpg"),
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          AccountInfoField.infoField("Uživatelské jméno: " + user.username),
          AccountInfoField.infoField("E-mail: " + user.email),
          AccountInfoField.infoField("Křestní jméno: " + user.fName),
          AccountInfoField.infoField("Příjmení: " + user.lName),
          AccountInfoField.infoField("Telefon: " + user.phone.toString()),
          AccountInfoField.infoField("Ulice a č.p.: " + user.addressA),
          AccountInfoField.infoField("Obec: " + user.addressB),
          AccountInfoField.infoField("Země: " + user.addressC),
          AccountInfoField.infoField("PSČ: " + user.postal.toString()),
          AccountInfoField.infoField("Moje inzeráty:"),
          Container(
            height: 600,
            width: 600,
            child: FutureBuilder<List<Item>>(
              future: items,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, i) {
                        return ItemCard.buildCard(
                            context, snapshot.data[i], user);
                      });
                } else if (!snapshot.hasData) {
                  return Container(
                      alignment: Alignment.topCenter,
                      child: Text("Zatím tu nic není :("));
                } else if (snapshot.hasError) {
                  return Text('Sorry there is an error');
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ],
      ),
      IgnorePointer(
        ignoring: volume == 0 ? true : false,
        child: Container(
          color: Colors.black.withOpacity(volume),
          child: Stack(
            children: [
              Positioned(
                  bottom: 120,
                  right: 120,
                  child: CircularButton(kSecondaryColor.withOpacity(volume * 2),
                      45, Icons.arrow_back, kWhite.withOpacity(volume * 2), () {
                    Navigator.of(context).pop();
                  })),
              Positioned(
                  bottom: 150,
                  right: 40,
                  child: CircularButton(kSecondaryColor.withOpacity(volume * 2),
                      45, Icons.create, kWhite.withOpacity(volume * 2), () {
                    Navigator.pushNamed(context, AccountSettings.routeName,
                        arguments: user);
                  })),
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
    ]));
  }
}
