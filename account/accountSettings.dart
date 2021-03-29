import 'dart:ui';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:flutter/material.dart';
import 'package:letbike/account/accountScreen.dart';
import 'accountChangePass.dart';
import '../general/general.dart';

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

  List<Asset> images = [];

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
      images = [];
    });

    List<Asset> resultList;
    String error;

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 1,
        enableCamera: true,
      );
    } on Exception catch (e) {
      error = e.toString();
    }
    if (!mounted) return;

    setState(() {
      images = resultList;
      if (error != null) AlertBox.showAlertBox(context, "Error", Text("Error"));
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
                    backgroundImage: images.length < 1 //images[0] == null
                        ? NetworkImage(
                            "https://www.surforma.com/media/filer_public_thumbnails/filer_public/4b/00/4b007d44-3443-4338-ada5-47d0b99db7ad/l167.jpg__800x600_q95_crop_subsampling-2_upscale.jpg")
                        : NetworkImage("url"),
                    backgroundColor: Colors.grey[400].withOpacity(0.5),
                    child: images.length < 1 //images[0] == null
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
                        height: 200,
                        decoration: BoxDecoration(
                          color: kBlack,
                          border: Border.all(
                            color: Colors.white,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Column(
                          children: [
                            Container(
                              child: TextButton(
                                child: Icon(Icons.add),
                                onPressed: loadAssets,
                              ),
                            ),
                            Expanded(
                              child: buildGridView(),
                            )
                          ],
                        )),
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
                    setState(() {
                      user.fName = getVal("accFName", user.fName);
                      user.lName = getVal("accLName", user.lName);
                      user.phone =
                          int.parse(getVal("accPhone", user.phone.toString()));
                      user.addressA = getVal("accAddA", user.addressA);
                      user.addressB = getVal("accAddB", user.addressB);
                      user.addressC = getVal("accAddC", user.addressC);
                      user.postal = int.parse(
                          getVal("accPostal", user.postal.toString()));
                    });
                    Navigator.of(context).pushReplacementNamed(
                        AccountScreen.routeName,
                        arguments: user);
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
      getVal("accFName", user.fName),
      getVal("accLName", user.lName),
      getVal("accPhone", user.phone.toString()),
      getVal("accAddA", user.addressA),
      getVal("accAddB", user.addressB),
      getVal("accAddC", user.addressC),
      getVal("accPostal", user.postal.toString()),
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

  String getVal(String textInput, String current) {
    return TextInput.getValue(textInput) != null
        ? TextInput.getValue(textInput)
        : current;
  }
}
