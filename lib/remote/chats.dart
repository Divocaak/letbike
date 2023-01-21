import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:letbike/objects/chat.dart';
import 'package:letbike/objects/item.dart';
import 'package:letbike/objects/message.dart';
import 'package:letbike/general/settings.dart';

class RemoteChats {
  static String url = scriptsUrl + 'chat/';

  static Future<List<Message>?> getMessagesBetween(
      String meId, String secondUserId, Item item) async {
    final Response response = await post(
        Uri.parse(Uri.encodeFull(url + "messageGet.php")),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json;charset=UTF-8'
        },
        body: jsonEncode(
            {"meId": meId, "secondUserId": secondUserId, "itemId": item.id}));

    return response.statusCode == 200 && response.body != "ERROR"
        ? jsonDecode(response.body)
            .cast()
            .map<Message>((message) => Message.fromJson(message))
            .toList()
        : null;
  }

  static Stream<List<Message>?> getMessages(
      String meId, String secondUserId, Item item) async* {
    while (true) {
      await Future.delayed(Duration.zero);
      yield await getMessagesBetween(meId, secondUserId, item);
    }
  }

  static Future sendMessage(String from, String to, int itemId, String message,
      List<XFile> images) async {
    if (images.length != 0) {
      // TODO process images
    }

    final Response response = await post(
        Uri.parse(Uri.encodeFull(url + "messageSet.php")),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json;charset=UTF-8'
        },
        body: jsonEncode({
          "from": from,
          "to": to,
          "itemId": itemId,
          "message": message,
          "img": (images.length > 0 ? "1" : "0")
        }));

    if (response.statusCode == 200 && response.body == "ERROR") {
      print("erorr sending");
    }
  }

  static Future<List<Chat>?> getChats(int itemId, String sellerId) async {
    final Response response = await post(
        Uri.parse(Uri.encodeFull(url + "chatsGet.php")),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json;charset=UTF-8'
        },
        body: jsonEncode({"itemId": itemId, "sellerId": sellerId}));

    return response.statusCode == 200 && response.body != "ERROR"
        ? jsonDecode(response.body)
            .cast()
            .map<Chat>((chat) => Chat.fromJson(chat))
            .toList()
        : null;
  }
}
