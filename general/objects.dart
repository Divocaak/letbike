class Item {
  int id;
  int sellerId;
  String name;
  String description;
  double price;
  int score;
  int paid;
  String dateStart;
  String dateEnd;
  String imgs;
  int status;
  ItemParams itemParams;

  Item(
      this.id,
      this.sellerId,
      this.name,
      this.description,
      this.price,
      this.score,
      this.paid,
      this.dateStart,
      this.dateEnd,
      this.imgs,
      this.status,
      this.itemParams);

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      int.parse(json["id"]),
      int.parse(json["sellerId"]),
      json["name"],
      json["description"],
      double.parse(json["price"]),
      int.parse(json["score"]),
      int.parse(json["paid"]),
      json["dateStart"],
      json["dateEnd"],
      json["imgs"],
      int.parse(json["status"]),
      new ItemParams({
        "used": int.parse(json["used"]),
        "selectedCategory": int.parse(json["selectedCategory"]),
        "selectedParts": int.parse(json["selectedParts"]),
        "selectedAccessories": int.parse(json["selectedAccessories"]),
        "selectedOther": int.parse(json["selectedOther"]),
        "bikeType": int.parse(json["bikeType"]),
        "bikeBrand": int.parse(json["bikeBrand"]),
        "wheelBrand": int.parse(json["wheelBrand"]),
        "wheelSize": int.parse(json["wheelSize"]),
        "wheelMaterial": int.parse(json["wheelMaterial"]),
        "wheeldSpokes": int.parse(json["wheeldSpokes"]),
        "wheeldType": int.parse(json["wheeldType"]),
        "wheelAxis": int.parse(json["wheelAxis"]),
        "wheeldBrakesType": int.parse(json["wheeldBrakesType"]),
        "wheeldBrakesDisc": int.parse(json["wheeldBrakesDisc"]),
        "wheeldCassette": int.parse(json["wheeldCassette"]),
        "wheelNut": int.parse(json["wheelNut"]),
        "wheelCompatibility": int.parse(json["wheelCompatibility"]),
        "cranksBrand": int.parse(json["cranksBrand"]),
        "cranksCompatibility": int.parse(json["cranksCompatibility"]),
        "cranksMaterial": int.parse(json["cranksMaterial"]),
        "cranksAxis": int.parse(json["cranksAxis"]),
        "converterBrand": int.parse(json["converterBrand"]),
        "converterNumOfSpeeds": int.parse(json["converterNumOfSpeeds"]),
        "saddleBrand": int.parse(json["saddleBrand"]),
        "saddleGender": int.parse(json["saddleGender"]),
        "forkBrand": int.parse(json["forkBrand"]),
        "forkSize": int.parse(json["forkSize"]),
        "forkSuspensionType": int.parse(json["forkSuspensionType"]),
        "forkSuspension": int.parse(json["forkSuspension"]),
        "forkWheelCoompatibility": int.parse(json["forkWheelCoompatibility"]),
        "forkMaterial": int.parse(json["forkMaterial"]),
        "forkMaterialColumn": int.parse(json["forkMaterialColumn"]),
        "eBikeBrand": int.parse(json["eBikeBrand"]),
        "eBikeMotorPos": int.parse(json["eBikeMotorPos"]),
        "trainerBrand": int.parse(json["trainerBrand"]),
        "trainerBrakes": int.parse(json["trainerBrakes"]),
        "scooterBrand": int.parse(json["scooterBrand"]),
        "scooterSize": int.parse(json["scooterSize"]),
        "scooterComputer": int.parse(json["scooterComputer"]),
      }),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "sellerId": sellerId,
        "name": name,
        "description": description,
        "price": price,
        "score": score,
        "paid": paid,
        "dateStart": dateStart,
        "dateEnd": dateEnd,
        "imgs": imgs,
        "status": status,
        "used": itemParams.params["used"],
        "selectedCategory": itemParams.params["selectedCategory"],
        "selectedParts": itemParams.params["selectedParts"],
        "selectedAccessories": itemParams.params["selectedAccessories"],
        "selectedOther": itemParams.params["selectedOther"],
        "bikeType": itemParams.params["bikeType"],
        "bikeBrand": itemParams.params["bikeBrand"],
        "wheelBrand": itemParams.params["wheelBrand"],
        "wheelSize": itemParams.params["wheelSize"],
        "wheelMaterial": itemParams.params["wheelMaterial"],
        "wheeldSpokes": itemParams.params["wheeldSpokes"],
        "wheeldType": itemParams.params["wheeldType"],
        "wheelAxis": itemParams.params["wheelAxis"],
        "wheeldBrakesType": itemParams.params["wheeldBrakesType"],
        "wheeldBrakesDisc": itemParams.params["wheeldBrakesDisc"],
        "wheeldCassette": itemParams.params["wheeldCassette"],
        "wheelNut": itemParams.params["wheelNut"],
        "wheelCompatibility": itemParams.params["wheelCompatibility"],
        "cranksBrand": itemParams.params["cranksBrand"],
        "cranksCompatibility": itemParams.params["cranksCompatibility"],
        "cranksMaterial": itemParams.params["cranksMaterial"],
        "cranksAxis": itemParams.params["cranksAxis"],
        "converterBrand": itemParams.params["converterBrand"],
        "converterNumOfSpeeds": itemParams.params["converterNumOfSpeeds"],
        "saddleBrand": itemParams.params["saddleBrand"],
        "saddleGender": itemParams.params["saddleGender"],
        "forkBrand": itemParams.params["forkBrand"],
        "forkSize": itemParams.params["forkSize"],
        "forkSuspensionType": itemParams.params["forkSuspensionType"],
        "forkSuspension": itemParams.params["forkSuspension"],
        "forkWheelCoompatibility": itemParams.params["forkWheelCoompatibility"],
        "forkMaterial": itemParams.params["forkMaterial"],
        "forkMaterialColumn": itemParams.params["forkMaterialColumn"],
        "eBikeBrand": itemParams.params["eBikeBrand"],
        "eBikeMotorPos": itemParams.params["eBikeMotorPos"],
        "trainerBrand": itemParams.params["trainerBrand"],
        "trainerBrakes": itemParams.params["trainerBrakes"],
        "scooterBrand": itemParams.params["scooterBrand"],
        "scooterSize": itemParams.params["scooterSize"],
        "scooterComputer": itemParams.params["scooterComputer"],
      };
}

class ItemParams {
  ItemParams(this.params);

  Map<String, int> params = {
    "used": 0,
    "selectedCategory": 0,
    "bikeBrand": 0,
    "bikeType": 0,
    "selectedParts": 0,
    "wheelBrand": 0,
    "wheelSize": 0,
    "wheelMaterial": 0,
    "wheeldSpokes": 0,
    "wheeldType": 0,
    "wheelAxis": 0,
    "wheeldBrakesType": 0,
    "wheeldBrakesDisc": 0,
    "wheeldCassette": 0,
    "wheelNut": 0,
    "wheelCompatibility": 0,
    "cranksBrand": 0,
    "cranksCompatibility": 0,
    "cranksMaterial": 0,
    "cranksAxis": 0,
    "converterBrand": 0,
    "converterNumOfSpeeds": 0,
    "saddleBrand": 0,
    "saddleGender": 0,
    "forkBrand": 0,
    "forkSize": 0,
    "forkSuspension": 0,
    "forkSuspensionType": 0,
    "forkWheelCoompatibility": 0,
    "forkMaterial": 0,
    "forkMaterialColumn": 0,
    "selectedAccessories": 0,
    "selectedOther": 0,
    "eBikeBrand": 0,
    "eBikeMotorPos": 0,
    "trainerBrand": 0,
    "trainerBrakes": 0,
    "scooterBrand": 0,
    "scooterSize": 0,
    "scooterComputer": 0
  };
}

class User {
  int id;
  String username;
  String email;
  String password;
  int score;
  int phone;
  String fName;
  String lName;
  String addressA;
  String addressB;
  String addressC;
  int postal;
  int status;

  User(
      this.id,
      this.username,
      this.email,
      this.password,
      this.score,
      this.phone,
      this.fName,
      this.lName,
      this.addressA,
      this.addressB,
      this.addressC,
      this.postal,
      this.status);

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        int.parse(json["id"]),
        json["username"],
        json["email"],
        json["password"],
        int.parse(json["score"]),
        int.parse(json["phone"]),
        json["fName"],
        json["lName"],
        json["addressA"],
        json["addressB"],
        json["addressC"],
        int.parse(json["postal"]),
        int.parse(json["status"]));
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "email": email,
        "password": password,
        "score": score,
        "phone": phone,
        "fName": fName,
        "lName": lName,
        "addressA": addressA,
        "addressB": addressB,
        "addressC": addressC,
        "postal": postal,
        "status": status
      };
}

class Message {
  int from;
  int to;
  String message;

  Message(this.from, this.to, this.message);

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
        int.parse(json["from_id"]), int.parse(json["to_id"]), json["message"]);
  }

  Map<String, dynamic> toJson() =>
      {"from_id": from, "to_id": to, "message": message};
}

class Chat {
  String email;
  String username;

  Chat(this.email, this.username);

  factory Chat.fromJson(Map<String, dynamic> json) {
    return Chat(json["email"], json["username"]);
  }
}

class ItemInfo {
  Item item;
  User me;

  ItemInfo(this.item, this.me);
}

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

class HomeArguments {
  User user;
  ItemParams filters;

  HomeArguments(this.user, this.filters);
}
