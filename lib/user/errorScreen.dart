import 'package:flutter/material.dart';
import 'package:letbike/widgets/images.dart';

class ErrorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
          body: Stack(alignment: Alignment.center, children: [
        BackgroundImage(),
        Text("Někde se stala chyba, zkuste to prosím později",
            style: TextStyle(
                color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold))
      ]));
}
