import 'package:flutter/material.dart';
import 'package:letbike/account/accountSettings.dart';
import 'package:letbike/addItem/addItem.dart';
import '../general/general.dart';
import "../account/accountScreen.dart";
import 'filterPage.dart';
import '../article/articlesScreen.dart';
import 'package:emojis/emojis.dart';

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
                  return ErrorWidgets.futureBuilderError();
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
                child: MainButtonClicked(
                  buttons: [
                    SecondaryButtonData(
                        Icons.add,
                        () => Navigator.pushReplacementNamed(
                            context, AddItem.routeName,
                            arguments: new AddItemFiltersArgs(
                                new HomeArguments(homeArguments.user,
                                    ItemParams.createEmpty()),
                                null))),
                    SecondaryButtonData(
                        Icons.filter_alt,
                        () => Navigator.pushReplacementNamed(
                            context, FilterPage.routeName,
                            arguments:
                                new AddItemFiltersArgs(homeArguments, null))),
                    SecondaryButtonData(
                        Icons.person,
                        () => Navigator.pushReplacementNamed(
                            context, AccountScreen.routeName,
                            arguments: homeArguments.user)),
                    SecondaryButtonData(
                        Icons.article,
                        () => Navigator.pushReplacementNamed(
                            context, ArticlesScreen.routeName,
                            arguments: homeArguments))
                  ],
                  volume: volume,
                )),
          ),
        ],
      ),
    );
  }

  Widget warningCard() {
    if (checkUserData() < 7) {
      return Container(
          width: MediaQuery.of(context).size.width,
          height: 120,
          clipBehavior: Clip.antiAlias,
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
              color: kWarninngColor.withOpacity(0.85),
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(
              Icons.warning,
              color: kWhite,
            ),
            Padding(
                padding: EdgeInsets.only(top: 13),
                child: Text(
                  "Doplňte si prosím uživatelské údaje " + Emojis.pleadingFace,
                )),
            TextButton(
              child: Text(
                "Doplnit",
                style: TextStyle(color: kWhite, fontWeight: FontWeight.bold),
              ),
              onPressed: () => Navigator.pushNamed(
                  context, AccountSettings.routeName,
                  arguments: homeArguments.user),
            ),
          ]));
    } else {
      return SizedBox(height: 0, width: 0);
    }
  }

  int checkUserData() {
    int check = 0;
    check += homeArguments.user.fName != "-1" ? 1 : 0;
    check += homeArguments.user.lName != "-1" ? 1 : 0;
    check += homeArguments.user.phone != 0 ? 1 : 0;
    check += homeArguments.user.addressA != "-1" ? 1 : 0;
    check += homeArguments.user.addressB != "-1" ? 1 : 0;
    check += homeArguments.user.addressC != "-1" ? 1 : 0;
    check += homeArguments.user.postal != 0 ? 1 : 0;
    return check;
  }
}
