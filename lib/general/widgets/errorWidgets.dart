import 'package:flutter/material.dart';
import '../pallete.dart';
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
            color: kWhite,
          ),
          SizedBox(
            height: 12,
          ),
          Text(
            'Někde se stala chyba ' + Emojis.faceScreamingInFear,
            style: TextStyle(color: kWhite),
          )
        ]));
  }
}
