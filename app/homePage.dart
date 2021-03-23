import 'package:flutter/material.dart';
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

  @override
  void initState() {
    items = DatabaseServices.getAllItems("seller_id");

    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 250));
    animationController.addListener(() {
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    loggedUser = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: kBlack,
            child: FutureBuilder<List<Item>>(
              future: items,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, i) {
                        return ItemCard.buildCard(
                            context, snapshot.data[i], loggedUser);
                      });
                } else if (snapshot.hasError) {
                  return Text('Sorry there is an error');
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
          ),
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
                          Icons.add,
                          kWhite.withOpacity(volume * 2), () {
                        print("asd");
                      })),
                  Positioned(
                      bottom: 120,
                      right: 120,
                      child: CircularButton(
                          kSecondaryColor.withOpacity(volume * 2),
                          45,
                          Icons.home,
                          kWhite.withOpacity(volume * 2), () {
                        print("asd");
                      })),
                  Positioned(
                      bottom: 150,
                      right: 40,
                      child: CircularButton(
                          kSecondaryColor.withOpacity(volume * 2),
                          45,
                          Icons.person,
                          kWhite.withOpacity(volume * 2), () {
                        Navigator.pushNamed(context, AccountScreen.routeName,
                            arguments: loggedUser);
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
        ],
      ),
    );
  }
}
