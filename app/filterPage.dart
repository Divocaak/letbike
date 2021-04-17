import 'package:flutter/material.dart';
import 'package:letbike/app/homePage.dart';
import 'package:letbike/filters/filtersBase.dart';
import '../general/general.dart';

class FilterPage extends StatefulWidget {
  @override
  _FilterPage createState() => _FilterPage();

  static const routeName = "/filterPage";
}

class _FilterPage extends State<FilterPage> with TickerProviderStateMixin {
  HomeArguments homeArgs;

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
    homeArgs = ModalRoute.of(context).settings.arguments;

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
                      Text("Nastavené filtry:"),
                      Text("tabulka jako u itemu, šupšup")
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
                            Icons.arrow_back,
                            kWhite.withOpacity(volume * 2), () {
                          Navigator.of(context).pushReplacementNamed(
                              HomePage.routeName,
                              arguments: homeArgs /* getArguments() */);
                        })),
                    Positioned(
                        bottom: 150,
                        right: 40,
                        child: CircularButton(
                            kSecondaryColor.withOpacity(volume * 2),
                            45,
                            Icons.filter_alt,
                            kWhite.withOpacity(volume * 2), () {
                          Navigator.of(context).pushReplacementNamed(
                              FiltersBase.routeName,
                              arguments: homeArgs);
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

  /* HomeArguments getArguments() {
    return new HomeArguments(
        homeArgs.user,
        new ItemParams({
          
          
           
          "wheelBrand": wheel.selectedBrand != null ? wheel.selectedBrand : -1,
          "wheelSize": wheel.selectedSize != null ? wheel.selectedSize : -1,
          "wheelMaterial":
              wheel.selectedMaterial != null ? wheel.selectedMaterial : -1,
          "wheeldSpokes": ((wheel.selectedSpokes ? 1 : 0) +
              (category.selectedPart != null ? category.selectedPart : 0) +
              (category.selectedOther != null ? category.selectedOther : 0) +
              999),
          "wheeldType": ((wheel.selectedType ? 1 : 0) +
              (category.selectedPart != null ? category.selectedPart : 0) +
              (category.selectedOther != null ? category.selectedOther : 0) +
              999),
          "wheelAxis": wheel.selectedAxis != null ? wheel.selectedAxis : -1,
          "wheeldBrakesType": ((wheel.selectedBrakesType ? 1 : 0) +
              (category.selectedPart != null ? category.selectedPart : 0) +
              (category.selectedOther != null ? category.selectedOther : 0) +
              999),
          "wheeldBrakesDisc": ((wheel.selectedBrakesDisc ? 1 : 0) +
              (category.selectedPart != null ? category.selectedPart : 0) +
              (category.selectedOther != null ? category.selectedOther : 0) +
              999),
          "wheeldCassette": ((wheel.selectedCassette ? 1 : 0) +
              (category.selectedPart != null ? category.selectedPart : 0) +
              (category.selectedOther != null ? category.selectedOther : 0) +
              999),
          "wheelNut": wheel.selectedNut != null ? wheel.selectedNut : -1,
          "wheelCompatibility": wheel.selectedCompatibility != null
              ? wheel.selectedCompatibility
              : -1,
          "cranksBrand":
              cranks.selectedBrand != null ? cranks.selectedBrand : -1,
          "cranksCompatibility": cranks.selectedCompatibility != null
              ? cranks.selectedCompatibility
              : -1,
          "cranksMaterial":
              cranks.selectedMaterial != null ? cranks.selectedMaterial : -1,
          "cranksAxis": cranks.selectedAxis != null ? cranks.selectedAxis : -1,
          "converterBrand":
              converter.selectedBrand != null ? converter.selectedBrand : -1,
          "converterNumOfSpeeds": converter.selectedNumOfSpeeds != null
              ? converter.selectedNumOfSpeeds
              : -1,
          "saddleBrand":
              saddle.selectedBrand != null ? saddle.selectedBrand : -1,
          "saddleGender":
              saddle.selectedGender != null ? saddle.selectedGender : -1,
          "forkBrand": fork.selectedBrand != null ? fork.selectedBrand : -1,
          "forkSize": fork.selectedSize != null ? fork.selectedSize : -1,
          "forkSuspensionType": ((fork.selectedSuspensionType ? 1 : 0) +
              (category.selectedPart != null ? category.selectedPart : 0) +
              (category.selectedOther != null ? category.selectedOther : 0) +
              999),
          "forkSuspension": ((fork.selectedSuspension ? 1 : 0) +
              (category.selectedPart != null ? category.selectedPart : 0) +
              (category.selectedOther != null ? category.selectedOther : 0) +
              999),
          "forkWheelCoompatibility": fork.selectedWheelCoompatibility != null
              ? fork.selectedWheelCoompatibility
              : -1,
          "forkMaterial":
              fork.selectedMaterial != null ? fork.selectedMaterial : -1,
          "forkMaterialColumn": fork.selectedMaterialColumn != null
              ? fork.selectedMaterialColumn
              : -1,
          "eBikeBrand": eBike.selectedBrand != null ? eBike.selectedBrand : -1,
          "eBikeMotorPos": ((eBike.selectedMotorPos ? 1 : 0) +
              (category.selectedPart != null ? category.selectedPart : 0) +
              (category.selectedOther != null ? category.selectedOther : 0) +
              999),
          "trainerBrand":
              trainer.selectedBrand != null ? trainer.selectedBrand : -1,
          "trainerBrakes":
              trainer.selectedBrakes != null ? trainer.selectedBrakes : -1,
          "scooterBrand":
              scooter.selectedBrand != null ? scooter.selectedBrand : -1,
          "scooterSize":
              scooter.selectedSize != null ? scooter.selectedSize : -1,
          "scooterComputer": ((scooter.selectedComputer ? 1 : 0) +
              (category.selectedPart != null ? category.selectedPart : 0) +
              (category.selectedOther != null ? category.selectedOther : 0) +
              999),
        }));
  } */
}
