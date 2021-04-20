import 'package:flutter/material.dart';
import 'package:letbike/app/filterPage.dart';
import 'package:letbike/app/homePage.dart';
import '../general/general.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class AddItem extends StatefulWidget {
  @override
  _AddItem createState() => _AddItem();

  static const routeName = "/addItem";
}

Future<String> addResponse;

class _AddItem extends State<AddItem> with TickerProviderStateMixin {
  HomeArguments args;
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

    return MaterialApp(
      title: 'Přidat předmět',
      home: Scaffold(
        body: Stack(
          children: [
            BackgroundImage(),
            Scaffold(
              backgroundColor: Colors.transparent,
              resizeToAvoidBottomInset: false,
              body: Container(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: ListView(
                    children: [
                      Container(
                        height: 20,
                      ),
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
                      Container(height: 20),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed(
                                FilterPage.routeName,
                                arguments: new AddItemFiltersArgs(args, true));
                          },
                          child: Container(
                              height: 50,
                              width: 250,
                              decoration: BoxDecoration(
                                color: kSecondaryColor,
                                border: Border.all(
                                  color: kSecondaryColor,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: Center(
                                  child: Text("Vyplnit detaily předmětu",
                                      style: TextStyle(
                                        color: kBlack,
                                      ))))),
                      Container(height: 20),
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
                                  child: Text("Vybrat foto z úložiště"),
                                  onPressed: loadAssets,
                                ),
                              ),
                              Expanded(
                                child: buildGridView(),
                              )
                            ],
                          )),
                    ],
                  ),
                ),
              ),
            ),
            IgnorePointer(
              ignoring: volume == 0 ? true : false,
              child: Container(
                color: Colors.black.withOpacity(volume),
                child: Stack(
                  children: [
                    Positioned(
                        bottom: 120,
                        right: 120,
                        child: CircularButton(
                            kSecondaryColor.withOpacity(volume * 2),
                            45,
                            Icons.arrow_back,
                            kWhite.withOpacity(volume * 2), () {
                          Navigator.of(context).pushReplacementNamed(
                              HomePage.routeName,
                              arguments: args);
                        })),
                    Positioned(
                        bottom: 150,
                        right: 40,
                        child: CircularButton(
                            kSecondaryColor.withOpacity(volume * 2),
                            45,
                            Icons.add,
                            kWhite.withOpacity(volume * 2), () {
                          addResponse = DatabaseServices.createItem(
                              new Item(
                                  -1,
                                  args.user.id,
                                  nameController.text,
                                  descController.text,
                                  double.parse(priceController.text),
                                  0,
                                  0,
                                  "",
                                  "",
                                  "",
                                  0,
                                  args.filters,
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
                                  return Center(
                                      child: CircularProgressIndicator());
                                },
                              ));
                        })),
                  ],
                ),
              ),
            ),
            Positioned(
                height: 275,
                width: 275,
                right: -75,
                bottom: -75,
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    CircularButton(kPrimaryColor, 60, Icons.menu, kWhite, () {
                      if (animationController.isCompleted) {
                        animationController.reverse();
                        volume = 0;
                      } else {
                        animationController.forward();
                        volume = 0.5;
                      }
                    })
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
