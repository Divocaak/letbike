import 'package:flutter/material.dart';
import 'package:letbike/app/filterPage.dart';
import '../../general/widgets/filterWidgets.dart';
import '../../general/general.dart';

class FiltersScooter extends StatefulWidget {
  @override
  _FiltersScooter createState() => _FiltersScooter();

  static const routeName = "/FiltersScooter";
}

class _FiltersScooter extends State<FiltersScooter>
    with TickerProviderStateMixin {
  AddItemFiltersArgs args;

  double volume = 0;

  AnimationController animationController;

  FilterDropdown brandDd =
      new FilterDropdown(hint: "Značka koloběžky", options: Scooter.brand);
  FilterDropdown sizeDd =
      new FilterDropdown(hint: "Velikost koleček", options: Scooter.size);
  FilterSwitch compSwitch = new FilterSwitch(
    label: "Počítač",
    left: "Ne",
    right: "Ano",
  );

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
                      compSwitch
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
                          args.args.filters.params["scooterBrand"] =
                              FilterValueSetters.setDropdownValue(
                                  brandDd.value);
                          args.args.filters.params["scooterSize"] =
                              FilterValueSetters.setDropdownValue(sizeDd.value);
                          args.args.filters.params["scooterComputer"] =
                              FilterValueSetters.setSwitchValueWithOffset(
                                  compSwitch.value, args.args.filters);

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
