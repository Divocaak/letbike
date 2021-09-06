import 'package:flutter/material.dart';
import 'package:letbike/addItem/addItem.dart';
import 'package:letbike/app/homePage.dart';
import '../general/general.dart';

class FilterPage extends StatefulWidget {
  @override
  _FilterPage createState() => _FilterPage();

  static const routeName = "/filterPage";
}

class _FilterPage extends State<FilterPage> {
  AddItemFiltersArgs addItemArgs;

  int widgetCount = 2;

  FilterSwitch usedSwitch =
      new FilterSwitch(label: "Použité", left: "Ne", right: "Ano");
  FilterDropdown categoryDd =
      new FilterDropdown(hint: "Kategorie", options: Category.categories);

  FilterDropdown bikeBrandDd =
      new FilterDropdown(hint: "Značka kola", options: Bike.brand);
  FilterDropdown bikeTypeDd =
      new FilterDropdown(hint: "Typ kola", options: Bike.type);

  FilterDropdown partTypeDd =
      new FilterDropdown(hint: "Typ komponentu", options: Category.parts);

  FilterDropdown partWheelBrandDd =
      new FilterDropdown(hint: "Značka kola", options: Wheel.brand);
  FilterDropdown partWheelSizeDd =
      new FilterDropdown(hint: "Velikost", options: Wheel.size);
  FilterDropdown partWheelMaterialDd =
      new FilterDropdown(hint: "Materiál", options: Wheel.material);
  FilterSwitch partWheelSpokesSwitch =
      new FilterSwitch(label: "Typ drátů", left: "Kulaté", right: "Ploché");
  FilterSwitch partWheelTypeSwitch = new FilterSwitch(
      label: "Provedení náboje", left: "Přední", right: "Zadní");
  FilterDropdown partWheelAxisDd =
      new FilterDropdown(hint: "Osa", options: Wheel.axis);
  FilterSwitch partWheelBrakesSwitch =
      new FilterSwitch(label: "Typ brzd", left: "Kotoučové", right: "V-Brzdy");
  FilterSwitch partWheelCassetteSwitch = new FilterSwitch(
      label: "Provedení kazety", left: "Závit", right: "Ořech");
  FilterDropdown partWheelCompatibilityDd =
      new FilterDropdown(hint: "Kompatibilita", options: Wheel.compatibility);
  FilterDropdown partWheelMoreNutDd =
      new FilterDropdown(hint: "Značka ořechu", options: Wheel.nut);
  FilterSwitch partWheelMoreDiscBrakesSwitch = new FilterSwitch(
      label: "Uchycení disku", left: "CenterLock", right: "6 děr");

  FilterDropdown partCranksBrandDd =
      new FilterDropdown(hint: "Značka", options: Cranks.brand);
  FilterDropdown partCranksCompatibilityDd =
      new FilterDropdown(hint: "Kompatibilita", options: Cranks.compatibility);
  FilterDropdown partCranksMaterialDd =
      new FilterDropdown(hint: "Materiál", options: Cranks.material);
  FilterDropdown partCranksAxisDd =
      new FilterDropdown(hint: "Osa", options: Cranks.axis);

  FilterDropdown partConverterBrandDd =
      new FilterDropdown(hint: "Značka", options: Converter.brand);
  FilterDropdown partConverterNumOfSpeedsDd = new FilterDropdown(
      hint: "Počet rychlostí", options: Converter.numOfSpeeds);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    addItemArgs = ModalRoute.of(context).settings.arguments;
    categoryDd.fp = this;
    partTypeDd.fp = this;
    partWheelCassetteSwitch.fp = this;
    partWheelBrakesSwitch.fp = this;
    return Scaffold(
        floatingActionButton: MainButton(
            iconData: Icons.save,
            onPressed: () => addItemArgs.addItemData == null
                ? Navigator.of(context).pushReplacementNamed(HomePage.routeName,
                    arguments: addItemArgs.args)
                : Navigator.of(context).pushReplacementNamed(AddItem.routeName,
                    arguments: addItemArgs)),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        body: Stack(children: [
          BackgroundImage(),
          ListView(
            children: [
              usedSwitch,
              categoryDd,
              case2(
                  categoryDd.value,
                  {
                    0: bikeColumn(),
                    1: partsColumn(),
                    2: accessoriesColumn(),
                    3: otherColumn()
                  },
                  Container())
            ],
          )
        ]));
  }

  Widget bikeColumn() {
    return Column(children: [bikeBrandDd, bikeTypeDd]);
  }

//_________________________________________________________________________parts
  Widget partsColumn() {
    return Column(children: [
      case2(
          partTypeDd.value,
          {
            0: partWheelColumn(),
            1: partCranksColumn(),
            2: partConverter(),
            3: partSaddle(),
            4: partFork(),
            5: partBowden(),
            6: partBrakes(),
            7: partTube(),
            8: partGrips(),
            9: partHeadset(),
            10: partCassette(),
            11: partAxis(),
            12: partPedals(),
            13: partTires(),
            14: partStem(),
            15: partEBikeParts(),
            16: partRim(),
            17: partFrame(),
            18: partGearChange(),
            19: partHandlebars(),
            20: partSaddlePipe(),
            21: partShockAbs(),
          },
          Container())
    ]);
  }

  Widget partWheelColumn() {
    return Column(children: [
      partWheelBrandDd,
      partWheelSizeDd,
      partWheelMaterialDd,
      partWheelSpokesSwitch,
      partWheelTypeSwitch,
      partWheelAxisDd,
      partWheelBrakesSwitch,
      (partWheelBrakesSwitch.value
          ? partWheelMoreDiscBrakesSwitch
          : Container()),
      partWheelCassetteSwitch,
      (partWheelCassetteSwitch.value ? partWheelMoreNutDd : Container()),
      partWheelCompatibilityDd
    ]);
  }

  Widget partCranksColumn() {
    return Column(children: [
      partCranksBrandDd,
      partCranksCompatibilityDd,
      partCranksMaterialDd,
      partCranksAxisDd
    ]);
  }

  Widget partConverter() {
    return Column(children: [partConverterBrandDd, partConverterNumOfSpeedsDd]);
  }

  FilterDropdown partSaddleBrandDd =
      new FilterDropdown(hint: "Značka sedla", options: Saddle.brand);
  FilterDropdown partSaddleGenderDd =
      new FilterDropdown(hint: "Pohlaví", options: Saddle.gender);

  Widget partSaddle() {
    return Column(children: [partSaddleBrandDd, partSaddleGenderDd]);
  }

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

  Widget partFork() {
    return Column(children: []);
  }

  Widget partBowden() {
    return Column(children: []);
  }

  Widget partBrakes() {
    return Column(children: []);
  }

  Widget partTube() {
    return Column(children: []);
  }

  Widget partGrips() {
    return Column(children: []);
  }

  Widget partHeadset() {
    return Column(children: []);
  }

  Widget partCassette() {
    return Column(children: []);
  }

  Widget partAxis() {
    return Column(children: []);
  }

  Widget partPedals() {
    return Column(children: []);
  }

  Widget partTires() {
    return Column(children: []);
  }

  Widget partStem() {
    return Column(children: []);
  }

  Widget partEBikeParts() {
    return Column(children: []);
  }

  Widget partRim() {
    return Column(children: []);
  }

  Widget partFrame() {
    return Column(children: []);
  }

  Widget partGearChange() {
    return Column(children: []);
  }

  Widget partHandlebars() {
    return Column(children: []);
  }

  Widget partSaddlePipe() {
    return Column(children: []);
  }

  Widget partShockAbs() {
    return Column(children: []);
  }

//___________________________________________________________________accessories
  Widget accessoriesColumn() {
    return Column(children: []);
  }

//_________________________________________________________________________other
  Widget otherColumn() {
    return Column(children: []);
  }

  TValue case2<TOptionType, TValue>(
    TOptionType selectedOption,
    Map<TOptionType, TValue> branches, [
    TValue defaultValue,
  ]) {
    if (!branches.containsKey(selectedOption)) {
      return defaultValue;
    }

    return branches[selectedOption];
  }
}
