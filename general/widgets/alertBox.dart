import 'package:flutter/material.dart';
import 'package:letbike/general/general.dart';

class AlertBox {
  static showAlertBox(BuildContext context, String title, Widget body,
      {Function after}) {
    AlertDialog alert = AlertDialog(
      title: Text(
        title,
        style: TextStyle(color: kWhite),
      ),
      content: body,
      backgroundColor: kBlack,
      shape: RoundedRectangleBorder(side: BorderSide(color: kWhite)),
      actions: [
        TextButton(
          child: Text(
            "OK",
            style: TextStyle(color: kPrimaryColor),
          ),
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
      title: Text(title, style: TextStyle(color: kWhite)),
      content: body,
      actions: [
        TextButton(
          child: Text("Zrušit", style: TextStyle(color: kSecondaryColor)),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
            child: Text("Potvrdit", style: TextStyle(color: kPrimaryColor)),
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
