import 'package:flutter/material.dart';
import 'package:letbike/widgets/new/params/param_dropdown.dart';
import 'package:letbike/widgets/new/params/param_switchable.dart';

class Param {
  final String key;
  final bool? isSwitch;
  final String label;
  final List<String> values;
  final List<Param>? options;

  Param(this.key, this.isSwitch, this.label, this.values, this.options);

  factory Param.fromJson(Map<String, dynamic> json) {
    print(json["values"].runtimeType);
    return Param(
        json["key"],
        json["isSwitch"],
        json["label"],
        List<String>.from(json["values"] as List),
        json["options"] != null
            ? json["options"]
                .map<Param>((data) => Param.fromJson(data))
                .toList()
            : null);
  }

  Widget buildParam(BuildContext context) {
    print(values);
    return Container();
    /* return (isSwitch != null && isSwitch!)
        ? ParamSwitchable(
            label: label, leftOption: values[0], rightOption: values[1])
        : ParamDropdown(hint: label, options: values, filterKey: key); */
  }
}
