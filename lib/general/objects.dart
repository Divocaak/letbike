export 'categories.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  //String dateEnd;
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
      //this.dateEnd,
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
        //json["dateEnd"],
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
          //key != "dateEnd" &&
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
        //"dateEnd": dateEnd,
        "imgs": imgs,
        "status": status,
        "soldTo": soldTo
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
  String username;
  int id;

  Chat(this.username, this.id);

  factory Chat.fromJson(Map<String, dynamic> json) {
    return Chat(json["username"], int.parse(json["id"]));
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
  User loggedUser;
  Map<String, String>? filters;
  AddItemData? addItemData;

  AddItemFiltersArgs(this.loggedUser, this.filters, this.addItemData);
}

class AddItemData {
  String name;
  String desc;
  String price;
  List<Asset> imgs;

  AddItemData(this.name, this.desc, this.price, this.imgs);
}
