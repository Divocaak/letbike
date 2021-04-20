import 'package:flutter/material.dart';
import 'package:letbike/addItem/addItem.dart';
import 'package:letbike/app/homePage.dart';
import 'package:letbike/filters/filtersBase.dart';
import '../general/general.dart';

class FilterPage extends StatefulWidget {
  @override
  _FilterPage createState() => _FilterPage();

  static const routeName = "/filterPage";
}

class _FilterPage extends State<FilterPage> with TickerProviderStateMixin {
  AddItemFiltersArgs addItemArgs;

  double volume = 0;

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
    addItemArgs = ModalRoute.of(context).settings.arguments;
    return MaterialApp(
      title: 'Filtry',
      home: Scaffold(
        body: Stack(
          children: [
            BackgroundImage(),
            Scaffold(
              backgroundColor: Colors.transparent,
              resizeToAvoidBottomInset: false,
              body: Container(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: ListView(
                    children: [
                      Text(
                        "Nastavené filtry:",
                        style: TextStyle(
                          color: kWhite,
                          shadows: [
                            Shadow(
                              color: Colors.black,
                              offset: Offset(4, 1),
                            ),
                          ],
                        ),
                      ),
                      Container(
                          height: 500,
                          width: 300,
                          child: ItemParam(addItemArgs.args.filters))
                    ],
                  ),
                ),
              ),
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
                        child: CircularButton(
                            kSecondaryColor.withOpacity(volume * 2),
                            45,
                            Icons.save,
                            kWhite.withOpacity(volume * 2), () {
                          if (!addItemArgs.addItem) {
                            Navigator.of(context).pushReplacementNamed(
                                HomePage.routeName,
                                arguments: addItemArgs.args);
                          } else {
                            Navigator.of(context).pushReplacementNamed(
                                AddItem.routeName,
                                arguments: addItemArgs.args);
                          }
                        })),
                    Positioned(
                        bottom: 150,
                        right: 40,
                        child: CircularButton(
                            kSecondaryColor.withOpacity(volume * 2),
                            45,
                            Icons.filter_alt,
                            kWhite.withOpacity(volume * 2), () {
                          Navigator.of(context).pushReplacementNamed(
                              FiltersBase.routeName,
                              arguments: addItemArgs);
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
      ),
    );
  }
}
