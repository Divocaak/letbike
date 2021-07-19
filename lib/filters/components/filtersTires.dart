import 'package:flutter/material.dart';
import 'package:letbike/app/filterPage.dart';
import '../../general/widgets/filterWidgets.dart';
import '../../general/general.dart';

class FiltersTires extends StatefulWidget {
  @override
  _FiltersTires createState() => _FiltersTires();

  static const routeName = "/FiltersTires";
}

class _FiltersTires extends State<FiltersTires> with TickerProviderStateMixin {
  AddItemFiltersArgs args;

  double volume = 0;

  AnimationController animationController;

  FilterDropdown sizeDd =
      new FilterDropdown(hint: "Velikost", options: Tire.size);
  FilterDropdown widthDd =
      new FilterDropdown(hint: "Šířka", options: Tire.width);
  FilterDropdown brandDd =
      new FilterDropdown(hint: "Značka", options: Tire.brand);
  FilterDropdown typeDd = new FilterDropdown(hint: "Typ", options: Tire.type);
  FilterSwitch materialSwitch = new FilterSwitch(
    label: "Materiál",
    left: "Kevlar",
    right: "Drát",
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
                      sizeDd,
                      Container(
                        height: 20,
                      ),
                      widthDd,
                      Container(
                        height: 20,
                      ),
                      brandDd,
                      Container(
                        height: 20,
                      ),
                      typeDd,
                      Container(
                        height: 20,
                      ),
                      materialSwitch,
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
                          args.args.filters.params["tireSize"] =
                              FilterValueSetters.setDropdownValue(sizeDd.value);
                          args.args.filters.params["tireWidth"] =
                              FilterValueSetters.setDropdownValue(
                                  widthDd.value);
                          args.args.filters.params["tireBrand"] =
                              FilterValueSetters.setDropdownValue(
                                  brandDd.value);
                          args.args.filters.params["tireType"] =
                              FilterValueSetters.setDropdownValue(typeDd.value);
                          args.args.filters.params["tireMaterial"] =
                              FilterValueSetters.setSwitchValueWithOffset(
                                  materialSwitch.value, args.args.filters);

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
