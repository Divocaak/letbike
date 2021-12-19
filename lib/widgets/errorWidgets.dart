import 'package:flutter/material.dart';
import 'package:letbike/general/pallete.dart';
import 'package:emojis/emojis.dart';

class ErrorWidgets {
  static Widget futureBuilderError() => Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
            Icon(Icons.error_outline, color: kError),
            SizedBox(height: 12),
            Text('Někde se stala chyba ' + Emojis.faceScreamingInFear,
                style: TextStyle(color: kError))
          ]));

  static Widget futureBuilderEmpty() => Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
            Icon(Icons.search_off_outlined, color: kWarning),
            SizedBox(height: 12),
            Text(
                'Zatím tu nic není, zkuste to prosím později ' +
                    Emojis.thinkingFace,
                style: TextStyle(color: kWarning))
          ]));

  static Widget imageLoadingError(IconData icon) => Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
            Icon(icon, color: kError),
            Text('Obrázek nenalezen ' + Emojis.framedPicture,
                style: TextStyle(color: kError))
          ]));

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
