import 'package:flutter/material.dart';

class AlertBox {
  static showAlertBox(BuildContext context, String title, Widget body) {
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: body,
      actions: [
        TextButton(
          child: Text("OK"),
          onPressed: () {
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
