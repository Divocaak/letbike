import 'package:flutter/material.dart';

Widget imageMessage(BuildContext context, String path) {
  return SizedBox(
    width: MediaQuery.of(context).size.width * 0.65,
    child: Stack(
      alignment: Alignment.center,
      children: [
        ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image(
              image: AssetImage(path),
            )),
      ],
    ),
  );
}
