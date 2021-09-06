import 'package:flutter/material.dart';
import 'package:letbike/app/filterPage.dart';
import '../../general/widgets/filterWidgets.dart';
import '../../general/general.dart';
import 'more/filtersWheelMore.dart';

class FiltersWheel extends StatefulWidget {
  @override
  _FiltersWheel createState() => _FiltersWheel();

  static const routeName = "/FiltersWheel";
}

class _FiltersWheel extends State<FiltersWheel> with TickerProviderStateMixin {
  AddItemFiltersArgs args;

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
                      brandDd,
                      Container(
                        height: 20,
                      ),
                      sizeDd,
                      Container(
                        height: 20,
                      ),
                      materialDd,
                      Container(
                        height: 20,
                      ),
                      spokesSwitch,
                      Container(
                        height: 20,
                      ),
                      typeSwitch,
                      Container(
                        height: 20,
                      ),
                      axisDd,
                      Container(
                        height: 20,
                      ),
                      brakesSwitch,
                      Container(
                        height: 20,
                      ),
                      cassetteSwitch,
                      Container(
                        height: 20,
                      ),
                      compatibilityDd
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
                          args.args.filters.params["wheelBrand"] =
                              FilterValueSetters.setDropdownValue(
                                  brandDd.value);
                          args.args.filters.params["wheelSize"] =
                              FilterValueSetters.setDropdownValue(sizeDd.value);
                          args.args.filters.params["wheelMaterial"] =
                              FilterValueSetters.setDropdownValue(
                                  materialDd.value);
                          args.args.filters.params["wheeldSpokes"] =
                              FilterValueSetters.setSwitchValueWithOffset(
                                  spokesSwitch.value, args.args.filters);
                          args.args.filters.params["wheeldType"] =
                              FilterValueSetters.setSwitchValueWithOffset(
                                  typeSwitch.value, args.args.filters);
                          args.args.filters.params["wheelAxis"] =
                              FilterValueSetters.setDropdownValue(axisDd.value);
                          args.args.filters.params["wheeldBrakesType"] =
                              FilterValueSetters.setSwitchValueWithOffset(
                                  brakesSwitch.value, args.args.filters);
                          args.args.filters.params["wheeldCassette"] =
                              FilterValueSetters.setSwitchValueWithOffset(
                                  cassetteSwitch.value, args.args.filters);
                          args.args.filters.params["wheelCompatibility"] =
                              FilterValueSetters.setDropdownValue(
                                  compatibilityDd.value);

                          if (!brakesSwitch.value || cassetteSwitch.value) {
                            Navigator.of(context).pushReplacementNamed(
                                FiltersWheelMore.routeName,
                                arguments: new FiltersWheelMoreArgs(args,
                                    cassetteSwitch.value, brakesSwitch.value));
                          } else {
                            AlertBox.showAlertBox(
                                context,
                                "Chyba",
                                Text(
                                  "Pro další nastavení zvolte prosím typ provedení kazety na ořech, nebo nastavte typ brzd na kotoučové",
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
                          args.args.filters.params["wheelBrand"] =
                              FilterValueSetters.setDropdownValue(
                                  brandDd.value);
                          args.args.filters.params["wheelSize"] =
                              FilterValueSetters.setDropdownValue(sizeDd.value);
                          args.args.filters.params["wheelMaterial"] =
                              FilterValueSetters.setDropdownValue(
                                  materialDd.value);
                          args.args.filters.params["wheeldSpokes"] =
                              FilterValueSetters.setSwitchValueWithOffset(
                                  spokesSwitch.value, args.args.filters);
                          args.args.filters.params["wheeldType"] =
                              FilterValueSetters.setSwitchValueWithOffset(
                                  typeSwitch.value, args.args.filters);
                          args.args.filters.params["wheelAxis"] =
                              FilterValueSetters.setDropdownValue(axisDd.value);
                          args.args.filters.params["wheeldBrakesType"] =
                              FilterValueSetters.setSwitchValueWithOffset(
                                  brakesSwitch.value, args.args.filters);
                          args.args.filters.params["wheeldCassette"] =
                              FilterValueSetters.setSwitchValueWithOffset(
                                  cassetteSwitch.value, args.args.filters);
                          args.args.filters.params["wheelCompatibility"] =
                              FilterValueSetters.setDropdownValue(
                                  compatibilityDd.value);

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
