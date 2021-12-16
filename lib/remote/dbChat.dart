import 'dart:convert';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart';
import 'package:letbike/general/objects.dart';
import 'package:letbike/remote/settings.dart';
import 'package:letbike/remote/images.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';

class DatabaseChat {
  static String url = scriptsUrl + 'chat/';

  static Future<List<Message>> getMessagesBetween(
      User seller, User buyer, Item item) async {
    final Response response = await get(
        Uri.parse(Uri.encodeFull(url +
            "messageGet.php/?from=" +
            seller.toString() +
            "&&to=" +
            buyer.toString() +
            "&&itemId=" +
            item.id.toString())),
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
      User seller, User buyer, Item item) async* {
    while (true) {
      await Future.delayed(Duration.zero);
      yield await getMessagesBetween(seller, buyer, item);
    }
  }

  static Future sendMessage(
      int from, int to, int itemId, String message, List<Asset> images) async {
    if (images.length != 0) {
      RemoteImages.uploadImages(images, "messages",
          (from.toString() + to.toString() + message.hashCode.toString()));
    }

    String hasImg = images.length != 0 ? "1" : "0";
    final Response response = await get(
        Uri.parse(Uri.encodeFull(url +
            "messageSet.php/?from=" +
            from.toString() +
            "&&to=" +
            to.toString() +
            "&&itemId=" +
            itemId.toString() +
            "&&message=" +
            message +
            "&&img=" +
            hasImg)),
        headers: {"Accept": "application/json;charset=UTF-8"});
    if (response.statusCode == 200) {
      print("sent");
    } else {
      throw Exception("Something's wrong, I can feel it");
    }
  }

  static Future<List<Chat>> getChats(int itemId) async {
    final Response response = await get(
        Uri.parse(
            Uri.encodeFull(url + "chatsGet.php/?itemId=" + itemId.toString())),
        headers: {"Accept": "application/json;charset=UTF-8"});
    print(url + "chatsGet.php/?itemId=" + itemId.toString());
    if (response.statusCode == 200) {
      final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
      return parsed.map<Chat>((chat) => Chat.fromJson(chat)).toList();
    } else {
      throw Exception("Can't load chats");
    }
  }
}
