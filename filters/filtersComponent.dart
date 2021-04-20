import 'package:flutter/material.dart';
import 'package:letbike/app/filterPage.dart';
import '../general/widgets/filterWidgets.dart';
import '../general/general.dart';
import 'components/components.dart';

class FiltersComponent extends StatefulWidget {
  @override
  _FiltersComponent createState() => _FiltersComponent();

  static const routeName = "/filtersComponent";
}

class _FiltersComponent extends State<FiltersComponent>
    with TickerProviderStateMixin {
  AddItemFiltersArgs args;

  double volume = 0;

  AnimationController animationController;

  FilterDropdown typeDd =
      new FilterDropdown(hint: "Typ komponentu", options: Category.parts);

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
                          args.args.filters.params["selectedParts"] =
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
                          args.args.filters.params["selectedParts"] =
                              FilterValueSetters.setDropdownValue(typeDd.value);

                          switch (typeDd.value) {
                            case 0:
                              {
                                Navigator.of(context).pushReplacementNamed(
                                    FiltersWheel.routeName,
                                    arguments: args);
                              }
                              break;
                            case 1:
                              {
                                Navigator.of(context).pushReplacementNamed(
                                    FiltersCranks.routeName,
                                    arguments: args);
                              }
                              break;
                            case 2:
                              {
                                Navigator.of(context).pushReplacementNamed(
                                    FiltersConverter.routeName,
                                    arguments: args);
                              }
                              break;
                            case 3:
                              {
                                Navigator.of(context).pushReplacementNamed(
                                    FiltersSaddle.routeName,
                                    arguments: args);
                              }
                              break;
                            case 4:
                              {
                                Navigator.of(context).pushReplacementNamed(
                                    FiltersFork.routeName,
                                    arguments: args);
                              }
                              break;
                            case 5:
                              {
                                Navigator.of(context).pushReplacementNamed(
                                    FiltersBowden.routeName,
                                    arguments: args);
                              }
                              break;
                            case 6:
                              {
                                Navigator.of(context).pushReplacementNamed(
                                    FiltersBrakes.routeName,
                                    arguments: args);
                              }
                              break;
                            case 7:
                              {
                                Navigator.of(context).pushReplacementNamed(
                                    FiltersTube.routeName,
                                    arguments: args);
                              }
                              break;
                            case 8:
                              {
                                Navigator.of(context).pushReplacementNamed(
                                    FiltersGrips.routeName,
                                    arguments: args);
                              }
                              break;
                            case 9:
                              {
                                Navigator.of(context).pushReplacementNamed(
                                    FiltersHeadset.routeName,
                                    arguments: args);
                              }
                              break;
                            case 10:
                              {
                                Navigator.of(context).pushReplacementNamed(
                                    FiltersCassette.routeName,
                                    arguments: args);
                              }
                              break;
                            case 11:
                              {
                                Navigator.of(context).pushReplacementNamed(
                                    FiltersAxis.routeName,
                                    arguments: args);
                              }
                              break;
                            case 12:
                              {
                                Navigator.of(context).pushReplacementNamed(
                                    FiltersPedals.routeName,
                                    arguments: args);
                              }
                              break;
                            case 13:
                              {
                                Navigator.of(context).pushReplacementNamed(
                                    FiltersTires.routeName,
                                    arguments: args);
                              }
                              break;
                            case 14:
                              {
                                Navigator.of(context).pushReplacementNamed(
                                    FiltersStem.routeName,
                                    arguments: args);
                              }
                              break;
                            case 15:
                              {
                                Navigator.of(context).pushReplacementNamed(
                                    FiltersEBikeComponents.routeName,
                                    arguments: args);
                              }
                              break;
                            case 16:
                              {
                                Navigator.of(context).pushReplacementNamed(
                                    FiltersRim.routeName,
                                    arguments: args);
                              }
                              break;
                            case 17:
                              {
                                Navigator.of(context).pushReplacementNamed(
                                    FiltersFrame.routeName,
                                    arguments: args);
                              }
                              break;
                            case 18:
                              {
                                Navigator.of(context).pushReplacementNamed(
                                    FiltersGearChange.routeName,
                                    arguments: args);
                              }
                              break;
                            case 19:
                              {
                                Navigator.of(context).pushReplacementNamed(
                                    FiltersHandlebars.routeName,
                                    arguments: args);
                              }
                              break;
                            case 20:
                              {
                                Navigator.of(context).pushReplacementNamed(
                                    FiltersSaddlePipe.routeName,
                                    arguments: args);
                              }
                              break;
                            case 21:
                              {
                                Navigator.of(context).pushReplacementNamed(
                                    FiltersShockAbs.routeName,
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
