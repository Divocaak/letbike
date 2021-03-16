import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:multi_image_picker/multi_image_picker.dart';

class TvorbaInzeratu extends StatefulWidget {
  @override
  _TvorbaInzeratu createState() => new _TvorbaInzeratu();
}

class _TvorbaInzeratu extends State<TvorbaInzeratu> {
  List<Asset> images;
  String _error;

  @override
  void initState() {
    super.initState();
  }

  Widget buildGridView() {
    if (images != null)
      return GridView.count(
        crossAxisCount: 3,
        children: List.generate(images.length, (index) {
          Asset asset = images[index];
          return AssetThumb(
            asset: asset,
            width: 300,
            height: 300,
          );
        }),
      );
    else
      return Container(color: Colors.white);
  }

  Future<void> loadAssets() async {
    setState(() {
      images = List<Asset>.empty();
    });

    List<Asset> resultList;
    String error;

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 10,
        enableCamera: true,
      );
    } on Exception catch (e) {
      error = e.toString();
    }
    if (!mounted) return;

    setState(() {
      images = resultList;
      if (error == null) _error = 'No Error Dectected';
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[
        //Nadpis
        Padding(
          padding: EdgeInsets.all(1),
          child: TextField(
            obscureText: false,
            maxLength: 25,
            decoration: InputDecoration(
                border: OutlineInputBorder(), labelText: 'Nadpis'),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(3),
          child: TextField(
            maxLines: 5,
            maxLength: 300,
            decoration: InputDecoration(
                border: OutlineInputBorder(), labelText: 'Popis'),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(3),
          child: TextField(
            decoration: InputDecoration(
                border: OutlineInputBorder(), labelText: 'Cena (Kč)'),
            keyboardType: TextInputType.number,
          ),
        ),
        ElevatedButton(
          child: Text("Vybrat foto z úložiště"),
          onPressed: loadAssets,
        ),
        ElevatedButton(
          child: Text('Další'),
          onPressed: () {
            print("next");
          },
        ),
        Expanded(
          child: buildGridView(),
        )
      ],
    );
  }
}
