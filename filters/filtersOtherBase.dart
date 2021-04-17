import 'package:flutter/material.dart';
import 'package:letbike/app/filterPage.dart';
import 'package:letbike/filters/other/other.dart';
import '../general/widgets/filterWidgets.dart';
import '../general/general.dart';

class FiltersOtherBase extends StatefulWidget {
  @override
  _FiltersOtherBase createState() => _FiltersOtherBase();

  static const routeName = "/FiltersOtherBase";
}

class _FiltersOtherBase extends State<FiltersOtherBase>
    with TickerProviderStateMixin {
  HomeArguments args;

  double volume = 0;

  AnimationController animationController;

  FilterDropdown categoryDd =
      new FilterDropdown(hint: "Typ", options: Category.other);

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
                      categoryDd,
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
                          args.filters.params["selectedOther"] =
                              FilterValueSetters.setDropdownValue(
                                  categoryDd.value);

                          switch (categoryDd.value) {
                            case 0:
                              {
                                Navigator.of(context).pushReplacementNamed(
                                    FiltersEBike.routeName,
                                    arguments: args);
                              }
                              break;
                            case 1:
                              {
                                Navigator.of(context).pushReplacementNamed(
                                    FiltersTrainer.routeName,
                                    arguments: args);
                              }
                              break;
                            case 2:
                              {
                                Navigator.of(context).pushReplacementNamed(
                                    FiltersScooter.routeName,
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
