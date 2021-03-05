import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;

/* class DatabaseServices {
  Future addItem(int sellerId, String name, String description, double price,
      int score, int paid, DateTime dateEnd, String imgs, int status) async {
    final conn = await MySqlConnection.connect(ConnectionSettings(
        host: '10.0.2.2', port: 3306, user: 'root', db: 'letbike'));

    await conn.query(
        'INSERT INTO item (seller_id, name, description, price, score, paid, date_end, imgs, status) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)',
        [
          sellerId,
          name,
          description,
          price,
          score,
          paid,
          dateEnd,
          imgs,
          status
        ]);

    await conn.close();
  }

  Future<String> getItem(String id) async {
    final conn = await MySqlConnection.connect(ConnectionSettings(
        host: '10.0.2.2', port: 3306, user: 'root', db: 'letbike'));

    List<Item> itemList = [];
    var results = await conn.query(
        'SELECT seller_id, name, description, price, score, paid, date_end, imgs, status FROM item WHERE id = ' +
            id);
    for (var row in results) {
      itemList.add(new Item(row[0], row[1], row[2], row[3], row[4], row[5],
          row[6].toString(), row[7], row[8]));
    }
    await conn.close();

    return jsonEncode(itemList);
  }
} */

class DatabaseServices {
  /* Future<List<Item>> */ getItems() async {
    String url = 'http://10.0.2.2/projects/letbike/getParts.php';

    var res = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});

    return res.body;

    /* var itemsJson = jsonDecode(res.body);
    List dynList =
        itemsJson.map((partJson) => Item.fromJson(partJson)).toList();
    List<Item> itemList = dynList.map((s) => s as Item).toList();

    print("asd");
    print(itemList[0].dateEnd); */

    //return itemList;
  }
}

class Item {
  int sellerId;
  String name;
  String description;
  double price;
  int score;
  int paid;
  String dateEnd;
  String imgs;
  int status;

  Item(this.sellerId, this.name, this.description, this.price, this.score,
      this.paid, this.dateEnd, this.imgs, this.status);

  Map toJson() => {
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

  factory Item.fromJson(dynamic json) {
    return Item(
        json["sellerId"] as int,
        json["name"] as String,
        json["description"] as String,
        json["price"] as double,
        json["score"] as int,
        json["paid"] as int,
        json["dateEnd"] as String,
        json["imgs"] as String,
        json["status"] as int);
  }
}
