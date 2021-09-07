import 'package:flutter/material.dart';
import 'package:letbike/general/general.dart';

class ItemParam extends StatelessWidget {
  final ItemParams params;

  ItemParam(this.params);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: ParamRow.names.length,
        itemBuilder: (context, i) {
          return itemParam(context, i, params);
        });
  }

  Widget itemParam(context, int i, ItemParams params) {
    int index = params.params[ParamRow.keys[i]];
    if (index > 999) {
      index -= (999 +
          (params.params["selectedOther"] != null
              ? params.params["selectedOther"]
              : 0) +
          (params.params["selectedParts"] != null
              ? params.params["selectedParts"]
              : 0));
    }

    if (index > -1 && index < 999) {
      return Row(
        children: [
          Container(
              height: 40,
              width: 100,
              color: kPrimaryColor,
              alignment: Alignment.center,
              child: Text(ParamRow.names[i], style: TextStyle(color: kWhite))),
          Container(
            height: 40,
            width: 100,
            color: kSecondaryColor,
            alignment: Alignment.center,
            child: Text(ParamRow.options[i][index],
                style: TextStyle(color: kBlack)),
          )
        ],
      );
    } else {
      return SizedBox(
        height: 1,
      );
    }
  }
}
