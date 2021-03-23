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
      throw Exception("Can't add item");
    }
  }

  static Future<List<Item>> getAllItems(String id) async {
    final Response response = await get(
        Uri.encodeFull(url + "getItems.php/?id=" + id),
        headers: {"Accept": "application/json"});
    if (response.statusCode == 200) {
      if (response.body == "[]") {
        return null;
      } else {
        final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
        return parsed.map<Item>((item) => Item.fromJson(item)).toList();
      }
    } else {
      throw Exception("Can't get items");
    }
  }

  static Future<String> registerUser(
      String username, String email, String password) async {
    final Response response = await get(
        Uri.encodeFull(url +
            "userRegister.php?username=" +
            username +
            "&&email=" +
            email +
            "&&password=" +
            password),
        headers: {"Accept": "application/json;charset=UTF-8"});
    if (response.statusCode == 200) {
      print(response.body);
      return response.body;
    } else {
      throw Exception("Can't register user");
    }
  }

  static Future<User> loginUser(String email, String password) async {
    final Response response = await get(
        Uri.encodeFull(
            url + "userLogin.php?email=" + email + "&&password=" + password),
        headers: {"Accept": "application/json;charset=UTF-8"});
    if (response.statusCode == 200) {
      if (response.body != "error") {
        final Map parsed = jsonDecode(response.body);
        return User.fromJson(parsed);
      } else {
        return User(-1, "", "", "", -1, -1, "", "", "", "", "", -1, -1);
      }
    } else {
      throw Exception("Can't login user");
    }
  }

  static Future<List<Message>> getMessagesBetween(
      int from, int to, int itemId) async {
    final Response response = await get(
        Uri.encodeFull(url +
            "messageGet.php/?from=" +
            from.toString() +
            "&&to=" +
            to.toString() +
            "&&itemId=" +
            itemId.toString()),
        headers: {"Accept": "application/json"});
    if (response.statusCode == 200) {
      final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
      return parsed
          .map<Message>((message) => Message.fromJson(message))
          .toList();
    } else {
      throw Exception("Can't load messages");
    }
  }

  static Stream<List<Message>> getMessages(
      Duration refreshTime, int from, int to, int itemId) async* {
    while (true) {
      await Future.delayed(refreshTime);
      yield await getMessagesBetween(from, to, itemId);
    }
  }

  static Future sendMessage(
      int from, int to, int itemId, String message) async {
    final Response response = await get(
        Uri.encodeFull(url +
            "messageSet.php/?from=" +
            from.toString() +
            "&&to=" +
            to.toString() +
            "&&itemId=" +
            itemId.toString() +
            "&&message=" +
            message),
        headers: {"Accept": "application/json"});
    if (response.statusCode == 200) {
      print("sent");
    } else {
      throw Exception("Something's wrong, I can feel it");
    }
  }

  static Future<List<Chat>> getChats(int itemId) async {
    final Response response = await get(
        Uri.encodeFull(url + "chatsGet.php/?itemId=" + itemId.toString()),
        headers: {"Accept": "application/json"});
    if (response.statusCode == 200) {
      final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
      return parsed.map<Chat>((chat) => Chat.fromJson(chat)).toList();
    } else {
      throw Exception("Can't load chats");
    }
  }

  static Future<String> changeAccountDetails(
      String id, List<String> values) async {
    final Response response = await get(
        Uri.encodeFull(url +
            "userChangeDetails.php/?id=" +
            id +
            "&&fName=" +
            values[0] +
            "&&lName=" +
            values[1] +
            "&&phone=" +
            values[2] +
            "&&addA=" +
            values[3] +
            "&&addB=" +
            values[4] +
            "&&addC=" +
            values[5] +
            "&&postal=" +
            values[6]),
        headers: {"Accept": "application/json;charset=UTF-8"});
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception("Can't register user");
    }
  }

  static Future<String> changePassword(String id, newPass, currPass) async {
    final Response response = await get(
        Uri.encodeFull(url +
            "userChangePassword.php/?id=" +
            id +
            "&&newPass=" +
            newPass +
            "&&currPass=" +
            currPass),
        headers: {"Accept": "application/json;charset=UTF-8"});
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception("Can't register user");
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
  String dateStart;
  String dateEnd;
  String imgs;
  int status;

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
      this.status);

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
        "dateStart": dateStart,
        "dateEnd": dateEnd,
        "imgs": imgs,
        "status": status
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
