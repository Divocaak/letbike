import 'package:flutter/material.dart';
import 'package:letbike/app/filterPage.dart';
import '../../../general/widgets/filterWidgets.dart';
import '../../../general/general.dart';

class FiltersWheelMore extends StatefulWidget {
  @override
  _FiltersWheelMore createState() => _FiltersWheelMore();

  static const routeName = "/FiltersWheelMore";
}

class _FiltersWheelMore extends State<FiltersWheelMore>
    with TickerProviderStateMixin {
  FiltersWheelMoreArgs args;

  double volume = 0;

  AnimationController animationController;

  FilterDropdown nutDd =
      new FilterDropdown(hint: "Značka ořechu", options: Wheel.nut);
  FilterSwitch discBrakesSwitch = new FilterSwitch(
      label: "Uchycení disku", left: "CenterLock", right: "6 děr");

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
                      if (args.nut) ...[
                        nutDd,
                        Container(
                          height: 20,
                        ),
                      ],
                      if (!args.brakes) discBrakesSwitch,
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
                          args.args
                            ..args.filters.params["wheelNut"] =
                                FilterValueSetters.setDropdownValue(
                                    nutDd.value);
                          args.args.args.filters.params["wheeldBrakesDisc"] =
                              FilterValueSetters.setSwitchValueWithOffset(
                                  discBrakesSwitch.value,
                                  args.args.args.filters);

                          Navigator.of(context).pushReplacementNamed(
                              FilterPage.routeName,
                              arguments: args.args);
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

class FiltersWheelMoreArgs {
  AddItemFiltersArgs args;
  bool nut;
  bool brakes;

  FiltersWheelMoreArgs(this.args, this.nut, this.brakes);
}
