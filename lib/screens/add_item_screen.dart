import 'package:emojis/emojis.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:letbike/screens/params_screen.dart';
import 'package:letbike/widgets/image_picker_controller.dart';
import 'package:letbike/widgets/new/button_main.dart';
import 'package:letbike/widgets/error_widgets.dart';
import 'package:letbike/widgets/new/button_main_sub.dart';
import 'package:letbike/widgets/new/page_body.dart';
import 'package:letbike/widgets/text_input.dart';
import 'package:letbike/general/settings.dart';

// ignore: must_be_immutable
class AddItem extends StatefulWidget {
  AddItem({Key? key, required User loggedUser})
      : _loggedUser = loggedUser,
        super(key: key);

  final User _loggedUser;

  @override
  _AddItem createState() => _AddItem();
}

class _AddItem extends State<AddItem> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  // TODO iOS settings - https://pub.dev/packages/image_picker
  // TODO separate thumbnail and images
  final ImagePickerController imagePickerController = ImagePickerController();
  List<XFile> images = [];

  @override
  Widget build(BuildContext context) => GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: PageBody(
          body: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
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
                  Text("První vybraný obrázek se bude zobrazovat na domovské stránce."),
                  Container(
                      child: TextButton(
                          child: Text("Vybrat fotografie (minimálně 1)"),
                          onPressed: () async => await imagePickerController.loadAssets(
                              this, images, 9, mounted, context, (List<XFile> a) => images = a))),
                  Expanded(child: Container(child: imagePickerController.buildGridView(images, 3, 50)))
                ]))
          ]),
          mainButton: MainButton(secondaryButtons: [
            MainButtonSub(icon: Icons.arrow_back, label: "Zpět", onClick: () => Navigator.of(context).pop()),
            MainButtonSub(
                icon: Icons.add,
                label: "Přidat inzerát",
                // TODO better validations on textfields = impelemt validator
                onClick: () => (images.isNotEmpty &&
                        nameController.text != "" &&
                        descController.text != "" &&
                        priceController.text != "")
                    ? Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ParamsPage(
                            loggedUser: widget._loggedUser,
                            params: [],
                            name: nameController.text,
                            desc: descController.text,
                            price: priceController.text,
                            images: images)))
                    : ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: ErrorWidgets.snackBarMessage(
                            'Vyplňte prosím název, popis a cenu inzerátu. Přidejte alespoň jeden obrázek. ' +
                                Emojis.foldedHands,
                            kWarning,
                            Icons.warning))))
          ])));
}
