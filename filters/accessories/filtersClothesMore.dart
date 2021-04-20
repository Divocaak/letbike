import 'package:flutter/material.dart';
import 'package:letbike/app/filterPage.dart';
import '../../general/widgets/filterWidgets.dart';
import '../../general/general.dart';

class FiltersClothesMore extends StatefulWidget {
  @override
  _FiltersClothesMore createState() => _FiltersClothesMore();

  static const routeName = "/FiltersClothesMore";
}

class _FiltersClothesMore extends State<FiltersClothesMore>
    with TickerProviderStateMixin {
  AddItemFiltersArgs args;

  double volume = 0;

  AnimationController animationController;

  FilterDropdown typeDd =
      new FilterDropdown(hint: "Typ", options: Clothes.clothesType);
  FilterDropdown genderDd =
      new FilterDropdown(hint: "Pohlaví", options: Clothes.gender);
  FilterDropdown sizeDd =
      new FilterDropdown(hint: "Velikost", options: Clothes.size);

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
                      Container(
                        height: 20,
                      ),
                      genderDd,
                      Container(
                        height: 20,
                      ),
                      sizeDd
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
                          args.args.filters.params["clothesClothes"] =
                              FilterValueSetters.setDropdownValue(typeDd.value);
                          args.args.filters.params["clothesGender"] =
                              FilterValueSetters.setDropdownValue(
                                  genderDd.value);
                          args.args.filters.params["clothesSize"] =
                              FilterValueSetters.setDropdownValue(sizeDd.value);

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
