class Category {
  int selectedCategory;
  int selectedAccessory;
  int selectedPart;
  int selectedOther;

  Category(this.selectedCategory, this.selectedAccessory, this.selectedPart,
      this.selectedOther);

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
  ];

  static List<String> other = ["E-Bike", "Tranažery", "Koloběžky"];
}

class Bike {
  int selectedType;
  int selectedBrand;

  Bike(this.selectedType, this.selectedBrand);

  static List<String> type = [
    "Horská kola",
    "Silniční kola",
    "Celoodpružené", // bez odpružení
    "Enduro",
    "Elektrokola", // +elektro info
    "Dětská kola",
    "Krosová/Trekingová kola",
    "Gravel/Cyklokros",
    "Historická kola",
    "Retro kola",
    "Dámská kola",
    "Městská kola",
    "Sjezdová kola",
    "Bmx kola", //konec
    "Dirtová kola",
    "Trenažéry", // custom(zátěž)
    "Koloběžky", // custom
    "Odrážedla", // custom(jako koloběžky)
    "Dráhová kola",
    "Singlespeed", // custom(if my dobrý -> jako koloběžky)
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

class Wheel {
  int selectedBrand;
  int selectedSize;
  int selectedMaterial;
  bool selectedSpokes;
  bool selectedType;
  int selectedAxis;
  bool selectedBrakesType;
  bool selectedBrakesDisc;
  bool selectedCassette;
  int selectedNut;
  int selectedCompatibility;

  Wheel(
      this.selectedBrand,
      this.selectedSize,
      this.selectedMaterial,
      this.selectedSpokes,
      this.selectedType,
      this.selectedAxis,
      this.selectedBrakesType,
      this.selectedBrakesDisc,
      this.selectedCassette,
      this.selectedNut,
      this.selectedCompatibility);

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

  static List<String> material = ["Karbon", "Hlíník", "ocel"];

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
  int selectedBrand;
  int selectedCompatibility;
  int selectedMaterial;
  int selectedAxis;

  Cranks(this.selectedBrand, this.selectedCompatibility, this.selectedMaterial,
      this.selectedAxis);

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
  int selectedBrand;
  int selectedNumOfSpeeds;

  Converter(this.selectedBrand, this.selectedNumOfSpeeds);

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
  int selectedBrand;
  int selectedGender;

  Saddle(this.selectedBrand, this.selectedGender);

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
  int selectedBrand;
  int selectedSize;
  bool selectedSuspensionType;
  bool selectedSuspension;
  int selectedWheelCoompatibility;
  int selectedMaterial;
  int selectedMaterialColumn;

  Fork(
      this.selectedBrand,
      this.selectedSize,
      this.selectedSuspensionType,
      this.selectedSuspension,
      this.selectedWheelCoompatibility,
      this.selectedMaterial,
      this.selectedMaterialColumn);

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

class EBike {
  int selectedBrand;
  bool selectedMotorPos;

  EBike(this.selectedBrand, this.selectedMotorPos);

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
  int selectedBrand;
  int selectedBrakes;

  Trainer(this.selectedBrand, this.selectedBrakes);

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
  int selectedBrand;
  int selectedSize;
  bool selectedComputer;

  Scooter(this.selectedBrand, this.selectedSize, this.selectedComputer);

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
