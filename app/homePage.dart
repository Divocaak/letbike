import 'dart:ui';
import 'package:flutter/material.dart';
import 'itemPage.dart';
import '../general/pallete.dart';
import "../general/dbServices.dart";
import "../general/widgets.dart";
import "../account/accountScreen.dart";

double volume = 0;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
  static const routeName = "/homePage";
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  Future<List<Item>> items;
  User loggedUser;

  AnimationController animationController;
  List<Animation> degTranslationAnimation;
  Animation rotationAnimation;

  @override
  void initState() {
    items = DatabaseServices.getAllItems("seller_id");

    CircularButton().initButton(
        animationController, degTranslationAnimation, rotationAnimation);
    super.initState();
    animationController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    loggedUser = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Colors.black,
            child: FutureBuilder<List<Item>>(
              future: items,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, i) {
                        return _buildCard(snapshot.data[i]);
                      });
                } else if (snapshot.hasError) {
                  return Text('Sorry there is an error');
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
          ),
          IgnorePointer(
            ignoring: true,
            child: Container(
              color: Colors.black.withOpacity(volume),
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
                  CircularButton().createSubButton(
                      270,
                      degTranslationAnimation[0],
                      rotationAnimation,
                      kSecondaryColor,
                      50,
                      Icons.add,
                      kWhite, () {
                    print("add");
                  }),
                  CircularButton().createSubButton(
                      225,
                      degTranslationAnimation[1],
                      rotationAnimation,
                      kSecondaryColor,
                      50,
                      Icons.home,
                      kWhite, () {
                    print("home wtf");
                  }),
                  CircularButton().createSubButton(
                      180,
                      degTranslationAnimation[2],
                      rotationAnimation,
                      kSecondaryColor,
                      50,
                      Icons.person,
                      kWhite, () {
                    Navigator.of(context).pushNamed(AccountScreen.routeName,
                        arguments: loggedUser);
                  }),
                  CircularButton()
                      .createButton(kPrimaryColor, 60, Icons.menu, kWhite, () {
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

  Widget _buildCard(Item item) {
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
                    arguments: new ItemInfo(item, loggedUser));
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
}
