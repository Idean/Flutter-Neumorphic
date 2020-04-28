import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class TestNeumorphicTrianglePathProvider extends NeumorphicPathProvider {
  @override
  bool shouldReclip(NeumorphicPathProvider oldClipper) {
    return true;
  }

  @override
  Path getPath(Size size) {
    return Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, 0)
      ..lineTo(0, size.height)
      ..close();
  }
}

class TestNeumorphicArcPathProvider extends NeumorphicPathProvider {
  @override
  bool shouldReclip(NeumorphicPathProvider oldClipper) {
    return true;
  }

  @override
  Path getPath(Size size) {
    return Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, 0)
      ..arcToPoint(Offset(size.width, size.height * 0.5),
          radius: Radius.circular(20), clockwise: false)
      ..arcToPoint(Offset(0, size.height * 0.5),
          radius: Radius.circular(9), clockwise: true)
      ..arcToPoint(Offset(0, 0), radius: Radius.circular(1), clockwise: false)
      ..close();
  }
}
