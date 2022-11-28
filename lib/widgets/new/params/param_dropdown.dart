import 'package:flutter/material.dart';
import 'package:letbike/general/settings.dart';
import 'package:letbike/objects/params/param_option.dart';
import 'package:letbike/screens/params_screen.dart';

// URGENT rework
// ignore: must_be_immutable
class ParamDropdown extends StatefulWidget {
  ParamDropdown(
      {Key? key,
      required String hint,
      required List<dynamic> options,
      required String filterKey,
      required bool hasValues})
      : _hint = hint,
        _options = options,
        _filterKey = filterKey,
        _hasValues = hasValues,
        super(key: key);

  int? value;
  final String _hint;
  final List<dynamic> _options;
  final bool _hasValues;
  // ignore: unused_field
  final String _filterKey;
  State<ParamsPage>? _fp;

  setFp(input) => _fp = input;
  getKey() => _filterKey;

  ParamDropdownState createState() => ParamDropdownState();
}

class ParamDropdownState extends State<ParamDropdown> {
  late List<Widget> children;

  @override
  void initState() {
    children = [];
    super.initState();
  }

  Widget getChildren() {
    List<Widget> toRet = [];
    if (widget._hasValues && widget.value != null) {
      ParamOption paramOption = widget._options[widget.value!];
      if (paramOption.params != null) {
        paramOption.params!
            .forEach((param) => toRet.add(param.buildParam(context)));
      }
    }

    return toRet.isNotEmpty ? Column(children: toRet) : Container();
  }

  @override
  Widget build(BuildContext context) => Column(children: [
        Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
            decoration: BoxDecoration(
                color: kBlack.withAlpha(128),
                border: Border.all(color: kWhite.withAlpha(128)),
                borderRadius: BorderRadius.circular(12)),
            child: DropdownButton(
                hint: Text(widget._hint, style: TextStyle(color: kWhite)),
                dropdownColor: kBlack,
                value: widget.value,
                onChanged: (int? newValue) {
                  setState(() => widget.value = newValue);
                  if (widget._fp != null) widget._fp!.setState(() {});
                },
                items: generateItems())),
        getChildren()
      ]);

  List<DropdownMenuItem<int>> generateItems() {
    List<DropdownMenuItem<int>> toRet = [];
    for (int i = 0; i < widget._options.length; i++) {
      toRet.add(DropdownMenuItem(
          child: Text(
              (!widget._hasValues)
                  ? widget._options[i]
                  : widget._options[i].label,
              style: TextStyle(color: kWhite)),
          value: i));
    }
    return toRet;
  }
}
