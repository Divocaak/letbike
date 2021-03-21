import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'constants.dart';
import 'widgets/text-input-field.dart';

double volume = 0;

class ProfileInfo extends StatefulWidget {
  @override
  _ProfileInfoState createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation degOneTranslationAnimation,
      degTwoTranslationAnimation,
      degThreeTranslationAnimation;
  Animation rotationAnimation;

  double getRadiansFromDegree(double degree) {
    double unitRadian = 57.295779513;
    return degree / unitRadian;
  }

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
    degOneTranslationAnimation = TweenSequence([
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 1.2), weight: 75.0),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.2, end: 1.0), weight: 25.0)
    ]).animate(animationController);
    degTwoTranslationAnimation = TweenSequence([
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 1.4), weight: 55.0),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.4, end: 1.0), weight: 45.0)
    ]).animate(animationController);
    degThreeTranslationAnimation = TweenSequence([
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 1.75), weight: 35.0),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.75, end: 1.0), weight: 65.0)
    ]).animate(animationController);
    rotationAnimation = Tween<double>(begin: 180.0, end: 0.0).animate(
        CurvedAnimation(parent: animationController, curve: Curves.easeOut));
    super.initState();
    animationController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
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
                            FontAwesomeIcons.user,
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
          Container(
            height: 40,
            width: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.green,
            ),
            child: Center(
              child: Text(
                'Upgrade to PRO',
                style: kButtonTextStyle,
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
          backgroundColor: kDarkPrimaryColor,
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: size.width * 0.1,
                ),
                header,
                Column(
                  children: [
                    TextInputField(
                      icon: Icons.create,
                      hint: "First Name",
                      inputType: TextInputType.name,
                      inputAction: TextInputAction.next,
                    ),
                    TextInputField(
                      icon: Icons.create,
                      hint: "Last Name",
                      inputType: TextInputType.name,
                      inputAction: TextInputAction.next,
                    ),
                    TextInputField(
                      icon: Icons.phone,
                      hint: "Phone Number",
                      inputAction: TextInputAction.next,
                      inputType: TextInputType.phone,
                    ),
                    TextInputField(
                      icon: Icons.home,
                      hint: "Address 1",
                      inputAction: TextInputAction.next,
                      inputType: TextInputType.streetAddress,
                    ),
                    TextInputField(
                      icon: Icons.location_city,
                      hint: "Address 2",
                      inputAction: TextInputAction.next,
                      inputType: TextInputType.streetAddress,
                    ),
                    TextInputField(
                      icon: Icons.flag,
                      hint: "Address 3",
                      inputAction: TextInputAction.next,
                      inputType: TextInputType.streetAddress,
                    ),
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
          ignoring: animationController.isCompleted ? false : true,
          child: Container(
            color: Colors.black.withOpacity(volume),
          ),
        ),

        //Button
        Stack(
          children: <Widget>[
            Positioned(
                right: 30,
                bottom: 30,
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: <Widget>[
                    IgnorePointer(
                      ignoring: animationController.isCompleted ? true : false,
                      child: Container(
                        color: Colors.transparent,
                        height: 150,
                        width: 150,
                      ),
                    ),
                    Transform.translate(
                      offset: Offset.fromDirection(getRadiansFromDegree(270),
                          degOneTranslationAnimation.value * 100),
                      child: Transform(
                        transform: Matrix4.rotationZ(
                            getRadiansFromDegree(rotationAnimation.value))
                          ..scale(degOneTranslationAnimation.value),
                        alignment: Alignment.center,
                        child: _CircularButton(
                          color: Colors.green,
                          width: 50,
                          heigt: 50,
                          icon: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                          onClick: () {
                            Navigator.popAndPushNamed(
                                context, "Profile_screen");
                            animationController.reverse();
                            volume = 0;
                          },
                        ),
                      ),
                    ),
                    Transform.translate(
                      offset: Offset.fromDirection(getRadiansFromDegree(225),
                          degTwoTranslationAnimation.value * 100),
                      child: Transform(
                        transform: Matrix4.rotationZ(
                            getRadiansFromDegree(rotationAnimation.value))
                          ..scale(degTwoTranslationAnimation.value),
                        alignment: Alignment.center,
                        child: _CircularButton(
                          color: Colors.green,
                          width: 50,
                          heigt: 50,
                          icon: Icon(
                            Icons.save,
                            color: Colors.white,
                          ),
                          onClick: () {},
                        ),
                      ),
                    ),
                    /*Transform.translate(
                          offset: Offset.fromDirection(getRadiansFromDegree(180),
                              degThreeTranslationAnimation.value * 100),
                          child: Transform(
                            transform: Matrix4.rotationZ(
                                getRadiansFromDegree(rotationAnimation.value))
                              ..scale(degThreeTranslationAnimation.value),
                            alignment: Alignment.center,
                            child: _CircularButton(
                              color: Colors.green,
                              width: 50,
                              heigt: 50,
                              icon: Icon(
                                Icons.person,
                                color: Colors.white,
                              ),
                              onClick: () {},
                            ),
                          ),
                        ),*/
                    _CircularButton(
                      color: Colors.greenAccent,
                      width: 60,
                      heigt: 60,
                      icon: Icon(
                        Icons.menu,
                        color: Colors.black,
                      ),
                      onClick: () {
                        if (animationController.isCompleted) {
                          animationController.reverse();
                          volume = 0;
                        } else {
                          animationController.forward();
                          volume = 0.5;
                        }
                      },
                    ),
                  ],
                ))
          ],
        )
      ]),
    );
  }
}

class _CircularButton extends StatelessWidget {
  final double width;
  final double heigt;
  final Color color;
  final Icon icon;
  final Function onClick;

  _CircularButton(
      {this.color, this.width, this.heigt, this.icon, this.onClick});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      width: width,
      height: heigt,
      child: IconButton(
        icon: icon,
        enableFeedback: true,
        onPressed: onClick,
      ),
    );
  }
}
