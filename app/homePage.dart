import 'package:flutter/material.dart';
import 'package:letbike/account/accountSettings.dart';
import 'package:letbike/addItem/addItem.dart';
import '../general/general.dart';
import "../account/accountScreen.dart";
import 'filterPage.dart';
import '../article/articlesScreen.dart';

double volume = 0;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
  static const routeName = "/homePage";
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  Future<List<Item>> items;

  HomeArguments homeArguments;

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
    homeArguments = ModalRoute.of(context).settings.arguments;
    items = DatabaseServices.getAllItems(
        0, "seller_id", homeArguments.filters, "sold_to");
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
                        return ItemCard.buildCard(context, snapshot.data[i],
                            homeArguments.user, false, true);
                      });
                } else if (snapshot.hasError) {
                  return Text('Sorry there is an error');
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
          ),
          warningCard(),
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
                        Navigator.pushReplacementNamed(
                            context, AddItem.routeName,
                            arguments: new AddItemFiltersArgs(
                                new HomeArguments(homeArguments.user,
                                    ItemParams.createEmpty()),
                                null));
                      })),
                  Positioned(
                      bottom: 120,
                      right: 120,
                      child: CircularButton(
                          kSecondaryColor.withOpacity(volume * 2),
                          45,
                          Icons.filter_alt,
                          kWhite.withOpacity(volume * 2), () {
                        Navigator.pushReplacementNamed(
                            context, FilterPage.routeName,
                            arguments:
                                new AddItemFiltersArgs(homeArguments, null));
                      })),
                  Positioned(
                      bottom: 150,
                      right: 40,
                      child: CircularButton(
                          kSecondaryColor.withOpacity(volume * 2),
                          45,
                          Icons.person,
                          kWhite.withOpacity(volume * 2), () {
                        Navigator.pushReplacementNamed(
                            context, AccountScreen.routeName,
                            arguments: homeArguments.user);
                      })),
                  Positioned(
                      bottom: 200,
                      right: 100,
                      child: CircularButton(
                          kSecondaryColor.withOpacity(volume * 2),
                          45,
                          Icons.article,
                          kWhite.withOpacity(volume * 2), () {
                        Navigator.pushReplacementNamed(
                            context, ArticlesScreen.routeName,
                            arguments: homeArguments);
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

  Widget warningCard() {
    if (checkUserData() < 7) {
      return Container(
          height: 125,
          clipBehavior: Clip.antiAlias,
          margin: const EdgeInsets.fromLTRB(5, 25, 5, 10),
          decoration: BoxDecoration(
              color: kWarninngColor.withOpacity(0.85),
              border: Border.all(color: Colors.transparent),
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: ListView(children: [
            Icon(
              Icons.warning,
              color: kWhite,
            ),
            SizedBox(height: 10),
            Text("Doplňte si prosím uživatelské údaje",
                textAlign: TextAlign.center),
            TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, AccountSettings.routeName,
                      arguments: homeArguments.user);
                },
                child: Text("Doplnit", textAlign: TextAlign.center)),
          ]));
    } else {
      return SizedBox(height: 0, width: 0);
    }
  }

  int checkUserData() {
    int check = 0;
    check += homeArguments.user.fName != "0" ? 1 : 0;
    check += homeArguments.user.lName != "0" ? 1 : 0;
    check += homeArguments.user.phone != 0 ? 1 : 0;
    check += homeArguments.user.addressA != "0" ? 1 : 0;
    check += homeArguments.user.addressB != "0" ? 1 : 0;
    check += homeArguments.user.addressC != "0" ? 1 : 0;
    check += homeArguments.user.postal != 0 ? 1 : 0;
    return check;
  }
}
