import 'package:flutter/material.dart';
import 'package:letbike/filters/filters.dart';
import 'package:letbike/app/homePage.dart';
import '../general/general.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:letbike/widgets/textInput.dart';
import 'package:letbike/widgets/mainButtonEssentials.dart';
import 'package:letbike/widgets/buttonRounded.dart';
import 'package:letbike/widgets/backgroundImage.dart';
import 'package:letbike/widgets/alertBox.dart';

class AddItem extends StatefulWidget {
  @override
  _AddItem createState() => _AddItem();

  static const routeName = "/addItem";
}

Future<String> addResponse;

class _AddItem extends State<AddItem> with TickerProviderStateMixin {
  AddItemFiltersArgs args;
  List<Asset> images = [];

  final TextEditingController nameController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

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

  Future<int> checkPerm() async {
    var status = await Permission.camera.status;
    if (status != PermissionStatus.granted) {
      await Permission.camera.request();
      return Permission.camera.value;
    } else {
      return 1;
    }
  }

  Future<void> loadAssets() async {
    setState(() {
      images = [];
    });

    List<Asset> resultList;
    String error;

    if (await checkPerm() == 1) {
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
        if (error != null)
          AlertBox.showAlertBox(
              context, "Error", Text("Error", style: TextStyle(color: kWhite)));
      });
    }
  }

  double volume = 0;

  AnimationController animationController;

  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 250));
    animationController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context).settings.arguments;
    if (args.addItemData != null) {
      nameController.text = args.addItemData.name;
      descController.text = args.addItemData.desc;
      priceController.text = args.addItemData.price;
      images = args.addItemData.imgs;
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: MainButton(
          iconData: Icons.menu,
          onPressed: () {
            if (animationController.isCompleted) {
              animationController.reverse();
              volume = 0;
            } else {
              animationController.forward();
              volume = 0.5;
            }
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: Stack(
        children: [
          BackgroundImage(),
          Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            TextInput(
                icon: Icons.text_fields,
                hint: "Název předmětu",
                inputAction: TextInputAction.next,
                controller: nameController),
            TextInput(
                icon: Icons.text_fields,
                hint: "Popis předmětu",
                inputAction: TextInputAction.next,
                controller: descController),
            TextInput(
              icon: Icons.attach_money,
              hint: "Cena",
              inputAction: TextInputAction.done,
              inputType: TextInputType.number,
              controller: priceController,
            ),
            RoundedButton(
                buttonName: "Vyplnit detaily předmětu",
                onClick: () => Navigator.of(context).pushNamed(
                    FilterPage.routeName,
                    arguments: new AddItemFiltersArgs(
                        args.args,
                        new AddItemData(
                            nameController.text,
                            descController.text,
                            priceController.text,
                            images)))),
            Container(
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(25),
                ),
                padding: EdgeInsets.all(15),
                child: Column(
                  children: [
                    Text(
                        "První vybraný obrázek se bude zobrazovat na domovské stránce."),
                    Container(
                      child: TextButton(
                        child: Text("Vybrat fotografie"),
                        onPressed: loadAssets,
                      ),
                    ),
                    Expanded(
                      child: buildGridView(),
                    )
                  ],
                ))
          ]),
          MainButtonClicked(buttons: [
            SecondaryButtonData(
                Icons.arrow_back,
                () => Navigator.of(context).pushReplacementNamed(
                    HomePage.routeName,
                    arguments: new HomeArguments(
                        args.args.user, ItemParams.createEmpty()))),
            SecondaryButtonData(Icons.add, () {
              addResponse = DatabaseServices.createItem(
                  new Item(
                      -1,
                      args.args.user.id,
                      nameController.text,
                      descController.text,
                      double.parse(priceController.text),
                      0,
                      0,
                      "",
                      "",
                      "",
                      0,
                      args.args.filters,
                      0),
                  images);

              AlertBox.showAlertBox(
                  context,
                  "Oznámení",
                  FutureBuilder<String>(
                    future: addResponse,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text(snapshot.data,
                            style: TextStyle(color: kWhite));
                      } else if (snapshot.hasError) {
                        return Text('Sorry there is an error',
                            style: TextStyle(color: kWhite));
                      }
                      return Center(child: CircularProgressIndicator());
                    },
                  ));
            })
          ], volume: volume)
        ],
      ),
    );
  }
}
