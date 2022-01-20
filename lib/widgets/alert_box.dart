import 'package:emojis/emojis.dart';
import 'package:flutter/material.dart';
import 'package:letbike/general/settings.dart';

class ModalWindow {
  static showModalWindow(BuildContext context, String title, Widget body,
          {Function? after, Function? onTrue}) =>
      showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                  title: Text(title, style: TextStyle(color: kWhite)),
                  content: SizedBox(
                      height: MediaQuery.of(context).size.height / 2,
                      width: MediaQuery.of(context).size.width,
                      child: SizedBox.expand(child: body)),
                  backgroundColor: kBlack,
                  elevation: 100,
                  shape: RoundedRectangleBorder(
                      side: BorderSide(color: kWhite.withOpacity(.25)),
                      borderRadius: BorderRadius.circular(25)),
                  actions: [
                    if (after != null)
                      TextButton(
                          child: Text(Emojis.okButton,
                              style: TextStyle(color: kPrimaryColor)),
                          onPressed: () {
                            Navigator.of(context).pop();
                            after();
                          }),
                    if (onTrue != null)
                      TextButton(
                          child: Text(Emojis.crossMarkButton,
                              style: TextStyle(color: kSecondaryColor)),
                          onPressed: () {
                            Navigator.of(context).pop();
                          }),
                    if (onTrue != null)
                      TextButton(
                          child: Text(Emojis.checkMarkButton,
                              style: TextStyle(color: kPrimaryColor)),
                          onPressed: () {
                            Navigator.of(context).pop();
                            onTrue();
                          })
                  ]));
}
