import 'package:flutter/material.dart';
import 'package:letbike/widgets/images.dart';

class BannedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
          body: Stack(alignment: Alignment.center, children: [
        BackgroundImage(),
        Text("Jste zabanován, kontaktujte prosím podporu",
            style: TextStyle(
                color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold))
      ]));
}
