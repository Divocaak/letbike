import 'package:flutter/material.dart';
import 'package:letbike/app/filterPage.dart';
import '../../general/widgets/filterWidgets.dart';
import '../../general/general.dart';
import 'filtersClothesMore.dart';

class FiltersClothes extends StatefulWidget {
  @override
  _FiltersClothes createState() => _FiltersClothes();

  static const routeName = "/FiltersClothes";
}

class _FiltersClothes extends State<FiltersClothes>
    with TickerProviderStateMixin {
  AddItemFiltersArgs args;

  double volume = 0;

  AnimationController animationController;

  FilterDropdown typeDd =
      new FilterDropdown(hint: "Typ", options: Clothes.type);

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
                    children: [
                      typeDd,
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
                        bottom: 150,
                        right: 40,
                        child: CircularButton(
                            kSecondaryColor.withOpacity(volume * 2),
                            45,
                            Icons.filter_alt,
                            kWhite.withOpacity(volume * 2), () {
                          args.args.filters.params["clothesType"] =
                              FilterValueSetters.setDropdownValue(typeDd.value);

                          if (typeDd.value == 3) {
                            Navigator.of(context).pushReplacementNamed(
                                FiltersClothesMore.routeName,
                                arguments: args);
                          } else {
                            AlertBox.showAlertBox(
                                context,
                                "Chyba",
                                Text(
                                  "Pro další nastavení zvolte prosím jiný typ oblečení",
                                  style: TextStyle(color: kWhite),
                                ));
                          }
                        })),
                    Positioned(
                        bottom: 120,
                        right: 120,
                        child: CircularButton(
                            kSecondaryColor.withOpacity(volume * 2),
                            45,
                            Icons.save,
                            kWhite.withOpacity(volume * 2), () {
                          args.args.filters.params["clothesType"] =
                              FilterValueSetters.setDropdownValue(typeDd.value);

                          Navigator.of(context).pushReplacementNamed(
                              FilterPage.routeName,
                              arguments: args);
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
