import 'package:flutter/material.dart';
import 'package:letbike/app/filterPage.dart';
import '../general/widgets/filterWidgets.dart';
import '../general/general.dart';
import 'accessories/accessories.dart';

class FiltersAccessory extends StatefulWidget {
  @override
  _FiltersAccessory createState() => _FiltersAccessory();

  static const routeName = "/FiltersAccessory";
}

class _FiltersAccessory extends State<FiltersAccessory>
    with TickerProviderStateMixin {
  HomeArguments args;

  double volume = 0;

  AnimationController animationController;

  FilterDropdown typeDd =
      new FilterDropdown(hint: "Typ doplňku", options: Category.accessories);

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
    args = ModalRoute.of(context).settings.arguments;

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
                    children: [typeDd],
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
                          args.filters.params["selectedAccessories"] =
                              FilterValueSetters.setDropdownValue(typeDd.value);

                          Navigator.of(context).pushReplacementNamed(
                              FilterPage.routeName,
                              arguments: args);
                        })),
                    Positioned(
                        bottom: 150,
                        right: 40,
                        child: CircularButton(
                            kSecondaryColor.withOpacity(volume * 2),
                            45,
                            Icons.filter_alt,
                            kWhite.withOpacity(volume * 2), () {
                          args.filters.params["selectedAccessories"] =
                              FilterValueSetters.setDropdownValue(typeDd.value);

                          switch (typeDd.value) {
                            case 0:
                              {
                                Navigator.of(context).pushReplacementNamed(
                                    FiltersMudguard.routeName,
                                    arguments: args);
                              }
                              break;
                            case 1:
                              {
                                Navigator.of(context).pushReplacementNamed(
                                    FiltersBag.routeName,
                                    arguments: args);
                              }
                              break;
                            case 2:
                              {
                                Navigator.of(context).pushReplacementNamed(
                                    FiltersGlasses.routeName,
                                    arguments: args);
                              }
                              break;
                            case 3:
                              {
                                Navigator.of(context).pushReplacementNamed(
                                    FiltersComps.routeName,
                                    arguments: args);
                              }
                              break;
                            case 4:
                              {
                                Navigator.of(context).pushReplacementNamed(
                                    FiltersKidSaddle.routeName,
                                    arguments: args);
                              }
                              break;
                            case 5:
                              {
                                Navigator.of(context).pushReplacementNamed(
                                    FiltersHelmet.routeName,
                                    arguments: args);
                              }
                              break;
                            case 6:
                              {
                                Navigator.of(context).pushReplacementNamed(
                                    FiltersPumps.routeName,
                                    arguments: args);
                              }
                              break;
                            case 7:
                              {
                                Navigator.of(context).pushReplacementNamed(
                                    FiltersBottleHolder.routeName,
                                    arguments: args);
                              }
                              break;
                            case 8:
                              {
                                Navigator.of(context).pushReplacementNamed(
                                    FiltersTools.routeName,
                                    arguments: args);
                              }
                              break;
                            case 9:
                              {
                                Navigator.of(context).pushReplacementNamed(
                                    FiltersRack.routeName,
                                    arguments: args);
                              }
                              break;
                            case 10:
                              {
                                Navigator.of(context).pushReplacementNamed(
                                    FiltersClothes.routeName,
                                    arguments: args);
                              }
                              break;
                            case 11:
                              {
                                Navigator.of(context).pushReplacementNamed(
                                    FiltersBoots.routeName,
                                    arguments: args);
                              }
                              break;
                            case 12:
                              {
                                Navigator.of(context).pushReplacementNamed(
                                    FiltersCards.routeName,
                                    arguments: args);
                              }
                              break;
                            case 13:
                              {
                                Navigator.of(context).pushReplacementNamed(
                                    FiltersLight.routeName,
                                    arguments: args);
                              }
                              break;
                            case 14:
                              {
                                Navigator.of(context).pushReplacementNamed(
                                    FiltersFood.routeName,
                                    arguments: args);
                              }
                              break;
                            case 15:
                              {
                                Navigator.of(context).pushReplacementNamed(
                                    FiltersLock.routeName,
                                    arguments: args);
                              }
                              break;
                            default:
                              {
                                AlertBox.showAlertBox(
                                    context,
                                    "Chyba",
                                    Text(
                                      "Pro podrobnější nastavení parametrů zvolte prosím kategorii",
                                      style: TextStyle(color: kWhite),
                                    ));
                              }
                              break;
                          }
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
