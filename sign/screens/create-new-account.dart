import 'dart:ffi';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import '../../general/pallete.dart';
import '../../general/dbServices.dart';
import '../../general/widgets.dart';

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
              "Vyberte si",
              style: kBodyText.copyWith(
                  fontWeight: FontWeight.bold, color: kPrimaryColor),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: Text(
                      "Galerie",
                      style: kBodyText,
                    ),
                    onTap: () {
                      takePhoto(ImageSource.gallery);
                    },
                  ),
                  Padding(padding: EdgeInsets.all(16)),
                  GestureDetector(
                    child: Text(
                      "Fotoaparát",
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
                      TextInput(
                        icon: FontAwesomeIcons.user,
                        hint: "Uživatelské jméno",
                        identificator: "regName",
                        inputType: TextInputType.name,
                        inputAction: TextInputAction.next,
                      ),
                      TextInput(
                        icon: FontAwesomeIcons.envelope,
                        hint: "E-mail",
                        identificator: "regMail",
                        inputType: TextInputType.emailAddress,
                        inputAction: TextInputAction.next,
                      ),
                      TextInput(
                        icon: FontAwesomeIcons.lock,
                        hint: "Heslo",
                        identificator: "regPass",
                        inputAction: TextInputAction.next,
                      ),
                      TextInput(
                        icon: FontAwesomeIcons.lock,
                        hint: "Potvrdit heslo",
                        identificator: "regPassConf",
                        inputAction: TextInputAction.done,
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      RegRoundedButton(buttonName: "Registrovat"),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Už máte účet?  ", style: kBodyText),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              "Přihlaste se",
                              style: kBodyText.copyWith(
                                  color: kPrimaryColor,
                                  fontWeight: FontWeight.bold),
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
          borderRadius: BorderRadius.circular(16), color: kPrimaryColor),
      child: TextButton(
        onPressed: () {
          String failResponse = "";

          if (_regformkey.currentState.validate()) {
            response = DatabaseServices.registerUser(
                TextInput.getValue("regName"),
                TextInput.getValue("regMail"),
                TextInput.getValue("regPass"));
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
