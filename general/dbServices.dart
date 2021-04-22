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

  static Future<List<Article>> getAllArticles() async {
    final Response response = await get(
        Uri.encodeFull(url + "articleGetAll.php"),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8'
        });
    if (response.statusCode == 200) {
      if (response.body == "[]") {
        return null;
      } else {
        final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
        return parsed
            .map<Article>((article) => Article.fromJson(article))
            .toList();
      }
    } else {
      throw Exception("Can't get articles");
    }
  }

  static Future<String> getArticle(int id) async {
    var response = await get(
        Uri.encodeFull(url + 'articles/' + id.toString() + '/article.md'),
        headers: {"Accept": "application/json;charset=UTF-8"});
    return Utf8Decoder().convert(response.body.codeUnits);
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
      int status, String userId, ItemParams itemParams, String soldTo) async {
    final Response response = await get(
        Uri.encodeFull(url +
            "itemGetAll.php/?id=" +
            userId +
            "&&status=" +
            status.toString() +
            "&&soldTo=" +
            soldTo +
            "&&" +
            passParamsToDb(itemParams)),
        headers: {"Accept": "application/json;charset=UTF-8"});
    print(response.body);
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

  static Future<String> setRating(
      int userId, double ratingVal, String ratingText) async {
    final Response response = await post(
      url +
          "ratingSet.php/?" +
          "&&userId=" +
          userId.toString() +
          "&&ratingVal=" +
          ratingVal.toString() +
          "&&ratingText=" +
          ratingText,
      headers: <String, String>{
        'Content-Type': 'application/json;charset=UTF-8'
      },
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception("Can't add rating");
    }
  }

  static Future<List<Rating>> getRatings(int userId) async {
    final Response response = await get(
        Uri.encodeFull(url + "ratingGet.php/?userId=" + userId.toString()),
        headers: {"Accept": "application/json;charset=UTF-8"});
    if (response.statusCode == 200) {
      if (response.body == "[]") {
        return null;
      } else {
        final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
        return parsed.map<Rating>((rating) => Rating.fromJson(rating)).toList();
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
      int seller, int buyer, int itemId) async* {
    while (true) {
      await Future.delayed(Duration.zero);
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
  return "used=" +
      itemParams.params["used"].toString() +
      "&&selectedCategory=" +
      itemParams.params["selectedCategory"].toString() +
      "&&bikeBrand=" +
      itemParams.params["bikeBrand"].toString() +
      "&&bikeType=" +
      itemParams.params["bikeType"].toString() +
      "&&selectedParts=" +
      itemParams.params["selectedParts"].toString() +
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
      "&&forkSuspension=" +
      itemParams.params["forkSuspension"].toString() +
      "&&forkSuspensionType=" +
      itemParams.params["forkSuspensionType"].toString() +
      "&&forkWheelCoompatibility=" +
      itemParams.params["forkWheelCoompatibility"].toString() +
      "&&forkMaterial=" +
      itemParams.params["forkMaterial"].toString() +
      "&&forkMaterialColumn=" +
      itemParams.params["forkMaterialColumn"].toString() +
      "&&selectedAccessories=" +
      itemParams.params["selectedAccessories"].toString() +
      "&&selectedOther=" +
      itemParams.params["selectedOther"].toString() +
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
      "&&brakeType=" +
      itemParams.params["brakeType"].toString() +
      "&&brakeBrand=" +
      itemParams.params["brakeBrand"].toString() +
      "&&brakeDiscType=" +
      itemParams.params["brakeDiscType"].toString() +
      "&&brakeDiscSize=" +
      itemParams.params["brakeDiscSize"].toString() +
      "&&brakeBlockType=" +
      itemParams.params["brakeBlockType"].toString() +
      "&&tireSize=" +
      itemParams.params["tireSize"].toString() +
      "&&tireWidth=" +
      itemParams.params["tireWidth"].toString() +
      "&&tireBrand=" +
      itemParams.params["tireBrand"].toString() +
      "&&tireType=" +
      itemParams.params["tireType"].toString() +
      "&&tireMaterial=" +
      itemParams.params["tireMaterial"].toString() +
      "&&tubeSize=" +
      itemParams.params["tubeSize"].toString() +
      "&&tubeType=" +
      itemParams.params["tubeType"].toString() +
      "&&frameSize=" +
      itemParams.params["frameSize"].toString() +
      "&&frameFork=" +
      itemParams.params["frameFork"].toString() +
      "&&frameType=" +
      itemParams.params["frameType"].toString() +
      "&&handlebarType=" +
      itemParams.params["handlebarType"].toString() +
      "&&handlebarMaterial=" +
      itemParams.params["handlebarMaterial"].toString() +
      "&&handlebarWidth=" +
      itemParams.params["handlebarWidth"].toString() +
      "&&handlebarSize=" +
      itemParams.params["handlebarSize"].toString() +
      "&&saddleTubeTube=" +
      itemParams.params["saddleTubeTube"].toString() +
      "&&saddleTubeLength=" +
      itemParams.params["saddleTubeLength"].toString() +
      "&&saddleTubeMaterial=" +
      itemParams.params["saddleTubeMaterial"].toString() +
      "&&saddleTubeSize=" +
      itemParams.params["saddleTubeSize"].toString() +
      "&&stemType=" +
      itemParams.params["stemType"].toString() +
      "&&axisType=" +
      itemParams.params["axisType"].toString() +
      "&&cassetteType=" +
      itemParams.params["cassetteType"].toString() +
      "&&shockAbsType=" +
      itemParams.params["shockAbsType"].toString() +
      "&&gearChangeType=" +
      itemParams.params["gearChangeType"].toString() +
      "&&pedalsType=" +
      itemParams.params["pedalsType"].toString() +
      "&&rimSize=" +
      itemParams.params["rimSize"].toString() +
      "&&gripsType=" +
      itemParams.params["gripsType"].toString() +
      "&&eBikeComponentsType=" +
      itemParams.params["eBikeComponentsType"].toString() +
      "&&headsetType=" +
      itemParams.params["headsetType"].toString() +
      "&&bowdenType=" +
      itemParams.params["bowdenType"].toString() +
      "&&clothesType=" +
      itemParams.params["clothesType"].toString() +
      "&&clothesClothes=" +
      itemParams.params["clothesClothes"].toString() +
      "&&clothesGender=" +
      itemParams.params["clothesGender"].toString() +
      "&&clothesSize=" +
      itemParams.params["clothesSize"].toString() +
      "&&bootsType=" +
      itemParams.params["bootsType"].toString() +
      "&&bootsSize=" +
      itemParams.params["bootsSize"].toString() +
      "&&helmetType=" +
      itemParams.params["helmetType"].toString() +
      "&&compType=" +
      itemParams.params["compType"].toString() +
      "&&glassType=" +
      itemParams.params["glassType"].toString() +
      "&&glassGlass=" +
      itemParams.params["glassGlass"].toString() +
      "&&glassGender=" +
      itemParams.params["glassGender"].toString() +
      "&&glassGlassChange=" +
      itemParams.params["glassGlassChange"].toString() +
      "&&glassHolderChange=" +
      itemParams.params["glassHolderChange"].toString() +
      "&&kidSaddleType=" +
      itemParams.params["kidSaddleType"].toString() +
      "&&bottleHolderType=" +
      itemParams.params["bottleHolderType"].toString() +
      "&&rackType=" +
      itemParams.params["rackType"].toString() +
      "&&rackSize=" +
      itemParams.params["rackSize"].toString() +
      "&&carRackType=" +
      itemParams.params["carRackType"].toString() +
      "&&toolType=" +
      itemParams.params["toolType"].toString() +
      "&&pumpType=" +
      itemParams.params["pumpType"].toString() +
      "&&lightType=" +
      itemParams.params["lightType"].toString() +
      "&&mudguardType=" +
      itemParams.params["mudguardType"].toString() +
      "&&mudguardSize=" +
      itemParams.params["mudguardSize"].toString() +
      "&&lockType=" +
      itemParams.params["lockType"].toString();
}
