import 'package:flutter/material.dart';
import 'package:letbike/general/objects.dart';
import 'package:letbike/general/pallete.dart';

class ItemParam extends StatelessWidget {
  final Map<String, String> params;

  ItemParam(this.params);

  @override
  Widget build(BuildContext context) {
    List<String> keys = params.keys.toList();
    List<String> values = params.values.toList();
    return ListView.builder(
        itemCount: params.length,
        itemBuilder: (context, i) {
          return Row(
            children: [
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
                    ParamRow.params[keys[i]]!.options[getVal(values[i])],
                    style: TextStyle(color: kBlack)),
              )
            ],
          );
        });
  }

  getVal(String input) {
    int ret;
    if (input == "true" || input == "false") {
      return (input == "false" ? 0 : 1);
    } else {
      ret = int.parse(input);
    }
    return ret;
  }
}
