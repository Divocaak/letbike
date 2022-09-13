import 'package:flutter/material.dart';
import 'package:letbike/general/settings.dart';
import 'package:letbike/objects/categories.dart';

class ItemParam {
  final String key;
  final dynamic value;
  final String translateName;
  final String translateValue;

  ItemParam(this.key, this.value, this.translateName, this.translateValue);

  factory ItemParam.fromJson(Map<String, dynamic> json) {
    print(json);
    return ItemParam(/* json["key"], json["value"], */ "", "", "", "");
  }

  Widget buildParamRow() => Row(children: [
        Expanded(
            child: Container(
                padding: EdgeInsets.symmetric(vertical: 15),
                color: kPrimaryColor,
                child: Text(ParamRow.params[key]!.name,
                    style: TextStyle(color: kWhite),
                    textAlign: TextAlign.center))),
        Expanded(
            child: Container(
                padding: EdgeInsets.symmetric(vertical: 15),
                color: kSecondaryColor,
                child: Text(
                    ParamRow.params[key]!.options[
                        (value == "true" || value == "false")
                            ? (value == "false" ? 0 : 1)
                            : int.parse(value)],
                    style: TextStyle(color: kWhite),
                    textAlign: TextAlign.center))),
      ]);
}
