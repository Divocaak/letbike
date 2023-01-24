import 'package:flutter/material.dart';
import 'package:letbike/general/settings.dart';

class ParamItem {
  final String label;
  final String value;

  ParamItem(this.label, this.value);

  Widget buildChip() => Chip(
        label: RichText(
            text: TextSpan(children: [
          TextSpan(text: label, style: const TextStyle(color: kSecondaryColor)),
          const TextSpan(text: ": "),
          TextSpan(text: value, style: const TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold))
        ])),
        backgroundColor: kBlack,
        shadowColor: kPrimaryColor,
        elevation: 7,
        side: const BorderSide(color: kPrimaryColor),
      );
}
