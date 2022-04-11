import 'package:flutter/material.dart';
import 'package:letbike/settings.dart';
import 'package:emojis/emojis.dart';

class ErrorWidgets {
  static Widget futureBuilderError() => SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      child: Padding(
          padding: EdgeInsets.only(top: 50),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(Icons.error_outline, color: kError),
            SizedBox(height: 12),
            Text('Někde se stala chyba ' + Emojis.faceScreamingInFear,
                style: TextStyle(color: kError, fontSize: 18))
          ])));

  static Widget futureBuilderEmpty() => SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      child: Padding(
          padding: EdgeInsets.only(top: 50),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(Icons.search_off_outlined, color: kWarning, size: 40),
            SizedBox(height: 12),
            Text(
                'Zatím tu nic není, zkuste to prosím později ' +
                    Emojis.thinkingFace,
                style: TextStyle(color: kWarning, fontSize: 20),
                textAlign: TextAlign.center)
          ])));

  static Widget imageLoadingError(IconData icon) =>
      Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Icon(icon, color: kError),
        Text('Obrázek nenalezen ' + Emojis.framedPicture,
            style: TextStyle(color: kError))
      ]);

  static Widget snackBarMessage(String message, Color color, IconData icon) =>
      Row(children: [
        Icon(icon, color: color),
        SizedBox(width: 10),
        Flexible(child: Text(message, style: TextStyle(color: color)))
      ]);

  static Widget snackBarError() => Row(children: [
        Icon(Icons.error_outline, color: kError),
        SizedBox(width: 10),
        Flexible(
            child: Text('Někde se stala chyba ' + Emojis.faceScreamingInFear,
                style: TextStyle(color: kError)))
      ]);
}
