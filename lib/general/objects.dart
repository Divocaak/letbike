export 'categories.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

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
  int soldTo;

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
      this.itemParams,
      this.soldTo);

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
          "brakeType": int.parse(json["brakeType"]),
          "brakeBrand": int.parse(json["brakeBrand"]),
          "brakeDiscType": int.parse(json["brakeDiscType"]),
          "brakeDiscSize": int.parse(json["brakeDiscSize"]),
          "brakeBlockType": int.parse(json["brakeBlockType"]),
          "tireSize": int.parse(json["tireSize"]),
          "tireWidth": int.parse(json["tireWidth"]),
          "tireBrand": int.parse(json["tireBrand"]),
          "tireType": int.parse(json["tireType"]),
          "tireMaterial": int.parse(json["tireMaterial"]),
          "tubeSize": int.parse(json["tubeSize"]),
          "tubeType": int.parse(json["tubeType"]),
          "frameSize": int.parse(json["frameSize"]),
          "frameFork": int.parse(json["frameFork"]),
          "frameType": int.parse(json["frameType"]),
          "handlebarType": int.parse(json["handlebarType"]),
          "handlebarMaterial": int.parse(json["handlebarMaterial"]),
          "handlebarWidth": int.parse(json["handlebarWidth"]),
          "handlebarSize": int.parse(json["handlebarSize"]),
          "saddleTubeType": int.parse(json["saddleTubeType"]),
          "saddleTubeLength": int.parse(json["saddleTubeLength"]),
          "saddleTubeMaterial": int.parse(json["saddleTubeMaterial"]),
          "saddleTubeSize": int.parse(json["saddleTubeSize"]),
          "stemType": int.parse(json["stemType"]),
          "axisType": int.parse(json["axisType"]),
          "cassetteType": int.parse(json["cassetteType"]),
          "shockAbsType": int.parse(json["shockAbsType"]),
          "gearChangeType": int.parse(json["gearChangeType"]),
          "pedalsType": int.parse(json["pedalsType"]),
          "rimSize": int.parse(json["rimSize"]),
          "gripsType": int.parse(json["gripsType"]),
          "eBikeComponentsType": int.parse(json["eBikeComponentsType"]),
          "headsetType": int.parse(json["headsetType"]),
          "bowdenType": int.parse(json["bowdenType"]),
          "clothesType": int.parse(json["clothesType"]),
          "clothesClothes": int.parse(json["clothesClothes"]),
          "clothesGender": int.parse(json["clothesGender"]),
          "clothesSize": int.parse(json["clothesSize"]),
          "bootsType": int.parse(json["bootsType"]),
          "bootsSize": int.parse(json["bootsSize"]),
          "helmetType": int.parse(json["helmetType"]),
          "compType": int.parse(json["compType"]),
          "glassType": int.parse(json["glassType"]),
          "glassGlass": int.parse(json["glassGlass"]),
          "glassGender": int.parse(json["glassGender"]),
          "glassGlassChange": int.parse(json["glassGlassChange"]),
          "glassHolderChange": int.parse(json["glassHolderChange"]),
          "kidSaddleType": int.parse(json["kidSaddleType"]),
          "bottleHolderType": int.parse(json["bottleHolderType"]),
          "rackType": int.parse(json["rackType"]),
          "rackSize": int.parse(json["rackSize"]),
          "carRackType": int.parse(json["carRackType"]),
          "toolType": int.parse(json["toolType"]),
          "pumpType": int.parse(json["pumpType"]),
          "lightType": int.parse(json["lightType"]),
          "mudguardType": int.parse(json["mudguardType"]),
          "mudguardSize": int.parse(json["mudguardSize"]),
          "lockType": int.parse(json["lockType"]),
        }),
        int.parse(json["soldTo"]));
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
        "soldTo": soldTo,
        "brakeType": itemParams.params["brakeType"],
        "brakeBrand": itemParams.params["brakeBrand"],
        "brakeDiscType": itemParams.params["brakeDiscType"],
        "brakeDiscSize": itemParams.params["brakeDiscSize"],
        "brakeBlockType": itemParams.params["brakeBlockType"],
        "tireSize": itemParams.params["tireSize"],
        "tireWidth": itemParams.params["tireWidth"],
        "tireBrand": itemParams.params["tireBrand"],
        "tireType": itemParams.params["tireType"],
        "tireMaterial": itemParams.params["tireMaterial"],
        "tubeSize": itemParams.params["tubeSize"],
        "tubeType": itemParams.params["tubeType"],
        "frameSize": itemParams.params["frameSize"],
        "frameFork": itemParams.params["frameFork"],
        "frameType": itemParams.params["frameType"],
        "handlebarType": itemParams.params["handlebarType"],
        "handlebarMaterial": itemParams.params["handlebarMaterial"],
        "handlebarWidth": itemParams.params["handlebarWidth"],
        "handlebarSize": itemParams.params["handlebarSize"],
        "saddleTubeType": itemParams.params["saddleTubeType"],
        "saddleTubeLength": itemParams.params["saddleTubeLength"],
        "saddleTubeMaterial": itemParams.params["saddleTubeMaterial"],
        "saddleTubeSize": itemParams.params["saddleTubeSize"],
        "stemType": itemParams.params["stemType"],
        "axisType": itemParams.params["axisType"],
        "cassetteType": itemParams.params["cassetteType"],
        "shockAbsType": itemParams.params["shockAbsType"],
        "gearChangeType": itemParams.params["gearChangeType"],
        "pedalsType": itemParams.params["pedalsType"],
        "rimSize": itemParams.params["rimSize"],
        "gripsType": itemParams.params["gripsType"],
        "eBikeComponentsType": itemParams.params["eBikeComponentsType"],
        "headsetType": itemParams.params["headsetType"],
        "bowdenType": itemParams.params["bowdenType"],
        "clothesType": itemParams.params["clothesType"],
        "clothesClothes": itemParams.params["clothesClothes"],
        "clothesGender": itemParams.params["clothesGender"],
        "clothesSize": itemParams.params["clothesSize"],
        "bootsType": itemParams.params["bootsType"],
        "bootsSize": itemParams.params["bootsSize"],
        "helmetType": itemParams.params["helmetType"],
        "compType": itemParams.params["compType"],
        "glassType": itemParams.params["glassType"],
        "glassGlass": itemParams.params["glassGlass"],
        "glassGender": itemParams.params["glassGender"],
        "glassGlassChange": itemParams.params["glassGlassChange"],
        "glassHolderChange": itemParams.params["glassHolderChange"],
        "kidSaddleType": itemParams.params["kidSaddleType"],
        "bottleHolderType": itemParams.params["bottleHolderType"],
        "rackType": itemParams.params["rackType"],
        "rackSize": itemParams.params["rackSize"],
        "carRackType": itemParams.params["carRackType"],
        "toolType": itemParams.params["toolType"],
        "pumpType": itemParams.params["pumpType"],
        "lightType": itemParams.params["lightType"],
        "mudguardType": itemParams.params["mudguardType"],
        "mudguardSize": itemParams.params["mudguardSize"],
        "lockType": itemParams.params["lockType"],
      };
}

class ItemParams {
  ItemParams(this.params);

  factory ItemParams.createEmpty() {
    Map<String, int> toReturn = {
      "used": -1,
      "selectedCategory": -1,
      "bikeBrand": -1,
      "bikeType": -1,
      "selectedParts": -1,
      "wheelBrand": -1,
      "wheelSize": -1,
      "wheelMaterial": -1,
      "wheeldSpokes": -1,
      "wheeldType": -1,
      "wheelAxis": -1,
      "wheeldBrakesType": -1,
      "wheeldBrakesDisc": -1,
      "wheeldCassette": -1,
      "wheelNut": -1,
      "wheelCompatibility": -1,
      "cranksBrand": -1,
      "cranksCompatibility": -1,
      "cranksMaterial": -1,
      "cranksAxis": -1,
      "converterBrand": -1,
      "converterNumOfSpeeds": -1,
      "saddleBrand": -1,
      "saddleGender": -1,
      "forkBrand": -1,
      "forkSize": -1,
      "forkSuspension": -1,
      "forkSuspensionType": -1,
      "forkWheelCoompatibility": -1,
      "forkMaterial": -1,
      "forkMaterialColumn": -1,
      "selectedAccessories": -1,
      "selectedOther": -1,
      "eBikeBrand": -1,
      "eBikeMotorPos": -1,
      "trainerBrand": -1,
      "trainerBrakes": -1,
      "scooterBrand": -1,
      "scooterSize": -1,
      "scooterComputer": -1,
      "brakeType": -1,
      "brakeBrand": -1,
      "brakeDiscType": -1,
      "brakeDiscSize": -1,
      "brakeBlockType": -1,
      "tireSize": -1,
      "tireWidth": -1,
      "tireBrand": -1,
      "tireType": -1,
      "tireMaterial": -1,
      "tubeSize": -1,
      "tubeType": -1,
      "frameSize": -1,
      "frameFork": -1,
      "frameType": -1,
      "handlebarType": -1,
      "handlebarMaterial": -1,
      "handlebarWidth": -1,
      "handlebarSize": -1,
      "saddleTubeType": -1,
      "saddleTubeLength": -1,
      "saddleTubeMaterial": -1,
      "saddleTubeSize": -1,
      "stemType": -1,
      "axisType": -1,
      "cassetteType": -1,
      "shockAbsType": -1,
      "gearChangeType": -1,
      "pedalsType": -1,
      "rimSize": -1,
      "gripsType": -1,
      "eBikeComponentsType": -1,
      "headsetType": -1,
      "bowdenType": -1,
      "clothesType": -1,
      "clothesClothes": -1,
      "clothesGender": -1,
      "clothesSize": -1,
      "bootsType": -1,
      "bootsSize": -1,
      "helmetType": -1,
      "compType": -1,
      "glassType": -1,
      "glassGlass": -1,
      "glassGender": -1,
      "glassGlassChange": -1,
      "glassHolderChange": -1,
      "kidSaddleType": -1,
      "bottleHolderType": -1,
      "rackType": -1,
      "rackSize": -1,
      "carRackType": -1,
      "toolType": -1,
      "pumpType": -1,
      "lightType": -1,
      "mudguardType": -1,
      "mudguardSize": -1,
      "lockType": -1,
    };
    return ItemParams(toReturn);
  }

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
    "scooterComputer": 0,
    "brakeType": 0,
    "brakeBrand": 0,
    "brakeDiscType": 0,
    "brakeDiscSize": 0,
    "brakeBlockType": 0,
    "tireSize": 0,
    "tireWidth": 0,
    "tireBrand": 0,
    "tireType": 0,
    "tireMaterial": 0,
    "tubeSize": 0,
    "tubeType": 0,
    "frameSize": 0,
    "frameFork": 0,
    "frameType": 0,
    "handlebarType": 0,
    "handlebarMaterial": 0,
    "handlebarWidth": 0,
    "handlebarSize": 0,
    "saddleTubeType": 0,
    "saddleTubeLength": 0,
    "saddleTubeMaterial": 0,
    "saddleTubeSize": 0,
    "stemType": 0,
    "axisType": 0,
    "cassetteType": 0,
    "shockAbsType": 0,
    "gearChangeType": 0,
    "pedalsType": 0,
    "rimSize": 0,
    "gripsType": 0,
    "eBikeComponentsType": 0,
    "headsetType": 0,
    "bowdenType": 0,
    "clothesType": 0,
    "clothesClothes": 0,
    "clothesGender": 0,
    "clothesSize": 0,
    "bootsType": 0,
    "bootsSize": 0,
    "helmetType": 0,
    "compType": 0,
    "glassType": 0,
    "glassGlass": 0,
    "glassGender": 0,
    "glassGlassChange": 0,
    "glassHolderChange": 0,
    "kidSaddleType": 0,
    "bottleHolderType": 0,
    "rackType": 0,
    "rackSize": 0,
    "carRackType": 0,
    "toolType": 0,
    "pumpType": 0,
    "lightType": 0,
    "mudguardType": 0,
    "mudguardSize": 0,
    "lockType": 0,
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
  int img;

  Message(this.from, this.to, this.message, this.img);

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(int.parse(json["from_id"]), int.parse(json["to_id"]),
        json["message"], int.parse(json["img"]));
  }

  Map<String, dynamic> toJson() =>
      {"from_id": from, "to_id": to, "message": message, "img": img};
}

class Chat {
  String email;
  String username;
  int id;

  Chat(this.email, this.username, this.id);

  factory Chat.fromJson(Map<String, dynamic> json) {
    return Chat(json["email"], json["username"], int.parse(json["id"]));
  }
}

class ChatUsers {
  ItemInfo itemInfo;
  User userA;
  int userB;

  ChatUsers(this.itemInfo, this.userA, this.userB);
}

class Rating {
  double ratingValue;
  String ratingText;

  Rating(this.ratingValue, this.ratingText);

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(double.parse(json["ratingVal"]), json["ratingText"]);
  }
}

class Article {
  int id;
  String title;
  String added;

  Article(this.id, this.title, this.added);

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(int.parse(json["id"]), json["title"], json["added"]);
  }
}

class ItemInfo {
  Item item;
  User me;

  ItemInfo(this.item, this.me);
}

class HomeArguments {
  User user;
  ItemParams filters;

  HomeArguments(this.user, this.filters);
}

class AddItemFiltersArgs {
  HomeArguments args;
  AddItemData addItemData;

  AddItemFiltersArgs(this.args, this.addItemData);
}

class AddItemData {
  String name;
  String desc;
  String price;
  List<Asset> imgs;

  AddItemData(this.name, this.desc, this.price, this.imgs);
}
