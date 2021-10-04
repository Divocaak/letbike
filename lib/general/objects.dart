export 'categories.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';

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
  Map<String, String> itemParams;
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
        "", //json["dateEnd"],
        json["imgs"],
        int.parse(json["status"]),
        getParams(json),
        int.parse(json["soldTo"]));
  }

  static Map<String, String> getParams(Map<String, dynamic> json) {
    Map<String, String> mapToRet = {};
    json.forEach((key, value) {
      if (key != "id" &&
          key != "sellerId" &&
          key != "name" &&
          key != "description" &&
          key != "price" &&
          key != "score" &&
          key != "paid" &&
          key != "dateStart" &&
          key != "dateEnd" &&
          key != "imgs" &&
          key != "param" &&
          key != "status" &&
          key != "soldTo") {
        mapToRet[key] = value;
      }
    });

    return mapToRet;
  }

  Map<String, dynamic> toasfasJson() => {
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
        "soldTo": soldTo,
        /* "used": itemParams.params["used"],
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
        "lockType": itemParams.params["lockType"], */
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

class AddItemFiltersArgs {
  HomeArguments args;
  AddItemData addItemData;

  AddItemFiltersArgs(this.args, this.addItemData);
}

class HomeArguments {
  User user;
  Map<String, String> filters;

  HomeArguments(this.user, this.filters);
}

class AddItemData {
  String name;
  String desc;
  String price;
  List<Asset> imgs;

  AddItemData(this.name, this.desc, this.price, this.imgs);
}
