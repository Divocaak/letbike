class Category {
  static List<String> categories = ['Kola', 'Komponenty', 'Doplňky', 'Ostatní'];

  static List<String> parts = [
    "Zapletená kola",
    "Kliky",
    "Převodníky",
    "Sedla",
    "Vidlice",
    "Bowdeny a lanka",
    "Brzdy",
    "Duše",
    "Gripy a omotávky",
    "Hlavová složení",
    "Kazety a pastorky",
    "Náboje a osy",
    "Pedály",
    "Pláště/Galusky",
    "Představce",
    "Příslušenství na elektrokola",
    "Ráfky",
    "Rámy",
    "Řazení",
    "Řídítka",
    "Sedlovky",
    "Tlumiče",
    "Jiné"
  ];

  static List<String> accessories = [
    "Blatníky",
    "Brašny/batohy",
    "Brýle",
    "Cyklocomputery",
    "Dětské sedačky",
    "Helmy",
    "Hustilky",
    "Košíky na lahev",
    "Nářadí",
    "Nosič na kolo",
    "Nosiče",
    "Oblečení",
    "Obuv",
    "Poukazy",
    "Světla",
    "Výživa",
    "Zámky",
    "Nosiče na auto"
  ];

  static List<String> other = ["E-Bike", "Tranažery", "Koloběžky"];
}

class Bike {
  static List<String> type = [
    "Horská kola",
    "Silniční kola",
    "Celoodpružené",
    "Enduro",
    "Elektrokola",
    "Dětská kola",
    "Krosová/Trekingová kola",
    "Gravel/Cyklokros",
    "Historická kola",
    "Retro kola",
    "Dámská kola",
    "Městská kola",
    "Sjezdová kola",
    "Bmx kola",
    "Dirtová kola",
    "Trenažéry",
    "Koloběžky",
    "Odrážedla",
    "Dráhová kola",
    "Singlespeed",
    "Fatbike",
    "Skládací kola",
    "Cargobike",
    "Jiné"
  ];

  static List<String> brand = [
    "4Ever",
    "Acra",
    "Amulet",
    "Apache",
    "Author",
    "Bianchi",
    "Cannonadale",
    "CTM",
    "Cube",
    "Denver",
    "Dino",
    "Fox",
    "Galaxy",
    "Ghost",
    "Giant",
    "GT",
    "Kellys",
    "Koss",
    "KTM",
    "Lapierre",
    "Leader",
    "Liberty",
    "Maxbike",
    "Merida",
    "MMR",
    "MRX",
    "Norco",
    "Olpran",
    "Orbea",
    "Rock Machine",
    "Scott",
    "Scud",
    "Specialized",
    "Stevens",
    "Superior",
    "Trek",
    "Jiné"
  ];
}

//======================================================================================
//==============================================================================PARTS===
//======================================================================================

class Wheel {
  static List<String> brand = [
    "Author",
    "Bontrager",
    "Campagnolo",
    "Dema",
    "DT Swiss",
    "Easton",
    "FFWD",
    "Force",
    "FSA",
    "Fulcrum",
    "Giant",
    "Kellys",
    "Lightweight",
    "Mach",
    "Mavic",
    "Miche",
    "Novatech",
    "Remerx",
    "Rodi",
    "Shimano",
    "Specialized",
    "Sram",
    "Veltec",
    "Vision Tech",
    "XLC",
    "Zipp",
  ];

  static List<String> size = [
    "12’",
    "14’",
    "16’",
    "20’",
    "23’",
    "24’",
    "25’",
    "26’",
    "27,5’",
    "28’",
    "29’"
  ];

  static List<String> material = ["Karbon", "Hlíník", "Ocel"];

  static List<String> axis = [
    "Pevná 20 mm",
    "Pevná 15 mm",
    "Pevná 12mm",
    "Rychloupínák",
    "Na matice"
  ];

  static List<String> nut = ["Shimano", "Sram", "Campagnolo"];

  static List<String> compatibility = [
    "12 rychlostí",
    "11 rychlostí",
    "10 rychlostí",
    "9 rychlostí",
    "8 rychlostí",
    "7 rychlostí",
    "6 rychlostí",
    "1 rychlost"
  ];
}

class Cranks {
  static List<String> brand = [
    "Aerozine",
    "Campagnolo",
    "Force",
    "FSA",
    "Prowhell",
    "Race Face",
    "Rotor",
    "Shimano",
    "SR Suntour",
    "Sram",
    "Sturney Archer",
    "Sunrace",
    "Truvativ",
    "Jiné"
  ];

  static List<String> compatibility = [
    "1 Převodník",
    "2 Převodníky",
    "3 Převodníky"
  ];

  static List<String> material = ["Karbon", "Ocel", "Hliník"];

  static List<String> axis = ["DUB", "29 mm", "24 mm", "BB30", "4hran", "Isis"];
}

class Converter {
  static List<String> brand = [
    "absoluteBLACK",
    "Aerozine",
    "BBB",
    "Campagnolo",
    "Da Bomb",
    "E*13",
    "Fireeye",
    "Force",
    "FSA",
    "Gebhardt",
    "Manobike",
    "MAX1",
    "Prowheel",
    "Renthal",
    "Ridea",
    "Rotor",
    "Shaman Racing",
    "Shimano",
    "SR Suntour",
    "Sram",
    "Stronglight",
    "Total BMX",
    "Truvativ",
    "Jiné"
  ];

  static List<String> numOfSpeeds = ["1", "2", "7", "8", "9", "10", "11", "12"];
}

class Saddle {
  static List<String> brand = [
    "Author",
    "BBB",
    "Bontrager",
    "Brooks",
    "DDK",
    "Ergon",
    "Fabric",
    "Felt",
    "Fizik",
    "Force",
    "Giant",
    "Kellys",
    "Pro",
    "Prologo",
    "San Marco",
    "Selle Bassano",
    "Selle Italia",
    "Selle Monte Grappa",
    "Selle Royal",
    "Selle San Marco",
    "Selle SMP",
    "Specialized",
    "Sportourer",
    "Velo",
    "Wittkop",
    "WTB",
    "XLC",
    "Jiné"
  ];

  static List<String> gender = ["Unisex", "Pánské", "Dámské", "Dětské"];
}

class Fork {
  static List<String> brand = [
    "Cane Creek",
    "Cannondale",
    "Cyklo Žitný",
    "DVO suspension",
    "Éclat",
    "Felt",
    "Force",
    "Fox",
    "GT",
    "Macneil",
    "Magura",
    "Manitou",
    "Marzocchi",
    "Maxbike",
    "MRX",
    "M-Wave",
    "Noxon",
    "NS Bikes",
    "Odyssey",
    "Öhlins",
    "Pells",
    "Rock Shox",
    "RST",
    "Spinner",
    "SR Suntour",
    "Total BMX",
    "TWN",
    "WTP",
    "Zoom",
    "Jiné"
  ];

  static List<String> size = [
    "12’",
    "14’",
    "16’",
    "20’",
    "23’",
    "24’",
    "25’",
    "26’",
    "27,5’",
    "28’",
    "29’"
  ];

  static List<String> wheelCompatibility = [
    "Rychloupínák",
    "Pevná osa",
    "Matice"
  ];

  static List<String> material = ["Ocel", "Karbon", "Hliník", "Titan"];

  static List<String> materialColumn = ["Karbon", "Ocel", "Hliník"];
}

class Brakes {
  static List<String> brand = [
    "Avi",
    "Berti",
    "Btwi",
    "Haye",
    "Proma",
    "Savoy",
    "Shiman",
    "Sra",
    "Tektr",
    "Van Ryse",
    "Workshop"
  ];

  static List<String> type = ["kotoučová", "špalková", "bubnová"];

  static List<String> discSize = ["140mm", "160mm", "180mm", "203mm", "jiné"];
  static List<String> blockType = ["V-Brake", "silniční", "BMX", "Cantilever"];
}

class Tire {
  static List<String> size = [
    "10",
    "12",
    "14",
    "16",
    "18",
    "20",
    "24",
    "26",
    "27.5",
    "28",
    "29",
    "jiné",
  ];

  static List<String> width = [
    "30C",
    "32C",
    "35C",
    "38C",
    "jiné",
  ];

  static List<String> brand = [
    "Maxxis",
    "Kenda",
    "Continental",
    "Mitas",
    "Force",
    "Bontrager",
    "CST",
    "Donnelly",
    "Elite",
    "Giant",
    "Challenge",
    "Mavic",
    "Michelin",
    "Onza",
    "Panaracer",
    "Pirelli",
    "Point",
    "Ritchey",
    "Rubena",
    "Schwalbe",
    "Tacx",
    "Tufo",
    "Vittoria",
    "WTB",
    "ZIPP",
    "jiné",
  ];

  static List<String> type = [
    "Silniční",
    "MTB Horské",
    "Crossová",
    "Dětské",
    "Galusky",
    "Velopásky",
  ];
}

class Tube {
  static List<String> size = [
    "10",
    "12",
    "14",
    "16",
    "18",
    "20",
    "24",
    "26",
    "27.5",
    "28",
    "29",
    "jiné",
  ];

  static List<String> type = [
    "AV (auto/moto ventilek)",
    "FV (galuskový ventilek)",
    "DV (velo ventilek)",
  ];
}

class Frame {
  static List<String> size = [
    "14 - 15",
    "15 - 16",
    "16 - 17",
    "17 - 18",
    "18 - 19",
    "19 - 20",
    "20 - 21",
    "21 - 22",
    "22 - 23",
    "23 - 24",
    "48 - 50",
    "50 - 51",
    "51 - 52",
    "52 - 54",
    "54 - 56",
    "56 - 58",
    "58 - 60",
    "60 - 62",
    "62 - 64",
    "jiné",
  ];

  static List<String> fork = [
    "24",
    "26",
    "27.5",
    "28",
    "29",
    "jiné",
  ];

  static List<String> type = [
    "Horské MTB",
    "Krosové",
    "Cyklokrosové",
    "Silniční",
    "Freeride, Downhill",
    "Dětské",
    "BMX",
  ];
}

class Handlebars {
  static List<String> type = [
    "Berany",
    "rovná",
    "vlaštovky",
    "Bullhorn",
    "BMX",
    "Aerodynamická",
    "Cruiser",
    "Butterfly",
    "Moustache",
  ];

  static List<String> material = [
    "karbon",
    "hliníkové",
    "ocel",
  ];

  static List<String> width = [
    "36",
    "38",
    "40",
    "42",
    "44",
    "46",
    "jiné",
  ];

  static List<String> size = [
    "25.4",
    "31.8",
    "jiné",
  ];
}

class SaddleTube {
  static List<String> type = [
    "Horské MTB",
    "silníční",
    "odpružené",
    "teleskopické",
  ];

  static List<String> length = [
    "330mm",
    "350mm",
    "400mm",
    "jiné",
  ];

  static List<String> material = ["karbon", "hliník", "ocel"];

  static List<String> size = [
    "30.9",
    "31.6",
    "ostatní",
  ];
}

class Stem {
  static List<String> type = [
    "Ahead průměr řidítek 31,8mm",
    "Ahead průměr řidítek 25,4mm",
    "Ahead průměr řidítek 35mm",
    "Ahead ostatní Ø",
    "Ostatní",
  ];
}

class AxisCat {
  static List<String> type = [
    "Přední náboje",
    "Zadní náboje",
    "Volnoběžné náboje",
    "Vícerychlostní náboje",
    "Rychloupínáky a Osy",
    "Pastorky",
    "Osy",
    "Příslušenství",
  ];
}

class Cassette {
  static List<String> type = [
    "12 rychlostní",
    "11 rychlostní",
    "10 rychlostní",
    "9 rychlostní",
    "8 rychlostní",
    "7 rychlostní",
    "6 rychlostní",
    "5 rychlostní",
    "Volnokolečka",
    "Kryty",
    "Příslušenství",
  ];
}

class ShockAbs {
  static List<String> type = [
    "vzduchové",
    "pružinové",
    "Pružiny",
    "Vložky vymezovací",
    "Náhradní díly",
  ];
}

class GearChanger {
  static List<String> type = [
    "Elektronické řazení eTap",
    "Elektronické řazení Di2",
    "páčkové",
    "otočné",
    "silniční",
    "Set řazení a brzdy",
    "Set řazení a brzdy silniční",
    "Set řazení a brzdy Di2",
  ];
}

class Pedals {
  static List<String> type = [
    "klasické",
    "nášlapné ",
    "dětské",
    "Kufry pro nášlapné pedály",
    "Příslušenství",
  ];
}

class Rim {
  static List<String> type = [
    '29"',
    '28"',
    '27,5"',
    '26"',
    '24"',
    '20"',
    '16"',
    '12"',
    'ostatní',
  ];
}

class Grips {
  static List<String> type = [
    "Gripy Lock-On",
    "Gripy klasické",
    "Gripy ergonomické",
    "Gripy dětské",
    "Gripy s rohy",
    "ostatní",
    "Omotávky",
    "Záslepky do řídítek",
    "Příslušenství",
  ];
}

class EBikeComponents {
  static List<String> type = [
    "Baterie",
    "Nabíječky",
    "Displeje a ovladače",
  ];
}

class Headset {
  static List<String> type = [
    "Ahead",
    "závitové",
    "integrované",
    "Kroužky pod hlavové složení",
    "Příslušenství",
  ];
}

class Bowden {
  static List<String> type = [
    "Lanka brzdící",
    "Lanka řadící",
    "Bowdeny",
    "Koncovky lanka",
    "Konvovky bowdenu",
    "Kompletní sady",
    "Příslušenství",
  ];
}

//======================================================================================
//==============================================================================ACCESORY
//======================================================================================

class Clothes {
  static List<String> clothesType = [
    "Cyklistické dresy",
    "Elastické kraťasy krátké",
    "Elastické kraťasy 3/4",
    "Elastické kalhoty dlouhé",
    "Volné kraťasy",
    "Volné kraťasy 3/4",
    "Volné kalhoty dlouhé",
    "Cyklistické bundy a větrovky",
    "Cyklistické vesty",
    "chrániče kotníků",
    "chrániče loktů",
    "chrániče kolen",
    "oblečení",
    "Čepice",
    "Ponožky",
    "Návleky",
  ];

  static List<String> gender = [
    "Pánské",
    "Dámské",
    "Dětské",
  ];

  static List<String> size = [
    "XS",
    "S",
    "M",
    "L",
    "XL",
    "XXL",
  ];
}

class Boots {
  static List<String> type = [
    "Horské",
    "Silniční",
    "Turistická",
  ];

  static List<String> size = [
    "36",
    "37",
    "38",
    "39",
    "40",
    "41",
    "42",
    "43",
    "44",
    "45",
    "46",
    "47",
    "48",
    "49",
    "jiné",
  ];
}

class Helmet {
  static List<String> type = ["Dospělí", "Dětské"];
}

class Comp {
  static List<String> type = ["Bezdrátové", "Drátové", "Cyklonavigace"];
}

class Glasses {
  static List<String> type = [
    "Závodní",
    "Sportovní",
    "Lifestyle",
  ];

  static List<String> glass = [
    "fotochromatická",
    "keramická",
    "polarizační",
  ];

  static List<String> gender = [
    "Pánské",
    "Dámské",
    "Dětské",
  ];
}

class KidSaddle {
  static List<String> type = [
    "Na řidítka",
    "Na rám",
    "Pod sedlo",
    "Vodící tyče",
    "Vozík za kolo",
  ];
}

class BottleHolder {
  static List<String> type = [
    "Do rámu",
    "Pod sedlo",
    "Na řídítka",
  ];
}

class Rack {
  static List<String> type = [
    "20´",
    "24´",
    "26´",
    "28´",
    "29´",
  ];
}

class Tools {
  static List<String> type = [
    "Na cesty",
    "Ochrana rámu",
    "středové klíče",
    "pedálové klíče",
    "stahováky",
    "ostatní ",
    "Maziva a čistidla",
    "Měřidla",
    "Nýtovače",
    "Ostatní",
  ];
}

class Pump {
  static List<String> type = [
    "Dílenské",
    "Cestovní",
    "Na vidlice",
    "Jednorázové bombičky",
    "Náhradní díly",
  ];
}

class Mudguard {
  static List<String> type = [
    "Přední",
    "Zadní",
    "Sada",
  ];

  static List<String> size = [
    "12’",
    "14’",
    "16’",
    "20’",
    "24’",
    "26’",
    "28’",
    "29’",
  ];
}

class Lock {
  static List<String> type = [
    "Lankové",
    "Řetězové",
    "Skládací",
    "U-zámky",
    "Kódové",
  ];
}

//======================================================================================
//==============================================================================OTHER===
//======================================================================================

class EBike {
  static List<String> brand = [
    "Crussis",
    "Haibike",
    "Apache",
    "Rock Machine",
    "Leader Fox",
    "Jiné"
  ];
}

class Trainer {
  static List<String> brand = [
    "HMS",
    "Tunturi",
    "BH Fitness",
    "InSPORTline",
    "Spokey",
    "Jiné"
  ];

  static List<String> brakes = ["magnetický", "indukční", "páskový"];
}

class Scooter {
  static List<String> size = [
    "přední 26’ a zadní 20’",
    "přední 16’ a zadní 12’",
    "přední 12’ a zadní 12’",
    "přední 16’ a zadní 16’",
    "přední 20’ a zadní 20’",
    "přední 20’ a zadní 16’",
    "přední 28’ a zadní 20’",
    "přední 20’ a zadní 12’",
    "přední 28’ a zadní 18’",
    "přední 14’ a zadní 12’",
    "přední 26’ a zadní 16’",
    "přední 28’ a zadní 28’",
    "přední 22’ a zadní 12’",
    "přední 230 mm, zadní 180 mm",
  ];

  static List<String> brand = [
    "AO",
    "Bestial Wolf",
    "Blazer",
    "Blunt",
    "Crisp",
    "Crussis",
    "District",
    "Dominator",
    "Enero",
    "Ethic",
    "Frenzy",
    "Galaxy",
    "Globber",
    "Grit",
    "Hudora",
    "Chilli",
    "InSPORTline",
    "JD Bug",
    "Kickbike",
    "Kostka",
    "Longway",
    "Lucky",
    "Madd Gear",
    "Master",
    "Meteor",
    "Mibo",
    "Micro",
    "Milly Mally",
    "Mondo",
    "Morxes",
    "Movino",
    "Nils",
    "North Scooters",
    "Oxelo",
    "Panda",
    "Raven",
    "Razor",
    "Root Industries",
    "R-Sport",
    "Scoot & Ride",
    "Sedco",
    "Schildkrot",
    "Slamm",
    "Smoby",
    "Spartan",
    "Spokey",
    "Stiga",
    "Street Surfing",
    "Striker",
    "Tempish",
    "Worker",
    "Yedoo",
    "Jiné"
  ];
}

class ParamRowOpt {
  String name;
  List<String> options;

  ParamRowOpt(this.name, this.options);
}

class ParamRow {
  static Map<String, ParamRowOpt> params = {
    "usedSwitch": ParamRowOpt("Použité", ["Ne", "Ano"]),
    "categoryDd": ParamRowOpt("Kategorie", Category.categories),
    "bikeBrandDd": ParamRowOpt("Značka kola", Bike.brand),
    "bikeTypeDd": ParamRowOpt("Typ kola", Bike.type),
    "partTypeDd": ParamRowOpt("Typ komponentu", Category.parts),
    "partWheelBrandDd": ParamRowOpt("Značka výpletu", Wheel.brand),
    "partWheelSizeDd": ParamRowOpt("Velikost kola", Wheel.size),
    "partWheelMaterialDd": ParamRowOpt("Materiál", Wheel.material),
    "partWheelSpokesSwitch": ParamRowOpt("Typ drátů", ["Kulaté", "Ploché"]),
    "partWheelTypeSwitch": ParamRowOpt("Provedení náboje", ["Přední", "Zadní"]),
    "partWheelAxisDd": ParamRowOpt("Provedení osy", Wheel.axis),
    "partWheelBrakesSwitch": ParamRowOpt("Typ brzd", ["Kotoučové", "V-Brzdy"]),
    "partWheelMoreDiscBrakesSwitch":
        ParamRowOpt("Uchycení disku", ["CenterLock", "6 děr"]),
    "partWheelCassetteSwitch":
        ParamRowOpt("Provedení kazety", ["Závit", "Ořech"]),
    "partWheelMoreNutDd": ParamRowOpt("Značka ořechu", Wheel.nut),
    "partWheelCompatibilityDd":
        ParamRowOpt("Kompatibilita", Wheel.compatibility),
    "partCranksBrandDd": ParamRowOpt("Značka", Cranks.brand),
    "partCranksCompatibilityDd":
        ParamRowOpt("Kompatibilita", Cranks.compatibility),
    "partCranksMaterialDd": ParamRowOpt("Materiál", Cranks.material),
    "partCranksAxisDd": ParamRowOpt("Osa", Cranks.axis),
    "partConverterBrandDd": ParamRowOpt("Značka", Converter.brand),
    "partConverterNumOfSpeedsDd":
        ParamRowOpt("Počet rychlostí", Converter.numOfSpeeds),
    "partSaddleBrandDd": ParamRowOpt("Značka", Saddle.brand),
    "partSaddleGenderDd": ParamRowOpt("Pohlaví", Saddle.gender),
    "partForkBrandDd": ParamRowOpt("Značka", Fork.brand),
    "partForkSizeDd": ParamRowOpt("Velikost", Fork.size),
    "partForkSuspensionSwitch":
        ParamRowOpt("Typ vidlice", ["Odpružená", "Pevná"]),
    "partForkMoreSuspensionSwitch":
        ParamRowOpt("Odpružení", ["Vzduchové", "Pružinové"]),
    "partForkCompatibilityDd":
        ParamRowOpt("Kompatibilita", Fork.wheelCompatibility),
    "partForkMaterialDd": ParamRowOpt("Materiál", Fork.material),
    "partForkMaterialColDd":
        ParamRowOpt("Materiál sloupku", Fork.materialColumn),
    "partBowdenTypeDd": ParamRowOpt("Typ", Bowden.type),
    "partBrakeBrandDd": ParamRowOpt("Značka", Brakes.brand),
    "partBrakeTypeDd": ParamRowOpt("Typ", Brakes.type),
    "partBrakeMoreDiscSwitch":
        ParamRowOpt("Typ", ["Hydraulická", "Mechanická"]),
    "partBrakeMoreDiscDd": ParamRowOpt("Velikost", Brakes.discSize),
    "partBrakeMoreBlockDd": ParamRowOpt("Typ", Brakes.blockType),
    "partTubeSizeDd": ParamRowOpt("Velikost", Tube.size),
    "partTubeTypeDd": ParamRowOpt("Typ", Tube.type),
    "partGripsTypeDd": ParamRowOpt("Typ", Grips.type),
    "partHeadsetTypeDd": ParamRowOpt("Typ", Headset.type),
    "partCassetteTypeDd": ParamRowOpt("Typ", Cassette.type),
    "partAxisTypeDd": ParamRowOpt("Typ", AxisCat.type),
    "partPedalsTypeDd": ParamRowOpt("Typ", Pedals.type),
    "partTiresSizeDd": ParamRowOpt("Velikost", Tire.size),
    "partTiresWidthDd": ParamRowOpt("Šířka", Tire.width),
    "partTiresBrandDd": ParamRowOpt("Značka", Tire.brand),
    "partTiresTypeDd": ParamRowOpt("Typ", Tire.type),
    "partTiresMaterialSwitch": ParamRowOpt("MMateriál", ["Kevlar", "Drát"]),
    "partStemTypeDd": ParamRowOpt("Typ", Stem.type),
    "partEbikeTypeDd": ParamRowOpt("Typ", EBikeComponents.type),
    "partRimSizeDd": ParamRowOpt("Velikost", Rim.type),
    "partFrameSizeDd": ParamRowOpt("Velikost", Frame.size),
    "partFrameForkDd": ParamRowOpt("Vidlice", Frame.fork),
    "partFrameTypeDd": ParamRowOpt("Typ", Frame.type),
    "partGearChangeTypeDd": ParamRowOpt("Typ", GearChanger.type),
    "partHandlebarsTypeDd": ParamRowOpt("Typ", Handlebars.type),
    "partHandlebarsMaterialDd": ParamRowOpt("Materiál", Handlebars.material),
    "partHandlebarsWidthDd": ParamRowOpt("Šířka", Handlebars.width),
    "partHandlebarsSizeDd": ParamRowOpt("Průměr", Handlebars.size),
    "partSaddlePipeTypeDd": ParamRowOpt("Typ", SaddleTube.type),
    "partSaddlePipeLengthDd": ParamRowOpt("Délka", SaddleTube.length),
    "partSaddlePipeMaterialDd": ParamRowOpt("Materiál", SaddleTube.material),
    "partSaddlePipeSizeDd": ParamRowOpt("Průměr", SaddleTube.size),
    "partShockAbsTypeDd": ParamRowOpt("Typ", ShockAbs.type),
    "accessoryTypeDd": ParamRowOpt("Typ doplňku", Category.accessories),
    "accessoryMudguardsTypeDd": ParamRowOpt("Typ", Mudguard.type),
    "accessoryMudguardsSizeDd": ParamRowOpt("Velikost", Mudguard.size),
    "accessoryGlassesTypeDd": ParamRowOpt("Typ", Glasses.type),
    "accessoryGlassesGlassDd": ParamRowOpt("Skla", Glasses.glass),
    "accessoryGlassesGenderDd": ParamRowOpt("Pohlaví", Glasses.gender),
    "accessoryGlassesChangeGlassSwitch":
        ParamRowOpt("Vyměnitelná skla", ["Ano", "Ne"]),
    "accessoryGlassesChangeHolderSwitch":
        ParamRowOpt("Vyměnitelný nosník", ["Ano", "Ne"]),
    "accessoryCompsTypeDd": ParamRowOpt("Typ", Comp.type),
    "accessoryKidSaddleTypeDd": ParamRowOpt("Typ", KidSaddle.type),
    "accessoryHelmetTypeSwitch": ParamRowOpt("Typ", Helmet.type),
    "accessoryPumpsTypeDd": ParamRowOpt("Typ", Pump.type),
    "accessoryBottleHolderTypeDd": ParamRowOpt("Typ", BottleHolder.type),
    "accessoryToolsTypeDd": ParamRowOpt("Typ", Tools.type),
    "accessoryRackTypeSwitch": ParamRowOpt("Typ", Rack.type),
    "accessoryRackSizeDd": ParamRowOpt("Velikost", ["Přední", "Zadní"]),
    "accessoryClothesTypeDd": ParamRowOpt("Typ", Clothes.clothesType),
    "accessoryClothesGenderDd": ParamRowOpt("Pohlaví", Clothes.gender),
    "accessoryClothesSizeDd": ParamRowOpt("Velikost", Clothes.size),
    "accessoryBootsTypeDd": ParamRowOpt("Typ", Boots.type),
    "accessoryBootsSizeDd": ParamRowOpt("Velikost", Boots.size),
    "accessoryLightLightSwitch": ParamRowOpt("Typ", ["Přední", "Zadní"]),
    "accessoryLockTypeDd": ParamRowOpt("Typ", Lock.type),
    "accessoryCarRackTypeSwitch":
        ParamRowOpt("Typ", ["Na střechu", "Na tažné"]),
    "otherTypeDd": ParamRowOpt("Jiné", Category.other),
    "otherEBikeBrandDd": ParamRowOpt("Značka", EBike.brand),
    "otherEBikeTypeSwitch":
        ParamRowOpt("Umístění motoru", ["Středový", "Nábojový"]),
    "otherTrainerBrandDd": ParamRowOpt("Značka", Trainer.brand),
    "otherTrainerTypeDd": ParamRowOpt("Typ brždění", Trainer.brakes),
    "otherScooterBrandDd": ParamRowOpt("Značka", Scooter.brand),
    "otherScooterSizeDd": ParamRowOpt("Velikost koleček", Scooter.size),
    "otherScooterCompSwitch": ParamRowOpt("Počítač", ["Ne", "Ano"]),
  };
}
