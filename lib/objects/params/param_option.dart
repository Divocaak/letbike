import 'package:letbike/objects/params/param.dart';

class ParamOption {
  final String label;
  final List<Param>? params;

  ParamOption(this.label, this.params);

  factory ParamOption.fromJson(Map<String, dynamic> json) => ParamOption(json["label"],
      json["options"] != null ? json["options"].map<Param>((data) => Param.fromJson(data)).toList() : null);
}
