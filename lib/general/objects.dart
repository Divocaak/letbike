export 'categories.dart';

import 'package:firebase_auth/firebase_auth.dart';

class Item {
  int id;
  String sellerId;
  String? soldTo;
  String name;
  String? description;
  int price;
  String dateStart;
  String? dateEnd;
  String imgs;
  int status;
  Map<String, dynamic>? itemParams;

  Item(
      this.id,
      this.sellerId,
      this.soldTo,
      this.name,
      this.description,
      this.price,
      this.dateStart,
      this.dateEnd,
      this.imgs,
      this.status,
      this.itemParams);

  factory Item.fromJson(Map<String, dynamic> json) => Item(
      int.parse(json["id"]),
      json["sellerId"],
      json["soldTo"],
      json["name"],
      json["description"],
      int.parse(json["price"]),
      json["dateStart"],
      json["dateEnd"],
      json["imgs"],
      int.parse(json["status"]),
      json["params"]);
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

class ChatUsersa {
  Item item;
  User userA;
  int userB;

  ChatUsersa(this.item, this.userA, this.userB);
}

class Rating {
  int value;
  String text;
  String dateAdded;

  Rating(this.value, this.text, this.dateAdded);

  factory Rating.fromJson(Map<String, dynamic> json) =>
      Rating(int.parse(json["val"]), json["text"], json["date"]);
}

class Article {
  int id;
  String name;
  String dateAdded;

  Article(this.id, this.name, this.dateAdded);

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(int.parse(json["id"]), json["name"], json["dateAdded"]);
  }
}
