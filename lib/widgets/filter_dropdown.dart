import 'package:flutter/material.dart';
import 'package:letbike/general/settings.dart';
import 'package:letbike/screens/filter_screen.dart';

// ignore: must_be_immutable
class FilterDropdown extends StatefulWidget {
  FilterDropdown(
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
  State<FilterPage>? _fp;

  setFp(input) => _fp = input;
  getKey() => _filterKey;

  State<StatefulWidget> createState() => _FilterDropdownState();
}

class _FilterDropdownState extends State<FilterDropdown> {
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
          items: widget._options
              .asMap()
              .entries
              .map((entry) => DropdownMenuItem(
                  child: new Text(entry.value, style: TextStyle(color: kWhite)),
                  value: entry.key))
              .toList()));
}
