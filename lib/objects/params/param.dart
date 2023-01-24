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
  Widget? formWidget;

  Param(this.key, this.isSwitch, this.label, this.options, this.hasValues);

  factory Param.fromJson(Map<String, dynamic> json) {
    bool hasMoreParams = json["values"][0].runtimeType != String;
    List<ParamOption>? valuesParams;
    if (hasMoreParams) {
      valuesParams = json["values"].map<ParamOption>((data) => ParamOption.fromJson(data)).toList();
    }

    return Param(json["key"], json["isSwitch"], json["label"],
        hasMoreParams ? valuesParams! : List<String>.from(json["values"]), hasMoreParams);
  }

  Widget buildParam(BuildContext context) {
    Widget toRet;
    if (isSwitch != null && isSwitch!) {
      toRet = ParamSwitchable(label: label, leftOption: options[0], rightOption: options[1]);
    } else {
      toRet = ParamDropdown(hint: label, options: options, filterKey: key, hasValues: hasValues);
    }
    formWidget = toRet;
    return toRet;
  }

  int? getValue() => (isSwitch != null && isSwitch!)
      ? (formWidget as ParamSwitchable?)?.getValue()
      : (formWidget as ParamDropdown?)?.getValue();

  Map<String, int> getParams() {
    Map<String, int> toRet = {};
    int? val = getValue();
    if (val != null) {
      toRet[key] = val;
    }

    toRet.addAll(getChildParams());
    return toRet;
  }

  Map<String, int> getChildParams() {
    Map<String, int> toRet = {};
    int? myVal = getValue();
    if (hasValues && myVal != null) {
      for (var param in (options[myVal] as ParamOption).params!) {
        toRet.addAll(param.getParams());
      }
    }
    return toRet;
  }
}
