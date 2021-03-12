import 'dart:ffi';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import '../pallete.dart';
import '../widgets.dart';
import '../alertBox.dart';
import '../../dbServices.dart';

GlobalKey<FormState> _regformkey = GlobalKey<FormState>();
TextEditingController _password = TextEditingController();
TextEditingController _confirmpassword = TextEditingController();

class CreateNewAccount extends StatefulWidget {
  @override
  _CreateNewAccountState createState() => _CreateNewAccountState();
}

class _CreateNewAccountState extends State<CreateNewAccount> {
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

  Future<Void> _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            elevation: 0,
            backgroundColor: Colors.black,
            title: Text(
              "Make a choice",
              style: kBodyText.copyWith(
                  fontWeight: FontWeight.bold, color: Colors.green),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: Text(
                      "Gallery",
                      style: kBodyText,
                    ),
                    onTap: () {
                      takePhoto(ImageSource.gallery);
                    },
                  ),
                  Padding(padding: EdgeInsets.all(16)),
                  GestureDetector(
                    child: Text(
                      "Camera",
                      style: kBodyText,
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

  String asd;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Stack(
      children: [
        BackgroundImage(
            image:
                'https://mtbs.cz/media/clanky/63713/titulka/1_Qayron_perex.jpg'),
        Form(
          key: _regformkey,
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: size.width * 0.2,
                  ),
                  Container(
                    width: size.width * 0.25,
                    height: size.width * 0.25,
                    child: Stack(
                      fit: StackFit.expand,
                      children: <Widget>[
                        Center(
                          child: ClipOval(
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                              child: Stack(
                                children: <Widget>[
                                  CircleAvatar(
                                    backgroundImage: _imageFile == null
                                        ? NetworkImage(
                                            "https://www.surforma.com/media/filer_public_thumbnails/filer_public/4b/00/4b007d44-3443-4338-ada5-47d0b99db7ad/l167.jpg__800x600_q95_crop_subsampling-2_upscale.jpg")
                                        : FileImage(File(_imageFile.path)),
                                    radius: size.width * 0.14,
                                    backgroundColor:
                                        Colors.grey[400].withOpacity(0.5),
                                    child: _imageFile == null
                                        ? Icon(
                                            FontAwesomeIcons.user,
                                            color: kWhite,
                                            size: size.width * 0.1,
                                          )
                                        : Container(),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            _showChoiceDialog(context);
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: size.width * 0.1,
                  ),
                  Column(
                    children: [
                      TextInputField(
                        icon: FontAwesomeIcons.user,
                        hint: "Name",
                        inputType: TextInputType.name,
                        inputAction: TextInputAction.next,
                      ),
                      TextInputField(
                        icon: FontAwesomeIcons.envelope,
                        hint: "Email",
                        inputType: TextInputType.emailAddress,
                        inputAction: TextInputAction.next,
                      ),
                      RegPasswordInput(
                        icon: FontAwesomeIcons.lock,
                        hint: "Password",
                        inputAction: TextInputAction.next,
                        controller: _password,
                      ),
                      RegPasswordInput(
                        icon: FontAwesomeIcons.lock,
                        hint: "Confirm Password",
                        inputAction: TextInputAction.done,
                        controller: _confirmpassword,
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      RegRoundedButton(buttonName: "Register"),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Aleready have an account?", style: kBodyText),
                          GestureDetector(
                            onTap: () {
                              Navigator.popAndPushNamed(context, "/");
                            },
                            child: Text(
                              "Login",
                              style: kBodyText.copyWith(
                                  color: kGreen, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

Future<String> response;

class RegRoundedButton extends StatelessWidget {
  const RegRoundedButton({
    Key key,
    @required this.buttonName,
  }) : super(key: key);

  final String buttonName;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.08,
      width: size.width * 0.8,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16), color: Colors.green),
      child: TextButton(
        onPressed: () {
          String failResponse = "";

          if (_regformkey.currentState.validate()) {
            response = DatabaseServices.registerUser(
                TextInputField.getValue("Name"),
                TextInputField.getValue("Email"),
                RegPasswordInput.getValue("Password"));
          } else {
            failResponse = "Některé údaje jsou špatně zadané.";
          }

          AlertBox.showAlertBox(
              context,
              "Oznámení",
              failResponse != ""
                  ? new Text(failResponse)
                  : FutureBuilder(
                      future: response,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          print("hasData");
                          return Text(snapshot.data);
                        }

                        if (snapshot.hasError) {
                          print("hasError");
                          return Text(
                              "Někde se stala chyba, zkuste to prosím později");
                        }

                        return Center(child: CircularProgressIndicator());
                      }));
        },
        child: Text(
          buttonName,
          style: kBodyText.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
