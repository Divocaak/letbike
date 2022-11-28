import 'package:flutter/material.dart';
import 'package:letbike/objects/params/param_option.dart';
import 'package:letbike/widgets/new/params/param_dropdown.dart';
import 'package:letbike/widgets/new/params/param_switchable.dart';

class Param {
  final String key;
  final bool? isSwitch;
  final String label;
  final List<dynamic> options;
  final bool hasValues;

  Param(this.key, this.isSwitch, this.label, this.options, this.hasValues);

  factory Param.fromJson(Map<String, dynamic> json) {
    bool hasMoreParams = json["values"][0].runtimeType != String;
    List<ParamOption>? valuesParams;
    if (hasMoreParams) {
      valuesParams = json["values"]
          .map<ParamOption>((data) => ParamOption.fromJson(data))
          .toList();
    }

    return Param(
        json["key"],
        json["isSwitch"],
        json["label"],
        hasMoreParams ? valuesParams! : List<String>.from(json["values"]),
        hasMoreParams);
  }
  Widget buildParam(BuildContext context) => (isSwitch != null && isSwitch!)
      ? ParamSwitchable(
          label: label, leftOption: options[0], rightOption: options[1])
      : ParamDropdown(
          hint: label, options: options, filterKey: key, hasValues: hasValues);
}
