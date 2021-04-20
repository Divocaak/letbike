import 'package:flutter/material.dart';
import 'package:letbike/app/filterPage.dart';
import '../../../general/widgets/filterWidgets.dart';
import '../../../general/general.dart';

class FiltersBrakeMore extends StatefulWidget {
  @override
  _FiltersBrakeMore createState() => _FiltersBrakeMore();

  static const routeName = "/FiltersBrakeMore";
}

class _FiltersBrakeMore extends State<FiltersBrakeMore>
    with TickerProviderStateMixin {
  AddItemFiltersArgs args;

  double volume = 0;

  AnimationController animationController;

  FilterSwitch discSwitch = new FilterSwitch(
    label: "Typ brzdy",
    left: "Hydraulická",
    right: "Mechanická",
  );
  FilterDropdown discDd =
      new FilterDropdown(hint: "Průměr kotouče", options: Brakes.discSize);

  FilterDropdown blockDd = new FilterDropdown(
    hint: "Typ brzdy",
    options: Brakes.blockType,
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
                      if (args.args.filters.params["brakeType"] == 0) ...[
                        discSwitch,
                        Container(
                          height: 20,
                        ),
                        discDd
                      ],
                      if (args.args.filters.params["brakeType"] == 1) blockDd
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
                          args.args.filters.params["brakeDiscType"] =
                              FilterValueSetters.setSwitchValueWithOffset(
                                  discSwitch.value, args.args.filters);
                          args.args.filters.params["brakeDiscSize"] =
                              FilterValueSetters.setDropdownValue(discDd.value);
                          args.args.filters.params["brakeBlockType"] =
                              FilterValueSetters.setDropdownValue(
                                  blockDd.value);

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
