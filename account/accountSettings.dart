import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'accountChangePass.dart';
import '../general/pallete.dart';
import '../general/dbServices.dart';
import '../general/widgets.dart';

double volume = 0;

class AccountSettings extends StatefulWidget {
  @override
  _AccountSettingsState createState() => _AccountSettingsState();
  static const routeName = "/accountSettings";
}

Future<String> saveResponse;
List<String> fieldsValues;

class _AccountSettingsState extends State<AccountSettings>
    with SingleTickerProviderStateMixin {
  User user;

  AnimationController animationController;

  PickedFile _imageFile;
  final ImagePicker _picker = ImagePicker();

  void takePhoto(ImageSource source) async {
    final pickedFile = await _picker.getImage(
      source: source,
    );
    setState(() {
      _imageFile = pickedFile;
      Navigator.of(context).pop();
    });
  }

  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            elevation: 0,
            backgroundColor: Colors.black,
            title: Text(
              "Make a choice",
              style: kTitleTextStyle.copyWith(
                  fontWeight: FontWeight.bold, color: Colors.green),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: Text(
                      "Gallery",
                      style: kTitleTextStyle,
                    ),
                    onTap: () {
                      takePhoto(ImageSource.gallery);
                    },
                  ),
                  Padding(padding: EdgeInsets.all(16)),
                  GestureDetector(
                    child: Text(
                      "Camera",
                      style: kTitleTextStyle,
                    ),
                    onTap: () {
                      takePhoto(ImageSource.camera);
                    },
                  )
                ],
              ),
            ),
          );
        });
  }

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
    user = ModalRoute.of(context).settings.arguments;
    Size size = MediaQuery.of(context).size;
    var profileInfo = Expanded(
      child: Column(
        children: <Widget>[
          Center(
            child: Container(
              height: 100,
              width: 100,
              margin: EdgeInsets.only(top: 30),
              child: Stack(
                children: <Widget>[
                  CircleAvatar(
                    radius: 70,
                    backgroundImage: _imageFile == null
                        ? NetworkImage(
                            "https://www.surforma.com/media/filer_public_thumbnails/filer_public/4b/00/4b007d44-3443-4338-ada5-47d0b99db7ad/l167.jpg__800x600_q95_crop_subsampling-2_upscale.jpg")
                        : FileImage(File(_imageFile.path)),
                    backgroundColor: Colors.grey[400].withOpacity(0.5),
                    child: _imageFile == null
                        ? Icon(
                            Icons.person,
                            color: Colors.white,
                            size: 30,
                          )
                        : Container(),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      height: 25,
                      width: 25,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                      child: GestureDetector(
                        onTap: () {
                          _showChoiceDialog(context);
                        },
                        child: Center(
                          heightFactor: 15,
                          widthFactor: 15,
                          child: Icon(
                            Icons.create,
                            color: Colors.white,
                            size: 15,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );

    var header = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        profileInfo,
      ],
    );

    return new Scaffold(
        body: Stack(children: [
      Scaffold(
        backgroundColor: kBlack,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: size.width * 0.1,
              ),
              header,
              Column(
                children: [
                  TextInput(
                    icon: Icons.create,
                    hint: "Křestní jméno: " + user.fName,
                    identificator: "accFName",
                    inputType: TextInputType.name,
                    inputAction: TextInputAction.next,
                  ),
                  TextInput(
                    icon: Icons.create,
                    hint: "Příjmení: " + user.lName,
                    identificator: "accLName",
                    inputType: TextInputType.name,
                    inputAction: TextInputAction.next,
                  ),
                  TextInput(
                    icon: Icons.phone,
                    hint: "Telefon: " + user.phone.toString(),
                    identificator: "accPhone",
                    inputAction: TextInputAction.next,
                    inputType: TextInputType.phone,
                  ),
                  TextInput(
                    icon: Icons.home,
                    hint: "Ulice a č.p.: " + user.addressA,
                    identificator: "accAddA",
                    inputAction: TextInputAction.next,
                    inputType: TextInputType.streetAddress,
                  ),
                  TextInput(
                    icon: Icons.location_city,
                    hint: "Obec: " + user.addressB,
                    identificator: "accAddB",
                    inputAction: TextInputAction.next,
                    inputType: TextInputType.streetAddress,
                  ),
                  TextInput(
                    icon: Icons.flag,
                    hint: "Země: " + user.addressC,
                    identificator: "accAddC",
                    inputAction: TextInputAction.next,
                    inputType: TextInputType.streetAddress,
                  ),
                  TextInput(
                      icon: Icons.email,
                      hint: "PSČ: " + user.postal.toString(),
                      identificator: "accPostal",
                      inputAction: TextInputAction.done,
                      inputType: TextInputType.number),
                  SizedBox(
                    height: 25,
                  ),
                ],
              )
            ],
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
                  bottom: 40,
                  right: 150,
                  child: CircularButton(kSecondaryColor.withOpacity(volume * 2),
                      45, Icons.lock, kWhite.withOpacity(volume * 2), () {
                    Navigator.of(context)
                        .pushNamed(ChangePassword.routeName, arguments: user);
                  })),
              Positioned(
                  bottom: 120,
                  right: 120,
                  child: CircularButton(kSecondaryColor.withOpacity(volume * 2),
                      45, Icons.arrow_back, kWhite.withOpacity(volume * 2), () {
                    Navigator.of(context).pop();
                  })),
              Positioned(
                  bottom: 150,
                  right: 40,
                  child: CircularButton(kSecondaryColor.withOpacity(volume * 2),
                      45, Icons.save, kWhite.withOpacity(volume * 2), () {
                    saveData();
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
    ]));
  }

  void saveData() {
    fieldsValues = [
      TextInput.getValue("accFName") != null
          ? TextInput.getValue("accFName")
          : user.fName,
      TextInput.getValue("accLName") != null
          ? TextInput.getValue("accLName")
          : user.lName,
      TextInput.getValue("accPhone") != null
          ? TextInput.getValue("accPhone")
          : user.phone.toString(),
      TextInput.getValue("accAddA") != null
          ? TextInput.getValue("accAddA")
          : user.addressA,
      TextInput.getValue("accAddB") != null
          ? TextInput.getValue("accAddB")
          : user.addressB,
      TextInput.getValue("accAddC") != null
          ? TextInput.getValue("accAddC")
          : user.addressC,
      TextInput.getValue("accPostal") != null
          ? TextInput.getValue("accPostal")
          : user.postal.toString()
    ];

    saveResponse =
        DatabaseServices.changeAccountDetails(user.id.toString(), fieldsValues);

    AlertBox.showAlertBox(
        context,
        "Oznámení",
        FutureBuilder<String>(
          future: saveResponse,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(snapshot.data);
            } else if (snapshot.hasError) {
              return Text('Sorry there is an error');
            }
            return Center(child: CircularProgressIndicator());
          },
        ));
  }
}
