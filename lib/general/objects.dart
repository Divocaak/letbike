export 'categories.dart';

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
  bool myMessage;
  String message;
  int img;
  String imgPath;

  Message(this.myMessage, this.message, this.img, this.imgPath);

  factory Message.fromJson(Map<String, dynamic> json) => Message(
      json["isMyMessage"],
      json["message"],
      int.parse(json["img"]),
      (json["imgPath"] + json["message"].hashCode.toString()));
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

  factory Article.fromJson(Map<String, dynamic> json) =>
      Article(int.parse(json["id"]), json["name"], json["dateAdded"]);
}
