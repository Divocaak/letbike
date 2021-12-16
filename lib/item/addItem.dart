import 'package:emojis/emojis.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:letbike/filters/filters.dart';
import 'package:letbike/widgets/errorWidgets.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:letbike/widgets/textInput.dart';
import 'package:letbike/widgets/mainButtonEssentials.dart';
import 'package:letbike/widgets/images.dart';
import 'package:letbike/general/pallete.dart';

// ignore: must_be_immutable
class AddItem extends StatefulWidget {
  AddItem({Key? key, required User loggedUser})
      : _loggedUser = loggedUser,
        super(key: key);

  final User _loggedUser;
  List<Asset>? _images;

  @override
  _AddItem createState() => _AddItem();
}

class _AddItem extends State<AddItem> with TickerProviderStateMixin {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

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
    setState(() => widget._images = []);

    List<Asset>? resultList;
    String? error;

    if (await checkPerm() == 1) {
      try {
        resultList = await MultiImagePicker.pickImages(
            maxImages: 9, enableCamera: true, selectedAssets: widget._images!);
      } on Exception catch (e) {
        error = e.toString();
      }

      if (!mounted) return;

      if (resultList != null) {
        setState(() => widget._images = resultList);
      }
      if (error != null) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Chyba: " + error)));
      }
    }
  }

  Widget buildGridView() {
    if (widget._images != null) {
      return GridView.count(
          crossAxisCount: 3,
          children: List.generate(widget._images!.length, (index) {
            Asset asset = widget._images![index];
            return AssetThumb(asset: asset, width: 50, height: 50);
          }));
    } else {
      return Container();
    }
  }

  double volume = 0;
  late AnimationController animationController;

  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 250));
    animationController.addListener(() => setState(() {}));
    super.initState();
  }

  @override
  Widget build(BuildContext context) => GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
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
          body: Stack(children: [
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
                  controller: priceController),
              Container(
                  height: 400,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.white, width: 2),
                      borderRadius: BorderRadius.circular(25)),
                  padding: EdgeInsets.all(15),
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(children: [
                    Text(
                        "První vybraný obrázek se bude zobrazovat na domovské stránce."),
                    Container(
                        child: TextButton(
                            child: Text("Vybrat fotografie (minimálně 1)"),
                            onPressed: loadAssets)),
                    Expanded(child: Container(child: buildGridView()))
                  ]))
            ]),
            MainButtonClicked(buttons: [
              SecondaryButtonData(
                  Icons.arrow_back, () => Navigator.of(context).pop()),
              SecondaryButtonData(
                  Icons.add,
                  () => (widget._images != null &&
                          nameController.text != "" &&
                          descController.text != "" &&
                          priceController.text != "")
                      ? Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => FilterPage(
                              loggedUser: widget._loggedUser,
                              name: nameController.text,
                              desc: descController.text,
                              price: priceController.text,
                              images: widget._images!)))
                      : ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: ErrorWidgets.snackBarMessage(
                              'Vyplňte prosím název, popis a cenu inzerátu. Přidejte alespoň jeden obrázek. ' +
                                  Emojis.foldedHands,
                              kWarning,
                              Icons.warning))))
            ], volume: volume)
          ])));
}
