import 'package:flutter/material.dart';
import '../../general/general.dart';

class SignLink {
  static Widget build(
      BuildContext context, String label, TextStyle style, Function onClick) {
    return TextButton(
        onPressed: onClick,
        child: Container(
            child: Text(
              label,
              style: style,
            ),
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(width: 1, color: kWhite)))));
  }
}
