import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart';
import 'objects.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class DatabaseServices {
  static const String url = 'http://10.0.2.2/projects/letbike/';
  static const String uploadEndPoint = url + 'uploadImage.php';

  static uploadImages(
      List<Asset> images, String imgFolder, String folderIdentificator) async {
    var request = MultipartRequest(
        'POST', Uri.parse('http://10.0.2.2/projects/letbike/uploadImage.php/'));

    for (int i = 0; i < images.length; i++) {
      var byteData = await images[i].getByteData();
      List<int> imageData = byteData.buffer.asUint8List();

      request.fields["img" + i.toString()] = base64Encode(imageData);
    }

    request.fields["imgCount"] = images.length.toString();
    request.fields["imgFolder"] = imgFolder;
    request.fields["folderIdentificator"] = folderIdentificator;

    var res = await request.send();
    print(await res.stream.bytesToString());
    if (res.statusCode != 200) {
      print("error");
    }
  }

  static Future<String> createItem(Item item, List<Asset> images) async {
    uploadImages(
        images, "items", (item.name.hashCode + item.sellerId).toString());

    final Response response = await post(
        url +
            "itemSet.php/?" +
            "&&seller_id=" +
            item.sellerId.toString() +
            "&&name=" +
            item.name +
            "&&description=" +
            item.description +
            "&&price=" +
            item.price.toString() +
            "&&images=" +
            images.length.toString() +
            "&&" +
            passParamsToDb(item.itemParams),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8'
        },
        body: jsonEncode(item.toJson()));

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception("Can't add item");
    }
  }

  static Future<List<Item>> getAllItems(
      int status, String userId, ItemParams itemParams, int soldTo) async {
    final Response response = await get(
        Uri.encodeFull(url +
            "itemGetAll.php/?id=" +
            userId +
            "&&status=" +
            status.toString() +
            "&&soldTo=" +
            soldTo.toString() +
            "&&" +
            passParamsToDb(itemParams)),
        headers: {"Accept": "application/json;charset=UTF-8"});
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

  static Future<String> updateItemStatus(
      int itemId, int newStatus, int soldTo) async {
    final Response response = await get(
        Uri.encodeFull(url +
            "itemUpdateStatus.php/?id=" +
            itemId.toString() +
            "&&status=" +
            newStatus.toString() +
            "&&soldTo=" +
            soldTo.toString()),
        headers: {"Accept": "application/json;charset=UTF-8"});
    if (response.statusCode == 200) {
      return response.body;
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

  static Future<User> getUserInfo(int id) async {
    final Response response = await get(
        Uri.encodeFull(url + "userInfo.php?id=" + id.toString()),
        headers: {"Accept": "application/json;charset=UTF-8"});
    if (response.statusCode == 200) {
      final Map parsed = jsonDecode(response.body);
      return User.fromJson(parsed);
    } else {
      throw Exception("Can't login user");
    }
  }

  static Future<List<Message>> getMessagesBetween(
      int seller, int buyer, int itemId) async {
    final Response response = await get(
        Uri.encodeFull(url +
            "messageGet.php/?from=" +
            seller.toString() +
            "&&to=" +
            buyer.toString() +
            "&&itemId=" +
            itemId.toString()),
        headers: {"Accept": "application/json;charset=UTF-8"});
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
      Duration refreshTime, int seller, int buyer, int itemId) async* {
    while (true) {
      await Future.delayed(refreshTime);
      yield await getMessagesBetween(seller, buyer, itemId);
    }
  }

  static Future sendMessage(
      int from, int to, int itemId, String message, List<Asset> images) async {
    if (images.length != 0) {
      uploadImages(images, "messages",
          (from.toString() + to.toString() + message.hashCode.toString()));
    }

    String hasImg = images.length != 0 ? "1" : "0";
    final Response response = await get(
        Uri.encodeFull(url +
            "messageSet.php/?from=" +
            from.toString() +
            "&&to=" +
            to.toString() +
            "&&itemId=" +
            itemId.toString() +
            "&&message=" +
            message +
            "&&img=" +
            hasImg),
        headers: {"Accept": "application/json;charset=UTF-8"});
    if (response.statusCode == 200) {
      print("sent");
    } else {
      throw Exception("Something's wrong, I can feel it");
    }
  }

  static Future<List<Chat>> getChats(int itemId) async {
    final Response response = await get(
        Uri.encodeFull(url + "chatsGet.php/?itemId=" + itemId.toString()),
        headers: {"Accept": "application/json;charset=UTF-8"});
    if (response.statusCode == 200) {
      final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
      return parsed.map<Chat>((chat) => Chat.fromJson(chat)).toList();
    } else {
      throw Exception("Can't load chats");
    }
  }

  static Future<String> changeAccountDetails(
      String id, List<String> values, List<Asset> images) async {
    uploadImages(images, "users", id.toString());

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

String passParamsToDb(ItemParams itemParams) {
  return "selectedCategory=" +
      itemParams.params["selectedCategory"].toString() +
      "&&selectedParts=" +
      itemParams.params["selectedParts"].toString() +
      "&&selectedAccessories=" +
      itemParams.params["selectedAccessories"].toString() +
      "&&selectedOther=" +
      itemParams.params["selectedOther"].toString() +
      "&&bikeType=" +
      itemParams.params["bikeType"].toString() +
      "&&bikeBrand=" +
      itemParams.params["bikeBrand"].toString() +
      "&&wheelBrand=" +
      itemParams.params["wheelBrand"].toString() +
      "&&wheelSize=" +
      itemParams.params["wheelSize"].toString() +
      "&&wheelMaterial=" +
      itemParams.params["wheelMaterial"].toString() +
      "&&wheeldSpokes=" +
      itemParams.params["wheeldSpokes"].toString() +
      "&&wheeldType=" +
      itemParams.params["wheeldType"].toString() +
      "&&wheelAxis=" +
      itemParams.params["wheelAxis"].toString() +
      "&&wheeldBrakesType=" +
      itemParams.params["wheeldBrakesType"].toString() +
      "&&wheeldBrakesDisc=" +
      itemParams.params["wheeldBrakesDisc"].toString() +
      "&&wheeldCassette=" +
      itemParams.params["wheeldCassette"].toString() +
      "&&wheelNut=" +
      itemParams.params["wheelNut"].toString() +
      "&&wheelCompatibility=" +
      itemParams.params["wheelCompatibility"].toString() +
      "&&cranksBrand=" +
      itemParams.params["cranksBrand"].toString() +
      "&&cranksCompatibility=" +
      itemParams.params["cranksCompatibility"].toString() +
      "&&cranksMaterial=" +
      itemParams.params["cranksMaterial"].toString() +
      "&&cranksAxis=" +
      itemParams.params["cranksAxis"].toString() +
      "&&converterBrand=" +
      itemParams.params["converterBrand"].toString() +
      "&&converterNumOfSpeeds=" +
      itemParams.params["converterNumOfSpeeds"].toString() +
      "&&saddleBrand=" +
      itemParams.params["saddleBrand"].toString() +
      "&&saddleGender=" +
      itemParams.params["saddleGender"].toString() +
      "&&forkBrand=" +
      itemParams.params["forkBrand"].toString() +
      "&&forkSize=" +
      itemParams.params["forkSize"].toString() +
      "&&forkSuspensionType=" +
      itemParams.params["forkSuspensionType"].toString() +
      "&&forkSuspension=" +
      itemParams.params["forkSuspension"].toString() +
      "&&forkWheelCoompatibility=" +
      itemParams.params["forkWheelCoompatibility"].toString() +
      "&&forkMaterial=" +
      itemParams.params["forkMaterial"].toString() +
      "&&forkMaterialColumn=" +
      itemParams.params["forkMaterialColumn"].toString() +
      "&&eBikeBrand=" +
      itemParams.params["eBikeBrand"].toString() +
      "&&eBikeMotorPos=" +
      itemParams.params["eBikeMotorPos"].toString() +
      "&&trainerBrand=" +
      itemParams.params["trainerBrand"].toString() +
      "&&trainerBrakes=" +
      itemParams.params["trainerBrakes"].toString() +
      "&&scooterBrand=" +
      itemParams.params["scooterBrand"].toString() +
      "&&scooterSize=" +
      itemParams.params["scooterSize"].toString() +
      "&&scooterComputer=" +
      itemParams.params["scooterComputer"].toString() +
      "&&used=" +
      itemParams.params["used"].toString();
}
