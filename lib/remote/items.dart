import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:letbike/objects/item.dart';
import 'package:letbike/general/settings.dart';

class RemoteItems {
  static String url = '${scriptsUrl}item/';

  static Future<bool> addItem(String userId, String name, String desc, String price, XFile thumbnail,
      List<XFile> images, Map<String, int>? params) async {
    List<String> imagesConverted = [];
    for (var element in images) {
      var data = base64Encode(await element.readAsBytes());
      imagesConverted.add(data);
    }

    var body = jsonEncode({
      "id_user": userId,
      "name": name,
      "description": desc,
      "price": price,
      "imgs": imagesConverted,
      "params": params
    });

    final Response response = await post(Uri.parse(Uri.encodeFull("${url}add")),
        headers: {HttpHeaders.contentTypeHeader: 'application/json;charset=UTF-8'}, body: body);

    return response.statusCode == 200 && response.body != "ERROR" ? true : false;
  }

  static Future<List?> getItems(int status,
      {String? sellerId, Map<String, int>? itemParams, String? soldTo, String? saverId}) async {
    // TODO APP L8R limit, dynamic loading
    final Response response = await post(Uri.parse(Uri.encodeFull("${url}list")),
        headers: {HttpHeaders.contentTypeHeader: "application/json;charset=UTF-8"},
        body: jsonEncode({
          "id_seller": sellerId,
          "id_status": status,
          "params": itemParams,
          "id_buyer": soldTo,
          "id_saver": saverId,
          "limit": 10
        }));

    return response.statusCode == 200
        ? jsonDecode(response.body)["items"].map<Item>((item) => Item.fromJson(item)).toList()
        : null;
  }

  static Future<bool?> updateItemStatus(int itemId, int newStatus, {String? soldTo}) async {
    final Response response = await post(Uri.parse(Uri.encodeFull("${url}updateStatus")),
        headers: {HttpHeaders.contentTypeHeader: 'application/json'},
        body: jsonEncode({"id_item": itemId, "id_status": newStatus, "id_buyer": soldTo}));

    return response.statusCode == 200 && response.body != "ERROR" ? true : null;
  }
}
