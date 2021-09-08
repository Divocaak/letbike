import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart';
import 'package:letbike/general/objects.dart';
import 'package:letbike/db/remoteSettings.dart';
import 'package:letbike/db/dbUploadImage.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class DatabaseItem {
  static Future<String> createItem(Item item, List<Asset> images) async {
    DatabaseUploadImage.uploadImages(
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
          passParamsToDb(item.itemParams),
      headers: <String, String>{
        'Content-Type': 'application/json;charset=UTF-8'
      },
      /* body: jsonEncode(item.toJson()) */
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception("Can't add item");
    }
  }

  static Future<List<Item>> getAllItems(int status, String userId,
      Map<String, String> itemParams, String soldTo) async {
    final Response response = await get(
        Uri.encodeFull(url +
            "itemGetAll.php/?id=" +
            userId +
            "&&status=" +
            status.toString() +
            "&&soldTo=" +
            soldTo +
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
}

String passParamsToDb(Map<String, String> itemParams) {
  String returnStr = "";
  itemParams.forEach((key, value) => returnStr += "&&" + key + "=" + value);
  return returnStr;
}
