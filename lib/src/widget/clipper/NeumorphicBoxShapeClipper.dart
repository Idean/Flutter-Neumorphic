import 'package:flutter/widgets.dart';

import '../../NeumorphicBoxShape.dart';
import 'CircleClipper.dart';
import 'RRectClipper.dart';

class NeumorphicBoxShapeClipper extends StatelessWidget {
  final NeumorphicBoxShape shape;
  final Widget child;

  NeumorphicBoxShapeClipper({this.shape, this.child});

  CustomClipper _getClipper(NeumorphicBoxShape shape) {
    if (shape.isCircle) {
      return CircleClipper();
    } else if (shape.isCustomShape) {
      return shape.customShapePathProvider; //NeumorphicShape is extending CustomClipper
    } else {
      return RRectClipper(borderRadius: shape.borderRadius);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: _getClipper(this.shape),
      child: child,
    );
  }
}
