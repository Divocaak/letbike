import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../pallete.dart';

class FilterWidgets extends StatefulWidget {
  @override
  _FilterWidgetsState createState() => _FilterWidgetsState();
}

class _FilterWidgetsState extends State<FilterWidgets> {
  @override
  void initState() {
    super.initState();
  }

  static Widget filterDropdown(
    String hint,
    int value,
    List<String> options,
  ) {
    return DropdownButton(
      hint: Text(hint),
      value: value,
      onChanged: (newValue) {
        setState(() {
          value = newValue;
        });
      },
      items: options.asMap().entries.map((entry) {
        return DropdownMenuItem(
          child: new Text(entry.value),
          value: entry.key,
        );
      }).toList(),
    );
  }

  static Widget filterSwitch(
      String label, String left, String right, bool used) {
    return Row(children: [
      Text(label + ": " + left),
      Switch(
        value: used,
        onChanged: (value) {
          setState(() {
            used = value;
          });
        },
      ),
      Text(" " + right)
    ]);
  }
}
