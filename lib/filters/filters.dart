import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:letbike/homePage.dart';
import 'package:letbike/widgets/mainButtonEssentials.dart';
import 'package:letbike/widgets/images.dart';
import 'package:letbike/filters/widgetsFilter.dart';
import 'package:letbike/general/objects.dart';
import 'package:letbike/remote/items.dart';
import 'package:letbike/general/pallete.dart';
import 'package:letbike/widgets/alertBox.dart';
import 'package:letbike/widgets/errorWidgets.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';

class FilterPage extends StatefulWidget {
  FilterPage(
      {Key? key,
      required User loggedUser,
      String? name,
      String? desc,
      String? price,
      List<Asset>? images})
      : _loggedUser = loggedUser,
        _name = name,
        _desc = desc,
        _price = price,
        _images = images,
        super(key: key);

  final User _loggedUser;
  final String? _name;
  final String? _desc;
  final String? _price;
  final List<Asset>? _images;

  @override
  _FilterPage createState() => _FilterPage();
}

Future<bool>? addResponse;

class _FilterPage extends State<FilterPage> {
  @override
  Widget build(BuildContext context) {
    categoryDd.setFp(this);
    partTypeDd.setFp(this);
    partWheelCassetteSwitch.setFp(this);
    partWheelBrakesSwitch.setFp(this);
    partForkSuspensionSwitch.setFp(this);
    partBrakeTypeDd.setFp(this);
    otherTypeDd.setFp(this);
    accessoryTypeDd.setFp(this);
    return Scaffold(
        floatingActionButton: MainButton(
            iconData: widget._name == null ? Icons.save : Icons.add,
            onPressed: () {
              if (widget._name == null) {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => HomePage(
                        loggedUser: widget._loggedUser, filters: getParams())));
              } else {
                addResponse = RemoteItems.createItem(
                    widget._loggedUser.uid,
                    widget._name!,
                    widget._desc!,
                    widget._price!,
                    getParams(),
                    widget._images!);

                ModalWindow.showModalWindow(
                    context,
                    "Oznámení",
                    FutureBuilder<bool>(
                        future: addResponse,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                                child: Image.asset("assets/load.gif"));
                          } else {
                            if (snapshot.hasData) {
                              return Text("Inzerát úspěšně přidán",
                                  style: TextStyle(color: kWhite));
                            } else if (snapshot.hasError) {
                              return ErrorWidgets.futureBuilderError();
                            } else {
                              return ErrorWidgets.futureBuilderEmpty();
                            }
                          }
                        }),
                    after: () => Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                            builder: (context) =>
                                HomePage(loggedUser: widget._loggedUser))));
              }
            }),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        body: Stack(children: [
          BackgroundImage(),
          ListView(children: [
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
          ])
        ]));
  }

//__________________________________________________________________________bike
  Widget bikeColumn() {
    return Column(children: [bikeBrandDd, bikeTypeDd]);
  }

//_________________________________________________________________________parts
  Widget partsColumn() {
    return Column(children: [
      partTypeDd,
      case2(
          partTypeDd.value,
          {
            0: partWheelColumn(),
            1: partCranksColumn(),
            2: partConverter(),
            3: partSaddle(),
            4: partFork(),
            5: partBowdenTypeDd,
            6: partBrakes(),
            7: partTube(),
            8: partGripsTypeDd,
            9: partHeadsetTypeDd,
            10: partCassetteTypeDd,
            11: partAxisTypeDd,
            12: partPedalsTypeDd,
            13: partTires(),
            14: partStemTypeDd,
            15: partEbikeTypeDd,
            16: partRimSizeDd,
            17: partFrame(),
            18: partGearChangeTypeDd,
            19: partHandlebars(),
            20: partSaddlePipe(),
            21: partShockAbsTypeDd
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

  Widget partSaddle() {
    return Column(children: [partSaddleBrandDd, partSaddleGenderDd]);
  }

  Widget partFork() {
    return Column(children: [
      partForkBrandDd,
      partForkSizeDd,
      partForkSuspensionSwitch,
      (partForkSuspensionSwitch.value
          ? partForkMoreSuspensionSwitch
          : Container()),
      partForkCompatibilityDd,
      partForkMaterialDd,
      partForkMaterialColDd
    ]);
  }

  Widget partBrakes() {
    return Column(children: [
      partBrakeBrandDd,
      partBrakeTypeDd,
      if (partBrakeTypeDd.value == 0)
        Column(children: [
          partBrakeMoreDiscSwitch,
          partBrakeMoreDiscDd,
          partBrakeMoreBlockDd
        ])
    ]);
  }

  Widget partTube() {
    return Column(children: [partTubeSizeDd, partTubeTypeDd]);
  }

  Widget partTires() {
    return Column(children: [
      partTiresSizeDd,
      partTiresWidthDd,
      partTiresBrandDd,
      partTiresTypeDd,
      partTiresMaterialSwitch
    ]);
  }

  Widget partFrame() {
    return Column(
        children: [partFrameSizeDd, partFrameForkDd, partFrameTypeDd]);
  }

  Widget partHandlebars() {
    return Column(children: [
      partHandlebarsTypeDd,
      partHandlebarsMaterialDd,
      partHandlebarsWidthDd,
      partHandlebarsSizeDd
    ]);
  }

  Widget partSaddlePipe() {
    return Column(children: [
      partSaddlePipeTypeDd,
      partSaddlePipeLengthDd,
      partSaddlePipeMaterialDd,
      partSaddlePipeSizeDd
    ]);
  }

//___________________________________________________________________accessories
  Widget accessoriesColumn() {
    return Column(children: [
      accessoryTypeDd,
      case2(
          accessoryTypeDd.value,
          {
            0: accessoryMudguard(),
            2: accessoryGlasses(),
            3: accessoryCompsTypeDd,
            4: accessoryKidSaddleTypeDd,
            5: accessoryHelmetTypeSwitch,
            6: accessoryPumpsTypeDd,
            7: accessoryBottleHolderTypeDd,
            8: accessoryToolsTypeDd,
            9: accessoryRack(),
            10: accessoryClothes(),
            11: accessoryBoots(),
            13: accessoryLightLightSwitch,
            15: accessoryLockTypeDd,
            16: accessoryCarRackTypeSwitch
          },
          Container())
    ]);
  }

  Widget accessoryMudguard() {
    return Column(
        children: [accessoryMudguardsTypeDd, accessoryMudguardsSizeDd]);
  }

  Widget accessoryGlasses() {
    return Column(children: [
      accessoryGlassesTypeDd,
      accessoryGlassesGlassDd,
      accessoryGlassesGenderDd,
      accessoryGlassesChangeGlassSwitch,
      accessoryGlassesChangeHolderSwitch
    ]);
  }

  Widget accessoryRack() {
    return Column(children: [accessoryRackTypeSwitch, accessoryRackSizeDd]);
  }

  Widget accessoryClothes() {
    return Column(children: [
      accessoryClothesTypeDd,
      accessoryClothesGenderDd,
      accessoryClothesSizeDd
    ]);
  }

  Widget accessoryBoots() {
    return Column(children: [accessoryBootsTypeDd, accessoryBootsSizeDd]);
  }

//_________________________________________________________________________other
  Widget otherColumn() {
    return Column(children: [
      otherTypeDd,
      case2(otherTypeDd.value,
          {0: otherEBike(), 1: otherTrainer(), 2: otherScooter()}, Container())
    ]);
  }

  Widget otherEBike() {
    return Column(children: [otherEBikeBrandDd, otherEBikeTypeSwitch]);
  }

  Widget otherTrainer() {
    return Column(children: [otherTrainerBrandDd, otherTrainerTypeDd]);
  }

  Widget otherScooter() {
    return Column(children: [
      otherScooterBrandDd,
      otherScooterSizeDd,
      otherScooterCompSwitch
    ]);
  }

  TValue case2<TOptionType, TValue>(
      TOptionType selectedOption, Map<TOptionType, TValue> branches,
      [TValue? defaultValue]) {
    if (!branches.containsKey(selectedOption)) {
      return defaultValue!;
    }

    return branches[selectedOption]!;
  }

  Map<String, String> getParams() {
    List<dynamic> valWidgets = [usedSwitch, categoryDd];

    switch (categoryDd.value) {
      case 0:
        valWidgets.addAll([bikeBrandDd, bikeTypeDd]);
        break;
      case 1:
        valWidgets.add(partTypeDd);
        switch (partTypeDd.value) {
          case 0:
            valWidgets.addAll([
              partWheelBrandDd,
              partWheelSizeDd,
              partWheelMaterialDd,
              partWheelSpokesSwitch,
              partWheelTypeSwitch,
              partWheelAxisDd,
              partWheelBrakesSwitch,
              (partWheelBrakesSwitch.value
                  ? partWheelMoreDiscBrakesSwitch
                  : null),
              partWheelCassetteSwitch,
              (partWheelCassetteSwitch.value ? partWheelMoreNutDd : null),
              partWheelCompatibilityDd
            ]);
            break;
          case 1:
            valWidgets.addAll([
              partCranksBrandDd,
              partCranksCompatibilityDd,
              partCranksMaterialDd,
              partCranksAxisDd
            ]);
            break;
          case 2:
            valWidgets
                .addAll([partConverterBrandDd, partConverterNumOfSpeedsDd]);
            break;
          case 3:
            valWidgets.addAll([partSaddleBrandDd, partSaddleGenderDd]);
            break;
          case 4:
            valWidgets.addAll([
              partForkBrandDd,
              partForkSizeDd,
              partForkSuspensionSwitch,
              (partForkSuspensionSwitch.value
                  ? partForkMoreSuspensionSwitch
                  : null),
              partForkCompatibilityDd,
              partForkMaterialDd,
              partForkMaterialColDd
            ]);
            break;
          case 5:
            valWidgets.add(partBowdenTypeDd);
            break;
          case 6:
            valWidgets.addAll([
              partBrakeBrandDd,
              partBrakeTypeDd,
              (partBrakeTypeDd.value == 0 ? partBrakeMoreDiscSwitch : null),
              (partBrakeTypeDd.value == 0 ? partBrakeMoreDiscDd : null),
              (partBrakeTypeDd.value == 0 ? partBrakeMoreBlockDd : null)
            ]);
            break;
          case 7:
            valWidgets.addAll([partTubeSizeDd, partTubeTypeDd]);
            break;
          case 8:
            valWidgets.add(partGripsTypeDd);
            break;
          case 9:
            valWidgets.add(partHeadsetTypeDd);
            break;
          case 10:
            valWidgets.add(partCassetteTypeDd);
            break;
          case 11:
            valWidgets.add(partAxisTypeDd);
            break;
          case 12:
            valWidgets.add(partPedalsTypeDd);
            break;
          case 13:
            valWidgets.addAll([
              partTiresSizeDd,
              partTiresWidthDd,
              partTiresBrandDd,
              partTiresTypeDd,
              partTiresMaterialSwitch
            ]);
            break;
          case 14:
            valWidgets.add(partStemTypeDd);
            break;
          case 15:
            valWidgets.add(partEbikeTypeDd);
            break;
          case 16:
            valWidgets.add(partRimSizeDd);
            break;
          case 17:
            valWidgets
                .addAll([partFrameSizeDd, partFrameForkDd, partFrameTypeDd]);
            break;
          case 18:
            valWidgets.add(partGearChangeTypeDd);
            break;
          case 19:
            valWidgets.addAll([
              partHandlebarsTypeDd,
              partHandlebarsMaterialDd,
              partHandlebarsWidthDd,
              partHandlebarsSizeDd
            ]);
            break;
          case 20:
            valWidgets.addAll([
              partSaddlePipeTypeDd,
              partSaddlePipeLengthDd,
              partSaddlePipeMaterialDd,
              partSaddlePipeSizeDd
            ]);
            break;
          case 21:
            valWidgets.add(partShockAbsTypeDd);
            break;
        }
        break;
      case 2:
        valWidgets.add(accessoryTypeDd);
        switch (accessoryTypeDd.value) {
          case 0:
            valWidgets
                .addAll([accessoryMudguardsTypeDd, accessoryMudguardsSizeDd]);
            break;
          case 2:
            valWidgets.addAll([
              accessoryGlassesTypeDd,
              accessoryGlassesGlassDd,
              accessoryGlassesGenderDd,
              accessoryGlassesChangeGlassSwitch,
              accessoryGlassesChangeHolderSwitch
            ]);
            break;
          case 3:
            valWidgets.add(accessoryCompsTypeDd);
            break;
          case 4:
            valWidgets.add(accessoryKidSaddleTypeDd);
            break;
          case 5:
            valWidgets.add(accessoryHelmetTypeSwitch);
            break;
          case 6:
            valWidgets.add(accessoryPumpsTypeDd);
            break;
          case 7:
            valWidgets.add(accessoryBottleHolderTypeDd);
            break;
          case 8:
            valWidgets.add(accessoryToolsTypeDd);
            break;
          case 9:
            valWidgets.addAll([accessoryRackTypeSwitch, accessoryRackSizeDd]);
            break;
          case 10:
            valWidgets.addAll([
              accessoryClothesTypeDd,
              accessoryClothesGenderDd,
              accessoryClothesSizeDd
            ]);
            break;
          case 11:
            valWidgets.addAll([accessoryBootsTypeDd, accessoryBootsSizeDd]);
            break;
          case 13:
            valWidgets.add(accessoryLightLightSwitch);
            break;
          case 15:
            valWidgets.add(accessoryLockTypeDd);
            break;
          case 16:
            valWidgets.add(accessoryCarRackTypeSwitch);
            break;
        }
        break;
      case 3:
        valWidgets.add(otherTypeDd);
        switch (otherTypeDd.value) {
          case 0:
            valWidgets.addAll([otherEBikeBrandDd, otherEBikeTypeSwitch]);
            break;
          case 1:
            valWidgets.addAll([otherTrainerBrandDd, otherTrainerTypeDd]);
            break;
          case 2:
            valWidgets.addAll([
              otherScooterBrandDd,
              otherScooterSizeDd,
              otherScooterCompSwitch
            ]);
            break;
        }
        break;
    }

    Map<String, String> filters = {};
    for (dynamic valueWidget in valWidgets) {
      if (valueWidget != null && valueWidget.value != null) {
        filters[valueWidget.getKey()] = valueWidget.value.toString();
      }
    }

    return filters;
  }

//_______________________________________________________________________general
  FilterSwitch usedSwitch = new FilterSwitch(
      label: "Použité", left: "Ne", right: "Ano", filterKey: "usedSwitch");
  FilterDropdown categoryDd = new FilterDropdown(
      hint: "Kategorie", options: Category.categories, filterKey: "categoryDd");

//__________________________________________________________________________bike
  FilterDropdown bikeBrandDd = new FilterDropdown(
      hint: "Značka kola", options: Bike.brand, filterKey: "bikeBrandDd");
  FilterDropdown bikeTypeDd = new FilterDropdown(
      hint: "Typ kola", options: Bike.type, filterKey: "bikeTypeDd");

//_________________________________________________________________________parts
  FilterDropdown partTypeDd = new FilterDropdown(
      hint: "Typ komponentu", options: Category.parts, filterKey: "partTypeDd");

  FilterDropdown partWheelBrandDd = new FilterDropdown(
      hint: "Značka kola", options: Wheel.brand, filterKey: "partWheelBrandDd");
  FilterDropdown partWheelSizeDd = new FilterDropdown(
      hint: "Velikost", options: Wheel.size, filterKey: "partWheelSizeDd");
  FilterDropdown partWheelMaterialDd = new FilterDropdown(
      hint: "Materiál",
      options: Wheel.material,
      filterKey: "partWheelMaterialDd");
  FilterSwitch partWheelSpokesSwitch = new FilterSwitch(
      label: "Typ drátů",
      left: "Kulaté",
      right: "Ploché",
      filterKey: "partWheelSpokesSwitch");
  FilterSwitch partWheelTypeSwitch = new FilterSwitch(
      label: "Provedení náboje",
      left: "Přední",
      right: "Zadní",
      filterKey: "partWheelTypeSwitch");
  FilterDropdown partWheelAxisDd = new FilterDropdown(
      hint: "Osa", options: Wheel.axis, filterKey: "partWheelAxisDd");
  FilterSwitch partWheelBrakesSwitch = new FilterSwitch(
      label: "Typ brzd",
      left: "Kotoučové",
      right: "V-Brzdy",
      filterKey: "partWheelBrakesSwitch");
  FilterSwitch partWheelCassetteSwitch = new FilterSwitch(
      label: "Provedení kazety",
      left: "Závit",
      right: "Ořech",
      filterKey: "partWheelCassetteSwitch");
  FilterDropdown partWheelCompatibilityDd = new FilterDropdown(
      hint: "Kompatibilita",
      options: Wheel.compatibility,
      filterKey: "partWheelCompatibilityDd");
  FilterDropdown partWheelMoreNutDd = new FilterDropdown(
      hint: "Značka ořechu",
      options: Wheel.nut,
      filterKey: "partWheelMoreNutDd");
  FilterSwitch partWheelMoreDiscBrakesSwitch = new FilterSwitch(
      label: "Uchycení disku",
      left: "CenterLock",
      right: "6 děr",
      filterKey: "partWheelMoreDiscBrakesSwitch");

  FilterDropdown partCranksBrandDd = new FilterDropdown(
      hint: "Značka", options: Cranks.brand, filterKey: "partCranksBrandDd");
  FilterDropdown partCranksCompatibilityDd = new FilterDropdown(
      hint: "Kompatibilita",
      options: Cranks.compatibility,
      filterKey: "partCranksCompatibilityDd");
  FilterDropdown partCranksMaterialDd = new FilterDropdown(
      hint: "Materiál",
      options: Cranks.material,
      filterKey: "partCranksMaterialDd");
  FilterDropdown partCranksAxisDd = new FilterDropdown(
      hint: "Osa", options: Cranks.axis, filterKey: "partCranksAxisDd");

  FilterDropdown partConverterBrandDd = new FilterDropdown(
      hint: "Značka",
      options: Converter.brand,
      filterKey: "partConverterBrandDd");
  FilterDropdown partConverterNumOfSpeedsDd = new FilterDropdown(
      hint: "Počet rychlostí",
      options: Converter.numOfSpeeds,
      filterKey: "partConverterNumOfSpeedsDd");

  FilterDropdown partSaddleBrandDd = new FilterDropdown(
      hint: "Značka sedla",
      options: Saddle.brand,
      filterKey: "partSaddleBrandDd");
  FilterDropdown partSaddleGenderDd = new FilterDropdown(
      hint: "Pohlaví", options: Saddle.gender, filterKey: "partSaddleGenderDd");

  FilterDropdown partForkBrandDd = new FilterDropdown(
      hint: "Značka vidlice",
      options: Fork.brand,
      filterKey: "partForkBrandDd");
  FilterDropdown partForkSizeDd = new FilterDropdown(
      hint: "Velikost", options: Fork.size, filterKey: "partForkSizeDd");
  FilterSwitch partForkSuspensionSwitch = new FilterSwitch(
      label: "Typ",
      right: "Odpružená",
      left: "Pevná",
      filterKey: "partForkSuspensionSwitch");
  FilterDropdown partForkCompatibilityDd = new FilterDropdown(
      hint: "Kompatibilita",
      options: Fork.wheelCompatibility,
      filterKey: "partForkCompatibilityDd");
  FilterDropdown partForkMaterialDd = new FilterDropdown(
      hint: "Materiál",
      options: Fork.material,
      filterKey: "partForkMaterialDd");
  FilterDropdown partForkMaterialColDd = new FilterDropdown(
      hint: "Materiál sloupku",
      options: Fork.materialColumn,
      filterKey: "partForkMaterialColDd");
  FilterSwitch partForkMoreSuspensionSwitch = new FilterSwitch(
      label: "Odpružení",
      right: "Vzduchové",
      left: "Pružinové",
      filterKey: "partForkMoreSuspensionSwitch");

  FilterDropdown partBowdenTypeDd = new FilterDropdown(
      hint: "Typ", options: Bowden.type, filterKey: "partBowdenTypeDd");

  FilterDropdown partBrakeBrandDd = new FilterDropdown(
      hint: "Značka", options: Brakes.brand, filterKey: "partBrakeBrandDd");
  FilterDropdown partBrakeTypeDd = new FilterDropdown(
      hint: "Typ", options: Brakes.type, filterKey: "partBrakeTypeDd");
  FilterSwitch partBrakeMoreDiscSwitch = new FilterSwitch(
      label: "Typ brzdy",
      left: "Hydraulická",
      right: "Mechanická",
      filterKey: "partBrakeMoreDiscSwitch");
  FilterDropdown partBrakeMoreDiscDd = new FilterDropdown(
      hint: "Průměr kotouče",
      options: Brakes.discSize,
      filterKey: "partBrakeMoreDiscDd");
  FilterDropdown partBrakeMoreBlockDd = new FilterDropdown(
      hint: "Typ brzdy",
      options: Brakes.blockType,
      filterKey: "partBrakeMoreBlockDd");

  FilterDropdown partTubeSizeDd = new FilterDropdown(
      hint: "Průměr ráfku", options: Tube.size, filterKey: "partTubeSizeDd");
  FilterDropdown partTubeTypeDd = new FilterDropdown(
      hint: "Typ ventilku", options: Tube.type, filterKey: "partTubeTypeDd");

  FilterDropdown partGripsTypeDd = new FilterDropdown(
      hint: "Typ", options: Grips.type, filterKey: "partGripsTypeDd");

  FilterDropdown partHeadsetTypeDd = new FilterDropdown(
      hint: "Typ", options: Headset.type, filterKey: "partHeadsetTypeDd");

  FilterDropdown partCassetteTypeDd = new FilterDropdown(
      hint: "Typ", options: Cassette.type, filterKey: "partCassetteTypeDd");

  FilterDropdown partAxisTypeDd = new FilterDropdown(
      hint: "Typ", options: AxisCat.type, filterKey: "partAxisTypeDd");

  FilterDropdown partPedalsTypeDd = new FilterDropdown(
      hint: "Typ", options: Pedals.type, filterKey: "partPedalsTypeDd");

  FilterDropdown partTiresSizeDd = new FilterDropdown(
      hint: "Velikost", options: Tire.size, filterKey: "partTiresSizeDd");
  FilterDropdown partTiresWidthDd = new FilterDropdown(
      hint: "Šířka", options: Tire.width, filterKey: "partTiresWidthDd");
  FilterDropdown partTiresBrandDd = new FilterDropdown(
      hint: "Značka", options: Tire.brand, filterKey: "partTiresBrandDd");
  FilterDropdown partTiresTypeDd = new FilterDropdown(
      hint: "Typ", options: Tire.type, filterKey: "partTiresTypeDd");
  FilterSwitch partTiresMaterialSwitch = new FilterSwitch(
      label: "Materiál",
      left: "Kevlar",
      right: "Drát",
      filterKey: "partTiresMaterialSwitch");

  FilterDropdown partStemTypeDd = new FilterDropdown(
      hint: "Typ", options: Stem.type, filterKey: "partStemTypeDd");

  FilterDropdown partEbikeTypeDd = new FilterDropdown(
      hint: "Typ", options: EBikeComponents.type, filterKey: "partEbikeTypeDd");

  FilterDropdown partRimSizeDd = new FilterDropdown(
      hint: "Velikost", options: Rim.type, filterKey: "partRimSizeDd");

  FilterDropdown partFrameSizeDd = new FilterDropdown(
      hint: "Velikost", options: Frame.size, filterKey: "partFrameSizeDd");
  FilterDropdown partFrameForkDd = new FilterDropdown(
      hint: "Vidlice", options: Frame.fork, filterKey: "partFrameForkDd");
  FilterDropdown partFrameTypeDd = new FilterDropdown(
      hint: "Typ", options: Frame.type, filterKey: "partFrameTypeDd");

  FilterDropdown partGearChangeTypeDd = new FilterDropdown(
      hint: "Typ",
      options: GearChanger.type,
      filterKey: "partGearChangeTypeDd");

  FilterDropdown partHandlebarsTypeDd = new FilterDropdown(
      hint: "Tvar",
      options: Handlebars.type,
      filterKey: "partHandlebarsTypeDd");
  FilterDropdown partHandlebarsMaterialDd = new FilterDropdown(
      hint: "Materiál",
      options: Handlebars.material,
      filterKey: "partHandlebarsMaterialDd");
  FilterDropdown partHandlebarsWidthDd = new FilterDropdown(
      hint: "Šířka",
      options: Handlebars.width,
      filterKey: "partHandlebarsWidthDd");
  FilterDropdown partHandlebarsSizeDd = new FilterDropdown(
      hint: "Průměr",
      options: Handlebars.size,
      filterKey: "partHandlebarsSizeDd");

  FilterDropdown partSaddlePipeTypeDd = new FilterDropdown(
      hint: "Typ", options: SaddleTube.type, filterKey: "partSaddlePipeTypeDd");
  FilterDropdown partSaddlePipeLengthDd = new FilterDropdown(
      hint: "Délka",
      options: SaddleTube.length,
      filterKey: "partSaddlePipeLengthDd");
  FilterDropdown partSaddlePipeMaterialDd = new FilterDropdown(
      hint: "Materiál",
      options: SaddleTube.material,
      filterKey: "partSaddlePipeMaterialDd");
  FilterDropdown partSaddlePipeSizeDd = new FilterDropdown(
      hint: "Průměr",
      options: SaddleTube.size,
      filterKey: "partSaddlePipeSizeDd");

  FilterDropdown partShockAbsTypeDd = new FilterDropdown(
      hint: "Typ", options: ShockAbs.type, filterKey: "partShockAbsTypeDd");

//_________________________________________________________________________other
  FilterDropdown otherTypeDd = new FilterDropdown(
      hint: "Typ", options: Category.other, filterKey: "otherTypeDd");

  FilterDropdown otherEBikeBrandDd = new FilterDropdown(
      hint: "Značka kola",
      options: EBike.brand,
      filterKey: "otherEBikeBrandDd");
  FilterSwitch otherEBikeTypeSwitch = new FilterSwitch(
      label: "Umístění motoru",
      right: "Středový",
      left: "Nábojový",
      filterKey: "otherEBikeTypeSwitch");

  FilterDropdown otherTrainerBrandDd = new FilterDropdown(
      hint: "Značka tranažeru",
      options: Trainer.brand,
      filterKey: "otherTrainerBrandDd");
  FilterDropdown otherTrainerTypeDd = new FilterDropdown(
      hint: "Typ brždění",
      options: Trainer.brakes,
      filterKey: "otherTrainerTypeDd");

  FilterDropdown otherScooterBrandDd = new FilterDropdown(
      hint: "Značka koloběžky",
      options: Scooter.brand,
      filterKey: "otherScooterBrandDd");
  FilterDropdown otherScooterSizeDd = new FilterDropdown(
      hint: "Velikost koleček",
      options: Scooter.size,
      filterKey: "otherScooterSizeDd");
  FilterSwitch otherScooterCompSwitch = new FilterSwitch(
      label: "Počítač",
      left: "Ne",
      right: "Ano",
      filterKey: "otherScooterCompSwitch");

//___________________________________________________________________accessories
  FilterDropdown accessoryTypeDd = new FilterDropdown(
      hint: "Typ doplňku",
      options: Category.accessories,
      filterKey: "accessoryTypeDd");

  FilterDropdown accessoryToolsTypeDd = new FilterDropdown(
      hint: "Typ", options: Tools.type, filterKey: "accessoryToolsTypeDd");

  FilterDropdown accessoryMudguardsTypeDd = new FilterDropdown(
      hint: "Typ",
      options: Mudguard.type,
      filterKey: "accessoryMudguardsTypeDd");
  FilterDropdown accessoryMudguardsSizeDd = new FilterDropdown(
      hint: "Velikost",
      options: Mudguard.size,
      filterKey: "accessoryMudguardsSizeDd");

  FilterDropdown accessoryGlassesTypeDd = new FilterDropdown(
      hint: "Typ", options: Glasses.type, filterKey: "accessoryGlassesTypeDd");
  FilterDropdown accessoryGlassesGlassDd = new FilterDropdown(
      hint: "Skla",
      options: Glasses.glass,
      filterKey: "accessoryGlassesGlassDd");
  FilterDropdown accessoryGlassesGenderDd = new FilterDropdown(
      hint: "Pohlaví",
      options: Glasses.gender,
      filterKey: "accessoryGlassesGenderDd");
  FilterSwitch accessoryGlassesChangeGlassSwitch = new FilterSwitch(
      label: "Lze vyměnit skla",
      left: "Ano",
      right: "Ne",
      filterKey: "accessoryGlassesChangeGlassSwitch");
  FilterSwitch accessoryGlassesChangeHolderSwitch = new FilterSwitch(
      label: "Lze vyměnit nosník",
      left: "Ano",
      right: "Ne",
      filterKey: "accessoryGlassesChangeHolderSwitch");

  FilterDropdown accessoryCompsTypeDd = new FilterDropdown(
      hint: "Typ", options: Comp.type, filterKey: "accessoryCompsTypeDd");

  FilterDropdown accessoryKidSaddleTypeDd = new FilterDropdown(
      hint: "Typ",
      options: KidSaddle.type,
      filterKey: "accessoryKidSaddleTypeDd");

  FilterSwitch accessoryHelmetTypeSwitch = new FilterSwitch(
      label: "Typ",
      left: "Dospělí",
      right: "Dětské",
      filterKey: "accessoryHelmetTypeSwitch");

  FilterDropdown accessoryPumpsTypeDd = new FilterDropdown(
      hint: "Typ", options: Pump.type, filterKey: "accessoryPumpsTypeDd");

  FilterDropdown accessoryBottleHolderTypeDd = new FilterDropdown(
      hint: "Typ",
      options: BottleHolder.type,
      filterKey: "accessoryBottleHolderTypeDd");

  FilterSwitch accessoryRackTypeSwitch = new FilterSwitch(
      label: "Typ",
      left: "Přední",
      right: "Zadní",
      filterKey: "accessoryRackTypeSwitch");
  FilterDropdown accessoryRackSizeDd = new FilterDropdown(
      hint: "Velikost", options: Rack.type, filterKey: "accessoryRackSizeDd");

  FilterDropdown accessoryClothesTypeDd = new FilterDropdown(
      hint: "Typ",
      options: Clothes.clothesType,
      filterKey: "accessoryClothesTypeDd");
  FilterDropdown accessoryClothesGenderDd = new FilterDropdown(
      hint: "Pohlaví",
      options: Clothes.gender,
      filterKey: "accessoryClothesGenderDd");
  FilterDropdown accessoryClothesSizeDd = new FilterDropdown(
      hint: "Velikost",
      options: Clothes.size,
      filterKey: "accessoryClothesSizeDd");

  FilterDropdown accessoryBootsTypeDd = new FilterDropdown(
      hint: "Typ", options: Boots.type, filterKey: "accessoryBootsTypeDd");
  FilterDropdown accessoryBootsSizeDd = new FilterDropdown(
      hint: "Velikost", options: Boots.size, filterKey: "accessoryBootsSizeDd");

  FilterSwitch accessoryLightLightSwitch = new FilterSwitch(
      label: "Typ",
      left: "Přední",
      right: "Zadní",
      filterKey: "accessoryLightLightSwitch");

  FilterDropdown accessoryLockTypeDd = new FilterDropdown(
      hint: "Typ", options: Lock.type, filterKey: "accessoryLockTypeDd");

  FilterSwitch accessoryCarRackTypeSwitch = new FilterSwitch(
      label: "Typ",
      left: "Na střechu",
      right: "Na tažné",
      filterKey: "accessoryCarRackTypeSwitch");
}
