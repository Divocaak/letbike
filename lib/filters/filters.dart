import 'package:flutter/material.dart';
import 'package:letbike/item/addItem.dart';
import 'package:letbike/app/homePage.dart';
import '../general/general.dart';
import 'package:letbike/widgets/mainButtonEssentials.dart';
import 'package:letbike/widgets/backgroundImage.dart';
import 'package:letbike/filters/widgetsFilter.dart';

class FilterPage extends StatefulWidget {
  @override
  _FilterPage createState() => _FilterPage();

  static const routeName = "/filterPage";
}

class _FilterPage extends State<FilterPage> {
  AddItemFiltersArgs addItemArgs;

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
    partForkSuspensionSwitch.fp = this;
    partBrakeTypeDd.fp = this;
    otherTypeDd.fp = this;
    accessoryTypeDd.fp = this;
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
            21: partShockAbsTypeDd,
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
            16: accessoryCarRackTypeSwitch,
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
      case2(
          otherTypeDd.value,
          {
            0: otherEBike(),
            1: otherTrainer(),
            2: otherScooter(),
          },
          Container())
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
    TOptionType selectedOption,
    Map<TOptionType, TValue> branches, [
    TValue defaultValue,
  ]) {
    if (!branches.containsKey(selectedOption)) {
      return defaultValue;
    }

    return branches[selectedOption];
  }

//_______________________________________________________________________general
  FilterSwitch usedSwitch =
      new FilterSwitch(label: "Použité", left: "Ne", right: "Ano");
  FilterDropdown categoryDd =
      new FilterDropdown(hint: "Kategorie", options: Category.categories);

//__________________________________________________________________________bike
  FilterDropdown bikeBrandDd =
      new FilterDropdown(hint: "Značka kola", options: Bike.brand);
  FilterDropdown bikeTypeDd =
      new FilterDropdown(hint: "Typ kola", options: Bike.type);

//_________________________________________________________________________parts
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

  FilterDropdown partSaddleBrandDd =
      new FilterDropdown(hint: "Značka sedla", options: Saddle.brand);
  FilterDropdown partSaddleGenderDd =
      new FilterDropdown(hint: "Pohlaví", options: Saddle.gender);

  FilterDropdown partForkBrandDd =
      new FilterDropdown(hint: "Značka vidlice", options: Fork.brand);
  FilterDropdown partForkSizeDd =
      new FilterDropdown(hint: "Velikost", options: Fork.size);
  FilterSwitch partForkSuspensionSwitch = new FilterSwitch(
    label: "Typ",
    right: "Odpružená",
    left: "Pevná",
  );
  FilterDropdown partForkCompatibilityDd = new FilterDropdown(
      hint: "Kompatibilita", options: Fork.wheelCompatibility);
  FilterDropdown partForkMaterialDd =
      new FilterDropdown(hint: "Materiál", options: Fork.material);
  FilterDropdown partForkMaterialColDd = new FilterDropdown(
      hint: "Materiál sloupku", options: Fork.materialColumn);
  FilterSwitch partForkMoreSuspensionSwitch = new FilterSwitch(
    label: "Odpružení",
    right: "Vzduchové",
    left: "Pružinové",
  );

  FilterDropdown partBowdenTypeDd =
      new FilterDropdown(hint: "Typ", options: Bowden.type);

  FilterDropdown partBrakeBrandDd =
      new FilterDropdown(hint: "Značka", options: Brakes.brand);
  FilterDropdown partBrakeTypeDd =
      new FilterDropdown(hint: "Typ", options: Brakes.type);
  FilterSwitch partBrakeMoreDiscSwitch = new FilterSwitch(
    label: "Typ brzdy",
    left: "Hydraulická",
    right: "Mechanická",
  );
  FilterDropdown partBrakeMoreDiscDd =
      new FilterDropdown(hint: "Průměr kotouče", options: Brakes.discSize);
  FilterDropdown partBrakeMoreBlockDd = new FilterDropdown(
    hint: "Typ brzdy",
    options: Brakes.blockType,
  );

  FilterDropdown partTubeSizeDd =
      new FilterDropdown(hint: "Průměr ráfku", options: Tube.size);
  FilterDropdown partTubeTypeDd =
      new FilterDropdown(hint: "Typ ventilku", options: Tube.type);

  FilterDropdown partGripsTypeDd =
      new FilterDropdown(hint: "Typ", options: Grips.type);

  FilterDropdown partHeadsetTypeDd =
      new FilterDropdown(hint: "Typ", options: Headset.type);

  FilterDropdown partCassetteTypeDd =
      new FilterDropdown(hint: "Typ", options: Cassette.type);

  FilterDropdown partAxisTypeDd =
      new FilterDropdown(hint: "Typ", options: AxisCat.type);

  FilterDropdown partPedalsTypeDd =
      new FilterDropdown(hint: "Typ", options: Pedals.type);

  FilterDropdown partTiresSizeDd =
      new FilterDropdown(hint: "Velikost", options: Tire.size);
  FilterDropdown partTiresWidthDd =
      new FilterDropdown(hint: "Šířka", options: Tire.width);
  FilterDropdown partTiresBrandDd =
      new FilterDropdown(hint: "Značka", options: Tire.brand);
  FilterDropdown partTiresTypeDd =
      new FilterDropdown(hint: "Typ", options: Tire.type);
  FilterSwitch partTiresMaterialSwitch = new FilterSwitch(
    label: "Materiál",
    left: "Kevlar",
    right: "Drát",
  );

  FilterDropdown partStemTypeDd =
      new FilterDropdown(hint: "Typ", options: Stem.type);

  FilterDropdown partEbikeTypeDd =
      new FilterDropdown(hint: "Typ", options: EBikeComponents.type);

  FilterDropdown partRimSizeDd =
      new FilterDropdown(hint: "Velikost", options: Rim.type);

  FilterDropdown partFrameSizeDd =
      new FilterDropdown(hint: "Velikost", options: Frame.size);
  FilterDropdown partFrameForkDd =
      new FilterDropdown(hint: "Vidlice", options: Frame.fork);
  FilterDropdown partFrameTypeDd =
      new FilterDropdown(hint: "Typ", options: Frame.type);

  FilterDropdown partGearChangeTypeDd =
      new FilterDropdown(hint: "Typ", options: GearChanger.type);

  FilterDropdown partHandlebarsTypeDd =
      new FilterDropdown(hint: "Tvar", options: Handlebars.type);
  FilterDropdown partHandlebarsMaterialDd =
      new FilterDropdown(hint: "Materiál", options: Handlebars.material);
  FilterDropdown partHandlebarsWidthDd =
      new FilterDropdown(hint: "Šířka", options: Handlebars.width);
  FilterDropdown partHandlebarsSizeDd =
      new FilterDropdown(hint: "Průměr", options: Handlebars.size);

  FilterDropdown partSaddlePipeTypeDd =
      new FilterDropdown(hint: "Typ", options: SaddleTube.type);
  FilterDropdown partSaddlePipeLengthDd =
      new FilterDropdown(hint: "Délka", options: SaddleTube.length);
  FilterDropdown partSaddlePipeMaterialDd =
      new FilterDropdown(hint: "Materiál", options: SaddleTube.material);
  FilterDropdown partSaddlePipeSizeDd =
      new FilterDropdown(hint: "Průměr", options: SaddleTube.size);

  FilterDropdown partShockAbsTypeDd =
      new FilterDropdown(hint: "Typ", options: ShockAbs.type);

//_________________________________________________________________________other
  FilterDropdown otherTypeDd =
      new FilterDropdown(hint: "Typ", options: Category.other);

  FilterDropdown otherEBikeBrandDd =
      new FilterDropdown(hint: "Značka kola", options: EBike.brand);
  FilterSwitch otherEBikeTypeSwitch = new FilterSwitch(
    label: "Umístění motoru",
    right: "Středový",
    left: "Nábojový",
  );

  FilterDropdown otherTrainerBrandDd =
      new FilterDropdown(hint: "Značka tranažeru", options: Trainer.brand);
  FilterDropdown otherTrainerTypeDd =
      new FilterDropdown(hint: "Typ brždění", options: Trainer.brakes);

  FilterDropdown otherScooterBrandDd =
      new FilterDropdown(hint: "Značka koloběžky", options: Scooter.brand);
  FilterDropdown otherScooterSizeDd =
      new FilterDropdown(hint: "Velikost koleček", options: Scooter.size);
  FilterSwitch otherScooterCompSwitch = new FilterSwitch(
    label: "Počítač",
    left: "Ne",
    right: "Ano",
  );

//___________________________________________________________________accessories
  FilterDropdown accessoryTypeDd =
      new FilterDropdown(hint: "Typ doplňku", options: Category.accessories);

  FilterDropdown accessoryToolsTypeDd =
      new FilterDropdown(hint: "Typ", options: Tools.type);

  FilterDropdown accessoryMudguardsTypeDd =
      new FilterDropdown(hint: "Typ", options: Mudguard.type);
  FilterDropdown accessoryMudguardsSizeDd =
      new FilterDropdown(hint: "Velikost", options: Mudguard.size);

  FilterDropdown accessoryGlassesTypeDd =
      new FilterDropdown(hint: "Typ", options: Glasses.type);
  FilterDropdown accessoryGlassesGlassDd =
      new FilterDropdown(hint: "Skla", options: Glasses.glass);
  FilterDropdown accessoryGlassesGenderDd =
      new FilterDropdown(hint: "Pohlaví", options: Glasses.gender);
  FilterSwitch accessoryGlassesChangeGlassSwitch =
      new FilterSwitch(label: "Lze vyměnit skla", left: "Ano", right: "Ne");
  FilterSwitch accessoryGlassesChangeHolderSwitch =
      new FilterSwitch(label: "Lze vyměnit nosník", left: "Ano", right: "Ne");

  FilterDropdown accessoryCompsTypeDd =
      new FilterDropdown(hint: "Typ", options: Comp.type);

  FilterDropdown accessoryKidSaddleTypeDd =
      new FilterDropdown(hint: "Typ", options: KidSaddle.type);

  FilterSwitch accessoryHelmetTypeSwitch =
      new FilterSwitch(label: "Typ", left: "Dospělí", right: "Dětské");

  FilterDropdown accessoryPumpsTypeDd =
      new FilterDropdown(hint: "Typ", options: Pump.type);

  FilterDropdown accessoryBottleHolderTypeDd =
      new FilterDropdown(hint: "Typ", options: BottleHolder.type);

  FilterSwitch accessoryRackTypeSwitch =
      new FilterSwitch(label: "Typ", left: "Přední", right: "Zadní");
  FilterDropdown accessoryRackSizeDd =
      new FilterDropdown(hint: "Velikost", options: Rack.type);

  FilterDropdown accessoryClothesTypeDd =
      new FilterDropdown(hint: "Typ", options: Clothes.clothesType);
  FilterDropdown accessoryClothesGenderDd =
      new FilterDropdown(hint: "Pohlaví", options: Clothes.gender);
  FilterDropdown accessoryClothesSizeDd =
      new FilterDropdown(hint: "Velikost", options: Clothes.size);

  FilterDropdown accessoryBootsTypeDd =
      new FilterDropdown(hint: "Typ", options: Boots.type);
  FilterDropdown accessoryBootsSizeDd =
      new FilterDropdown(hint: "Velikost", options: Boots.size);

  FilterSwitch accessoryLightLightSwitch =
      new FilterSwitch(label: "Typ", left: "Přední", right: "Zadní");

  FilterDropdown accessoryLockTypeDd =
      new FilterDropdown(hint: "Typ", options: Lock.type);

  FilterSwitch accessoryCarRackTypeSwitch =
      new FilterSwitch(label: "Typ", left: "Na střechu", right: "Na tažné");
}
