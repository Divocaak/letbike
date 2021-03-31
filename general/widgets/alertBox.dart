import 'package:flutter/material.dart';

class AlertBox {
  static showAlertBox(BuildContext context, String title, Widget body,
      {Function after}) {
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: body,
      actions: [
        TextButton(
          child: Text("OK"),
          onPressed: () {
            Navigator.of(context).pop();

            if (after != null) {
              after();
            }
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

class DecideBox {
  static showDecideBox(
      BuildContext context, String title, Widget body, Function onTrue) {
    AlertDialog decide = AlertDialog(
      title: Text(title),
      content: body,
      actions: [
        TextButton(
          child: Text("Zrušit"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
            child: Text("Potvrdit"),
            onPressed: () {
              Navigator.of(context).pop();
              onTrue();
            })
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return decide;
      },
    );
  }
}
