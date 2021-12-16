import 'package:flutter/material.dart';
import 'package:letbike/general/objects.dart';
import 'package:letbike/general/pallete.dart';

class ItemParam extends StatelessWidget {
  final Map<String, dynamic> params;

  ItemParam(this.params);

  @override
  Widget build(BuildContext context) {
    List<String> keys = params.keys.toList();
    List<dynamic> values = params.values.toList();
    return ListView.builder(
        itemCount: params.length,
        itemBuilder: (context, i) => Row(children: [
              Container(
                  height: 40,
                  width: 100,
                  color: kPrimaryColor,
                  alignment: Alignment.center,
                  child: Text(ParamRow.params[keys[i]]!.name,
                      style: TextStyle(color: kWhite))),
              Container(
                  height: 40,
                  width: 100,
                  color: kSecondaryColor,
                  alignment: Alignment.center,
                  child: Text(
                      ParamRow.params[keys[i]]!.options[
                          (values[i] == "true" || values[i] == "false")
                              ? (values[i] == "false" ? 0 : 1)
                              : int.parse(values[i])],
                      style: TextStyle(color: kBlack)))
            ]));
  }
}
