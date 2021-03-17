

import 'package:flutter/material.dart';


class ImageMessage extends StatelessWidget {
  @override

  

  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.65, 
      //child: AspectRatio(aspectRatio: 0.6,
        child: Stack(
          alignment: Alignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image(image: AssetImage("assets/images/Image from iOS (1).jpg"),)
            ),
          ],
        ),
      //),
    );
  }
}
