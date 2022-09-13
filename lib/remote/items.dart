import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:http/http.dart';
import 'package:letbike/objects/item.dart';
import 'package:letbike/general/settings.dart';
import 'package:letbike/remote/images.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';

class RemoteItems {
  static String url = scriptsUrl + 'item/';

  static Future<bool> createItem(String userId, String name, String desc,
      String price, Map<String, String> params, List<Asset> images) async {
    RemoteImages.uploadImages(
        images, "items", (userId + name.hashCode.toString()));
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

  static Future<List?> getAllItems(int status,
      {String? sellerId,
      Map<String, String>? itemParams,
      String? soldTo,
      String? saverId}) async {
    final Response response = await post(
        Uri.parse(Uri.encodeFull(url + "itemGetAll.php")),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json;charset=UTF-8"
        },
        body: jsonEncode({
          "sellerId": sellerId,
          "status": status,
          "params": itemParams,
          "soldTo": soldTo,
          "saverId": saverId
        }));
    return response.statusCode == 200
        ? jsonDecode(response.body)
            .cast()
            .map<Item>((item) => Item.fromJson(item))
            .toList()
        : null;
  }

  static Future<bool?> updateItemStatus(int itemId, int newStatus,
      {String? soldTo}) async {
    final Response response = await post(
        Uri.parse(Uri.encodeFull(url + "itemUpdateStatus.php")),
        headers: {HttpHeaders.contentTypeHeader: 'application/json'},
        body: jsonEncode(
            {"itemId": itemId, "newStatus": newStatus, "soldTo": soldTo}));

    return response.statusCode == 200 && response.body != "ERROR" ? true : null;
  }
}
