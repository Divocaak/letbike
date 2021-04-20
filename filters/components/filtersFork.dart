import 'package:flutter/material.dart';
import 'package:letbike/app/filterPage.dart';
import '../../general/widgets/filterWidgets.dart';
import '../../general/general.dart';
import 'more/filtersForkMore.dart';

class FiltersFork extends StatefulWidget {
  @override
  _FiltersFork createState() => _FiltersFork();

  static const routeName = "/FiltersFork";
}

class _FiltersFork extends State<FiltersFork> with TickerProviderStateMixin {
  AddItemFiltersArgs args;

  double volume = 0;

  AnimationController animationController;

  FilterDropdown brandDd =
      new FilterDropdown(hint: "Značka vidlice", options: Fork.brand);
  FilterDropdown sizeDd =
      new FilterDropdown(hint: "Velikost", options: Fork.size);
  FilterSwitch suspensionSwitch = new FilterSwitch(
    label: "Typ",
    right: "Odpružená",
    left: "Pevná",
  );
  FilterDropdown compatibilityDd = new FilterDropdown(
      hint: "Kompatibilita", options: Fork.wheelCompatibility);
  FilterDropdown materialDd =
      new FilterDropdown(hint: "Materiál", options: Fork.material);
  FilterDropdown materialColDd = new FilterDropdown(
      hint: "Materiál sloupku", options: Fork.materialColumn);

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
                      suspensionSwitch,
                      Container(
                        height: 20,
                      ),
                      compatibilityDd,
                      Container(
                        height: 20,
                      ),
                      materialDd,
                      Container(
                        height: 20,
                      ),
                      materialColDd,
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
                          args.args.filters.params["forkBrand"] =
                              FilterValueSetters.setDropdownValue(
                                  brandDd.value);
                          args.args.filters.params["forkSize"] =
                              FilterValueSetters.setDropdownValue(sizeDd.value);
                          args.args.filters.params["forkSuspensionType"] =
                              FilterValueSetters.setSwitchValueWithOffset(
                                  suspensionSwitch.value, args.args.filters);
                          args.args.filters.params["forkWheelCoompatibility"] =
                              FilterValueSetters.setDropdownValue(
                                  compatibilityDd.value);
                          args.args.filters.params["forkMaterial"] =
                              FilterValueSetters.setDropdownValue(
                                  materialDd.value);
                          args.args.filters.params["forkMaterialColumn"] =
                              FilterValueSetters.setDropdownValue(
                                  materialColDd.value);

                          if (suspensionSwitch.value) {
                            Navigator.of(context).pushReplacementNamed(
                                FiltersForkMore.routeName,
                                arguments: args);
                          } else {
                            AlertBox.showAlertBox(
                                context,
                                "Chyba",
                                Text(
                                  "Pro další nastavení zvolte prosím typ vidlice",
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
                          args.args.filters.params["forkBrand"] =
                              FilterValueSetters.setDropdownValue(
                                  brandDd.value);
                          args.args.filters.params["forkSize"] =
                              FilterValueSetters.setDropdownValue(sizeDd.value);
                          args.args.filters.params["forkSuspensionType"] =
                              FilterValueSetters.setSwitchValueWithOffset(
                                  suspensionSwitch.value, args.args.filters);
                          args.args.filters.params["forkWheelCoompatibility"] =
                              FilterValueSetters.setDropdownValue(
                                  compatibilityDd.value);
                          args.args.filters.params["forkMaterial"] =
                              FilterValueSetters.setDropdownValue(
                                  materialDd.value);
                          args.args.filters.params["forkMaterialColumn"] =
                              FilterValueSetters.setDropdownValue(
                                  materialColDd.value);

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
