import 'dart:ui';
import 'package:flutter/material.dart';
import '../pallete.dart';

class CircularButton extends StatelessWidget {
  final double width;
  final double heigt;
  final Color color;
  final Icon icon;
  final Function onClick;

  double getRadiansFromDegree(double degree) {
    double unitRadian = 57.295779513;
    return degree / unitRadian;
  }

  void initButton(AnimationController animationController,
      List<Animation> degTranslationAnimation, Animation rotationAnimation) {
    animationController =
        AnimationController(duration: Duration(milliseconds: 250), vsync: this);

    degTranslationAnimation[0] = TweenSequence([
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 1.2), weight: 75.0),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.2, end: 1.0), weight: 25.0)
    ]).animate(animationController);

    degTranslationAnimation[1] = TweenSequence([
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 1.4), weight: 55.0),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.4, end: 1.0), weight: 45.0)
    ]).animate(animationController);

    degTranslationAnimation[0] = TweenSequence([
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 1.75), weight: 35.0),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.75, end: 1.0), weight: 65.0)
    ]).animate(animationController);

    rotationAnimation = Tween<double>(begin: 180.0, end: 0.0).animate(
        CurvedAnimation(parent: animationController, curve: Curves.easeOut));
  }

  CircularButton({this.color, this.width, this.heigt, this.icon, this.onClick});

  Widget createSubButton(
      double offset,
      Animation degTranslationAnimation,
      Animation rotationAnimation,
      Color color,
      double size,
      IconData icon,
      Color iconColor,
      Function onClick) {
    return Transform.translate(
      offset: Offset.fromDirection(
          getRadiansFromDegree(offset), degTranslationAnimation.value * 100),
      child: Transform(
          transform:
              Matrix4.rotationZ(getRadiansFromDegree(rotationAnimation.value))
                ..scale(degTranslationAnimation.value),
          alignment: Alignment.center,
          child: createButton(color, size, icon, iconColor, onClick)),
    );
  }

  Widget createButton(Color color, double size, IconData icon, Color iconColor,
      Function onClick) {
    return CircularButton(
      color: color,
      width: size,
      heigt: size,
      icon: Icon(icon, color: iconColor),
      onClick: onClick,
    );
  }

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
