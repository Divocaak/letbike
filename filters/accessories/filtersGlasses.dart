import 'package:flutter/material.dart';
import 'package:letbike/app/filterPage.dart';
import '../../general/widgets/filterWidgets.dart';
import '../../general/general.dart';

class FiltersGlasses extends StatefulWidget {
  @override
  _FiltersGlasses createState() => _FiltersGlasses();

  static const routeName = "/FiltersGlasses";
}

class _FiltersGlasses extends State<FiltersGlasses>
    with TickerProviderStateMixin {
  AddItemFiltersArgs args;

  double volume = 0;

  AnimationController animationController;

  FilterDropdown typeDd =
      new FilterDropdown(hint: "Typ", options: Glasses.type);
  FilterDropdown glassDd =
      new FilterDropdown(hint: "Skla", options: Glasses.glass);
  FilterDropdown genderDd =
      new FilterDropdown(hint: "Pohlaví", options: Glasses.gender);
  FilterSwitch changeGlassSwitch =
      new FilterSwitch(label: "Lze vyměnit skla", left: "Ano", right: "Ne");
  FilterSwitch changeHolderSwitch =
      new FilterSwitch(label: "Lze vyměnit nosník", left: "Ano", right: "Ne");

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
                      glassDd,
                      Container(
                        height: 20,
                      ),
                      genderDd,
                      Container(
                        height: 20,
                      ),
                      changeGlassSwitch,
                      Container(
                        height: 20,
                      ),
                      changeHolderSwitch
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
                          args.args.filters.params["glassType"] =
                              FilterValueSetters.setDropdownValue(typeDd.value);
                          args.args.filters.params["glassGlass"] =
                              FilterValueSetters.setDropdownValue(
                                  glassDd.value);
                          args.args.filters.params["glassGender"] =
                              FilterValueSetters.setDropdownValue(
                                  genderDd.value);
                          args.args.filters.params["glassGlassChange"] =
                              FilterValueSetters.setSwitchValueWithOffset(
                                  changeGlassSwitch.value, args.args.filters);
                          args.args.filters.params["glassHolderChange"] =
                              FilterValueSetters.setSwitchValueWithOffset(
                                  changeHolderSwitch.value, args.args.filters);

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
