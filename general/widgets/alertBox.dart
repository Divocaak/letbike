import 'package:flutter/material.dart';

class AlertBox {
  static showAlertBox(BuildContext context, String title, Widget body,
      [Function function]) {
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: body,
      actions: [
        TextButton(
          child: Text("OK"),
          onPressed: () {
            function();
            Navigator.of(context).pop();
          },
        )
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
