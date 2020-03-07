import 'dart:math';

import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

class CircleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    return Path()
      ..addOval(Rect.fromCircle(
        center: Offset(size.width / 2.0, size.height / 2.0),
        radius: min(size.width / 2.0, size.height / 2.0),
      ));
  }

  @override
  bool shouldReclip(CircleClipper oldClipper) => true;
}