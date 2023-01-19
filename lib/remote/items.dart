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

  static Future<bool> addItem(
      String userId, String name, String desc, String price, List<Asset> images, Map<String, int>? params) async {
    RemoteImages.uploadImages(images, "items", (userId + name.hashCode.toString()));
    final Response response = await post(Uri.parse(Uri.encodeFull(url + "add")),
        headers: {HttpHeaders.contentTypeHeader: 'application/json;charset=UTF-8'},
        body: jsonEncode({
          "id_user": userId,
          "name": name,
          "description": desc,
          "price": price,
          "imgs": images.length,
          "params": params
        }));

    return response.statusCode == 200 && response.body != "ERROR" ? true : false;
  }

  static Future<List?> getItems(int status,
      {String? sellerId, Map<String, int>? itemParams, String? soldTo, String? saverId}) async {
    // TODO limit
    final Response response = await post(Uri.parse(Uri.encodeFull(url + "list")),
        headers: {HttpHeaders.contentTypeHeader: "application/json;charset=UTF-8"},
        body: jsonEncode({
          "sellerId": sellerId,
          "statusId": status,
          "params": itemParams,
          "soldTo": soldTo,
          "saverId": saverId,
          "limit": 10
        }));

    return response.statusCode == 200
        ? jsonDecode(response.body).map<Item>((item) => Item.fromJson(item)).toList()
        : null;
  }

  static Future<bool?> updateItemStatus(int itemId, int newStatus, {String? soldTo}) async {
    final Response response = await post(Uri.parse(Uri.encodeFull(url + "itemUpdateStatus.php")),
        headers: {HttpHeaders.contentTypeHeader: 'application/json'},
        body: jsonEncode({"itemId": itemId, "newStatus": newStatus, "soldTo": soldTo}));

    return response.statusCode == 200 && response.body != "ERROR" ? true : null;
  }
}
