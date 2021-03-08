import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart';

class DatabaseServices {
  static const String url = 'http://10.0.2.2/projects/letbike/';
  static Future<Item> createItem(Item item) async {
    final Response response = await post(url,
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8'
        },
        body: jsonEncode(item.toJson()));

    if (response.statusCode == 200) {
      return Item.fromJson(json.decode(response.body));
    } else {
      throw Exception("Can't load author");
    }
  }

  static Future<List<Item>> getAllItems() async {
    final Response response = await get(Uri.encodeFull(url + "getParts.php"),
        headers: {"Accept": "application/json"});
    if (response.statusCode == 200) {
      final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
      return parsed.map<Item>((item) => Item.fromJson(item)).toList();
    } else {
      throw Exception("Can't load author");
    }
  }
}

class Item {
  int id;
  int sellerId;
  String name;
  String description;
  double price;
  int score;
  int paid;
  String dateEnd;
  String imgs;
  int status;

  Item(this.id, this.sellerId, this.name, this.description, this.price,
      this.score, this.paid, this.dateEnd, this.imgs, this.status);

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
        int.parse(json["id"]),
        int.parse(json["sellerId"]),
        json["name"],
        json["description"],
        double.parse(json["price"]),
        int.parse(json["score"]),
        int.parse(json["paid"]),
        json["dateEnd"],
        json["imgs"],
        int.parse(json["status"]));
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "sellerId": sellerId,
        "name": name,
        "description": description,
        "price": price,
        "score": score,
        "paid": paid,
        "dateEnd": dateEnd,
        "imgs": imgs,
        "status": status
      };
}
