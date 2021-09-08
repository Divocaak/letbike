import 'package:letbike/db/dbAccount.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:flutter/material.dart';
import 'package:letbike/account/accountScreen.dart';
import 'accountChangePass.dart';
import 'package:letbike/widgets/textInput.dart';
import 'package:letbike/widgets/mainButtonEssentials.dart';
import 'package:letbike/widgets/errorWidgets.dart';
import 'package:letbike/widgets/buttonCircular.dart';
import 'package:letbike/widgets/alertBox.dart';
import 'package:letbike/general/objects.dart';
import 'package:letbike/general/pallete.dart';

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
            context, "Error", Text("Error", style: TextStyle(color: kError)));
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
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: kBlack,
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
          Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  images.length < 1
                      ? "Aktualizovat profilovou fotku"
                      : "Fotografie nahrána",
                  style: TextStyle(color: kWhite),
                ),
                CircularButton(
                    kPrimaryColor, 50, Icons.upload, kWhite, loadAssets)
              ],
            ),
            TextInput(
                icon: Icons.create,
                hint: "Křestní jméno: " + userInfo(user.fName),
                inputType: TextInputType.name,
                inputAction: TextInputAction.next,
                controller: fNameController),
            TextInput(
                icon: Icons.create,
                hint: "Příjmení: " + userInfo(user.lName),
                inputType: TextInputType.name,
                inputAction: TextInputAction.next,
                controller: lNameController),
            TextInput(
                icon: Icons.phone,
                hint: "Telefon: " + userInfo(user.phone.toString()),
                inputType: TextInputType.phone,
                inputAction: TextInputAction.next,
                controller: phoneController),
            TextInput(
                icon: Icons.home,
                hint: "Ulice a č.p.: " + userInfo(user.addressA),
                inputType: TextInputType.streetAddress,
                inputAction: TextInputAction.next,
                controller: addAController),
            TextInput(
                icon: Icons.location_city,
                hint: "Obec: " + userInfo(user.addressB),
                inputType: TextInputType.streetAddress,
                inputAction: TextInputAction.next,
                controller: addBController),
            TextInput(
                icon: Icons.flag,
                hint: "Země: " + userInfo(user.addressC),
                inputType: TextInputType.streetAddress,
                inputAction: TextInputAction.next,
                controller: addCController),
            TextInput(
                icon: Icons.email,
                hint: "PSČ: " + userInfo(user.postal.toString()),
                inputType: TextInputType.number,
                inputAction: TextInputAction.done,
                controller: postalController)
          ]),
          MainButtonClicked(buttons: [
            SecondaryButtonData(
                Icons.lock,
                () => Navigator.of(context)
                    .pushNamed(ChangePassword.routeName, arguments: user)),
            SecondaryButtonData(Icons.save, () {
              setState(() {
                saveData();
                user.fName = getVal(fNameController, user.fName);
                user.lName = getVal(lNameController, user.lName);
                user.phone =
                    int.parse(getVal(phoneController, user.phone.toString()));
                user.addressA = getVal(addAController, user.addressA);
                user.addressB = getVal(addBController, user.addressB);
                user.addressC = getVal(addCController, user.addressC);
                user.postal =
                    int.parse(getVal(postalController, user.postal.toString()));
              });
              Navigator.of(context).pushReplacementNamed(
                  AccountScreen.routeName,
                  arguments: user);
            })
          ], volume: volume)
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

    saveResponse = DatabaseAccount.changeAccountDetails(
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
              return ErrorWidgets.futureBuilderError();
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

  String userInfo(String input) {
    return (input == "-1" ? " " : input);
  }
}
