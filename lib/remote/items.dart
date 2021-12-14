import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:http/http.dart';
import 'package:letbike/general/objects.dart';
import 'package:letbike/remote/settings.dart';
import 'package:letbike/remote/dbUploadImage.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';

class RemoteItems {
  static String url = scriptsUrl + 'item/';

  static Future<bool> createItem(String userId, String name, String desc,
      String price, Map<String, String> params, List<Asset> images) async {
    DatabaseUploadImage.uploadImages(
        images, "items", userId + "-" + name.hashCode.toString());

    final Response response = await post(
        Uri.parse(Uri.encodeFull(url + "itemSet.php")),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json;charset=UTF-8'
        },
        body: jsonEncode({
          "userId": userId,
          "name": name,
          "desc": desc,
          "price": price,
          "params": params,
          "imgs": images.length
        }));

    return response.statusCode == 200 && response.body != "ERROR"
        ? true
        : false;
  }

  // WAITING nejdřív add
  static Future<List<Item>>? getAllItems(int status, String userId,
      Map<String, String> itemParams, String soldTo) async {
    final Response response = await post(
        Uri.parse(Uri.encodeFull(url + "itemGetAll.php")),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json;charset=UTF-8"
        },
        body: jsonEncode({
          "userId": userId,
          "status": status,
          "params": itemParams,
          "soldTo": soldTo
        }));
    if (response.statusCode == 200) {
      final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
      return parsed.map<Item>((item) => Item.fromJson(item)).toList();
    } else {
      throw Exception("Can't get items");
    }
  }

  static Future<String> updateItemStatus(
      int itemId, int newStatus, int soldTo) async {
    final Response response = await get(
        Uri.parse(Uri.encodeFull(url +
            "itemUpdateStatus.php/?id=" +
            itemId.toString() +
            "&&status=" +
            newStatus.toString() +
            "&&soldTo=" +
            soldTo.toString())),
        headers: {"Accept": "application/json;charset=UTF-8"});
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception("Can't get items");
    }
  }
}

// URGENT nepoužívat
String passParamsToDb(Map<String, String> itemParams) {
  String returnStr = "";
  itemParams.forEach((key, value) => returnStr += "&&" + key + "=" + value);
  return returnStr;
}
