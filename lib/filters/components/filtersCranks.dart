import 'package:flutter/material.dart';
import 'package:letbike/app/filterPage.dart';
import '../../general/widgets/filterWidgets.dart';
import '../../general/general.dart';

class FiltersCranks extends StatefulWidget {
  @override
  _FiltersCranks createState() => _FiltersCranks();

  static const routeName = "/FiltersCranks";
}

class _FiltersCranks extends State<FiltersCranks>
    with TickerProviderStateMixin {
  AddItemFiltersArgs args;

  double volume = 0;

  AnimationController animationController;

  FilterDropdown brandDd =
      new FilterDropdown(hint: "Značka", options: Cranks.brand);
  FilterDropdown compatibilityDd =
      new FilterDropdown(hint: "Kompatibilita", options: Cranks.compatibility);
  FilterDropdown materialDd =
      new FilterDropdown(hint: "Materiál", options: Cranks.material);
  FilterDropdown axisDd = new FilterDropdown(hint: "Osa", options: Cranks.axis);

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
                      compatibilityDd,
                      Container(
                        height: 20,
                      ),
                      materialDd,
                      Container(
                        height: 20,
                      ),
                      axisDd,
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
                          args.args.filters.params["cranksBrand"] =
                              FilterValueSetters.setDropdownValue(
                                  brandDd.value);
                          args.args.filters.params["cranksCompatibility"] =
                              FilterValueSetters.setDropdownValue(
                                  compatibilityDd.value);
                          args.args.filters.params["cranksMaterial"] =
                              FilterValueSetters.setDropdownValue(
                                  materialDd.value);
                          args.args.filters.params["cranksAxis"] =
                              FilterValueSetters.setDropdownValue(axisDd.value);

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
