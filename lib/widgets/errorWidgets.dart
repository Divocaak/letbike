import 'package:flutter/material.dart';
import 'package:letbike/general/pallete.dart';
import 'package:emojis/emojis.dart';

class ErrorWidgets {
  static Widget futureBuilderError() {
    return Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
          Icon(
            Icons.error_outline,
            color: kError,
          ),
          SizedBox(
            height: 12,
          ),
          Text(
            'Někde se stala chyba ' + Emojis.faceScreamingInFear,
            style: TextStyle(color: kError),
          )
        ]));
  }

  static Widget futureBuilderEmpty() {
    return Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
          Icon(
            Icons.search_off_outlined,
            color: kWarning,
          ),
          SizedBox(
            height: 12,
          ),
          Text(
            'Zatím tu nic není, zkuste to prosím později ' +
                Emojis.thinkingFace,
            style: TextStyle(color: kWarning),
          )
        ]));
  }

  static Widget imageLoadingError(IconData icon) {
    return Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
          Icon(
            icon,
            color: kError,
          ),
          Text(
            'Obrázek nenalezen ' + Emojis.framedPicture,
            style: TextStyle(color: kError),
          )
        ]));
  }

  static Widget addItemError() {
    return Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
          Icon(
            Icons.warning_rounded,
            color: kWarning,
          ),
          SizedBox(
            height: 12,
          ),
          Text(
            'Vyplňte prosím název, popis a cenu inzerátu. Přidejte alespoň jeden obrázek. ' +
                Emojis.foldedHands,
            style: TextStyle(color: kWarning),
          )
        ]));
  }
}
