import 'package:flutter/material.dart';

class NeumorphicBoxDecoration extends BoxDecoration {
  NeumorphicBoxDecoration()
      : super(
    borderRadius: BorderRadius.circular(10),
    color: Color(0xffF1F2F4),
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color.lerp(
          Colors.blueGrey.shade100,
          Colors.white,
          .57,
        ),
        Color(0xffF1F2F4),
        Color(0xffF1F2F4),
        Color.lerp(
          Colors.white,
          Colors.black,
          .01,
        ),
      ],
      stops: [
        .1,
        .3,
        .7,
        1,
      ],
    ),
    boxShadow: [
      BoxShadow(
        color: Color.lerp(
          Colors.blueGrey.shade100,
          Colors.white,
          .3,
        ),
        spreadRadius: 1,
        blurRadius: 10,
        offset: Offset(4, 2),
      ),
      BoxShadow(
        color: Colors.white,
        offset: -Offset(1, 1),
      ),
      BoxShadow(
        color: Color.lerp(
          Colors.white,
          Colors.black,
          .02,
        ),
        spreadRadius: 1,
        blurRadius: 5,
        offset: -Offset(4, 2),
      ),
    ],
  );
}

class NeumorphicContainer extends Container {

  final Widget child;

  NeumorphicContainer({this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: child,
      decoration: NeumorphicBoxDecoration(),
    );
  }
}
