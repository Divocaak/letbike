import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'accountSettings.dart';
import '../general/pallete.dart';
import '../general/dbServices.dart';
import '../app/itemPage.dart';
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
                  FontAwesomeIcons.user,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          infoField("Uživatelské jméno: " + user.username),
          infoField("E-mail: " + user.email),
          infoField("Křestní jméno: " + user.fName),
          infoField("Příjmení: " + user.lName),
          infoField("Telefon: " + user.phone.toString()),
          infoField("Ulice a č.p.: " + user.addressA),
          infoField("Obec: " + user.addressB),
          infoField("Země: " + user.addressC),
          infoField("PSČ: " + user.postal.toString()),
          infoField("Moje inzeráty:"),
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
                        return _buildCard(context, snapshot.data[i], user);
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

class _CircularButton extends StatelessWidget {
  final double width;
  final double heigt;
  final Color color;
  final Icon icon;
  final Function onClick;

  _CircularButton(
      {this.color, this.width, this.heigt, this.icon, this.onClick});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      width: width,
      height: heigt,
      child: IconButton(
        icon: icon,
        enableFeedback: true,
        onPressed: onClick,
      ),
    );
  }
}

Widget infoField(String inputString) {
  int divider = inputString.indexOf(":", 0) + 1;
  return Container(
    height: 50,
    child: Center(
      child: RichText(
        text: TextSpan(style: kCaptionTextStyle, children: <TextSpan>[
          TextSpan(
              text: inputString.substring(0, divider),
              style: TextStyle(color: Colors.black)),
          TextSpan(
            text: inputString.substring(divider, inputString.length),
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ]),
      ),
    ),
  );
}

Widget _buildCard(context, Item item, User user) {
  return Card(
    clipBehavior: Clip.antiAlias,
    elevation: 0,
    color: Colors.black,
    margin: const EdgeInsets.fromLTRB(5, 0, 5, 10),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    child: Stack(
      children: [
        Ink.image(
          image: NetworkImage(
              'http://www.hybrid.cz/i/auto/samorost-plzen-drevo-horske-kolo.jpeg'),
          child: InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(ItemPage.routeName,
                  arguments: new ItemInfo(item, user));
            },
          ),
          height: 240,
          fit: BoxFit.cover,
          padding: const EdgeInsets.all(50),
        ),
        Positioned(
          left: 16,
          bottom: 32,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Text(
                  item.name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 32,
                    shadows: [
                      Shadow(
                        color: Colors.black,
                        offset: Offset(4, 1),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                child: Text(
                  item.description,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 18,
                    shadows: [
                      Shadow(
                        color: Colors.black,
                        offset: Offset(4, 1),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          right: 16,
          bottom: 32,
          child: Container(
            child: Text(
              item.price.toString() + "Kč",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 32,
                fontFamily: "Montserrat",
                shadows: [
                  Shadow(
                    color: Colors.black,
                    offset: Offset(4, 1),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
