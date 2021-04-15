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

  final TextEditingController fNameController = TextEditingController();
  final TextEditingController lNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addAController = TextEditingController();
  final TextEditingController addBController = TextEditingController();
  final TextEditingController addCController = TextEditingController();
  final TextEditingController postalController = TextEditingController();

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
      images = resultList.length < 1 ? [] : resultList;
      if (error != null)
        AlertBox.showAlertBox(
            context, "Error", Text("Error", style: TextStyle(color: kWhite)));
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
                  Text(
                    images.length < 1
                        ? "Aktualizovat profilovou fotku"
                        : "Fotografie nahrána",
                    style: TextStyle(color: kWhite),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          color: kPrimaryColor,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Column(
                          children: [
                            Container(
                              child: TextButton(
                                child: Icon(
                                  Icons.upload_rounded,
                                  color: kWhite,
                                ),
                                onPressed: loadAssets,
                              ),
                            ),
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
                      inputType: TextInputType.name,
                      inputAction: TextInputAction.next,
                      controller: fNameController),
                  TextInput(
                      icon: Icons.create,
                      hint: "Příjmení: " + user.lName,
                      inputType: TextInputType.name,
                      inputAction: TextInputAction.next,
                      controller: lNameController),
                  TextInput(
                      icon: Icons.phone,
                      hint: "Telefon: " + user.phone.toString(),
                      inputType: TextInputType.phone,
                      inputAction: TextInputAction.next,
                      controller: phoneController),
                  TextInput(
                      icon: Icons.home,
                      hint: "Ulice a č.p.: " + user.addressA,
                      inputType: TextInputType.streetAddress,
                      inputAction: TextInputAction.next,
                      controller: addAController),
                  TextInput(
                      icon: Icons.location_city,
                      hint: "Obec: " + user.addressB,
                      inputType: TextInputType.streetAddress,
                      inputAction: TextInputAction.next,
                      controller: addBController),
                  TextInput(
                      icon: Icons.flag,
                      hint: "Země: " + user.addressC,
                      inputType: TextInputType.streetAddress,
                      inputAction: TextInputAction.next,
                      controller: addCController),
                  TextInput(
                      icon: Icons.email,
                      hint: "PSČ: " + user.postal.toString(),
                      inputType: TextInputType.number,
                      inputAction: TextInputAction.done,
                      controller: postalController),
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
                      user.fName = getVal(fNameController, user.fName);
                      user.lName = getVal(lNameController, user.lName);
                      user.phone = int.parse(
                          getVal(phoneController, user.phone.toString()));
                      user.addressA = getVal(addAController, user.addressA);
                      user.addressB = getVal(addBController, user.addressB);
                      user.addressC = getVal(addCController, user.addressC);
                      user.postal = int.parse(
                          getVal(postalController, user.postal.toString()));
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
      getVal(fNameController, user.fName),
      getVal(lNameController, user.lName),
      getVal(phoneController, user.phone.toString()),
      getVal(addAController, user.addressA),
      getVal(addBController, user.addressB),
      getVal(addCController, user.addressC),
      getVal(postalController, user.postal.toString()),
    ];

    saveResponse = DatabaseServices.changeAccountDetails(
        user.id.toString(), fieldsValues, images);

    AlertBox.showAlertBox(
        context,
        "Oznámení",
        FutureBuilder<String>(
          future: saveResponse,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(snapshot.data, style: TextStyle(color: kWhite));
            } else if (snapshot.hasError) {
              return Text('Sorry there is an error',
                  style: TextStyle(color: kWhite));
            }
            return Center(child: CircularProgressIndicator());
          },
        ));
  }

  String getVal(TextEditingController controller, String current) {
    return (controller.text != null && controller.text != "")
        ? controller.text
        : current;
  }
}
