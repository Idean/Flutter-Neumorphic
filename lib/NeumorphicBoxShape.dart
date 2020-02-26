import 'package:flutter/cupertino.dart';

class NeumorphicBoxShape {
  final BoxShape boxShape;
  final BorderRadius borderRadius;
  final bool _stadium;

  NeumorphicBoxShape._({this.boxShape, this.borderRadius, bool stadium = false})
      : this._stadium = stadium;

  NeumorphicBoxShape.circle() : this._(boxShape: BoxShape.circle);

  NeumorphicBoxShape.roundRect({BorderRadius borderRadius})
      : this._(boxShape: BoxShape.rectangle, borderRadius: borderRadius);

  NeumorphicBoxShape.stadium()
      : this._(
            boxShape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(1000),
            stadium: true);

  bool get isStadium => boxShape == BoxShape.rectangle && this._stadium == true;

  bool get isCircle => boxShape == BoxShape.circle;

  bool get isRoundRect =>
      boxShape == BoxShape.rectangle && this._stadium == false;

  static NeumorphicBoxShape lerp(
      NeumorphicBoxShape a, NeumorphicBoxShape b, double t) {
    assert(t != null);

    if (a == null && b == null) return null;
    if (t == 0.0) return a;
    if (t == 1.0) return b;
    if (a.boxShape != b.boxShape) return b;
    if (a.isCircle || a._stadium) return a;
    if (a == null) {
      return NeumorphicBoxShape.roundRect(
          borderRadius: BorderRadius.lerp(null, b.borderRadius, t));
    }
    if (b == null) {
      return NeumorphicBoxShape.roundRect(
          borderRadius: BorderRadius.lerp(null, a.borderRadius, t));
    }
    return NeumorphicBoxShape.roundRect(
        borderRadius: BorderRadius.lerp(a.borderRadius, b.borderRadius, t));
  }
}
