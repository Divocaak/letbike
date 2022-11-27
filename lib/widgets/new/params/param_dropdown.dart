import 'package:flutter/material.dart';
import 'package:letbike/general/settings.dart';
import 'package:letbike/screens/params_screen.dart';

// URGENT rework
// ignore: must_be_immutable
class ParamDropdown extends StatefulWidget {
  ParamDropdown(
      {Key? key,
      required String hint,
      required List<String> options,
      required String filterKey})
      : _hint = hint,
        _options = options,
        _filterKey = filterKey,
        super(key: key);

  int? value;
  final String _hint;
  final List<String> _options;
  // ignore: unused_field
  final String _filterKey;
  State<ParamsPage>? _fp;

  setFp(input) => _fp = input;
  getKey() => _filterKey;

  ParamDropdownState createState() => ParamDropdownState();
}

class ParamDropdownState extends State<ParamDropdown> {
  @override
  Widget build(BuildContext context) => Container(
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
          onChanged: (newValue) {
            setState(() => widget.value = newValue as int);
            if (widget._fp != null) widget._fp!.setState(() {});
          },
          items: generateItems()));

  List<DropdownMenuItem<int>> generateItems() {
    List<DropdownMenuItem<int>> toRet = [];
    for (int i = 0; i < widget._options.length; i++) {
      toRet.add(DropdownMenuItem(
          child: Text(widget._options[i], style: TextStyle(color: kWhite)),
          value: i));
    }
    return toRet;
  }
}
