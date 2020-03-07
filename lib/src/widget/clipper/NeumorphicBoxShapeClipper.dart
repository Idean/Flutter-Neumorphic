
import 'package:flutter/widgets.dart';

import '../../NeumorphicBoxShape.dart';
import 'CircleClipper.dart';

class NeumorphicBoxShapeClipper extends StatelessWidget {
  final NeumorphicBoxShape shape;
  final Widget child;

  NeumorphicBoxShapeClipper({this.shape, this.child});

  @override
  Widget build(BuildContext context) {
    return shape.isCircle
        ? ClipPath(clipper: CircleClipper(), child: child)
        : ClipRRect(
      borderRadius: shape.borderRadius,
      child: child,
    );
  }
}
