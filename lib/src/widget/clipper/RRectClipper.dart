import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

class RRectClipper extends CustomClipper<Path> {
  final BorderRadius borderRadius;

  RRectClipper({this.borderRadius});

  @override
  Path getClip(Size size) {
    final rect = Rect.fromLTRB(0, 0, size.width, size.height);
    final rrect = RRect.fromRectAndRadius(rect, borderRadius.topLeft);
    return Path()..addRRect(rrect);
  }

  @override
  bool shouldReclip(RRectClipper oldClipper) => true;
}
