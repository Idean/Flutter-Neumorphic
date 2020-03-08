import 'package:flutter/widgets.dart';

import '../../NeumorphicBoxShape.dart';
import 'CircleClipper.dart';
import 'RRectClipper.dart';

class NeumorphicBoxShapeClipper extends StatelessWidget {
  final NeumorphicBoxShape shape;
  final Widget child;

  NeumorphicBoxShapeClipper({this.shape, this.child});

  @override
  Widget build(BuildContext context) {
    return shape.isCircle
        ? ClipPath(clipper: CircleClipper(), child: child)
        : ClipPath(
            clipper: RRectClipper(borderRadius: shape.borderRadius),
            child: child,
          );
  }
}
