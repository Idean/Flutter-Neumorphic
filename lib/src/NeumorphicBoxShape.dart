import 'package:flutter/widgets.dart';

/// Define a Neumorphic container box shape
///
/// default used : NeumorphicBoxShape.roundRect();
///
/// @see Neumorphic
///
/// Neumorphic(
///   boxShape: NeumorphicBoxShape.cicle()
///   style: ...
///   child: ...
/// )
///
/// it can be for now :
///
/// A CIRLCE : NeumorphicBoxShape.circle()
///
/// A ROUND_RECT : NeumorphicBoxShape.roundRect(BorderRadius.circular(12));
///
/// A STADIUM :  NeumorphicBoxShape.stadium();
///                                                             _______
/// a stadium is a roundrect with two circles on both side :   (       )
///                                                             ‾‾‾‾‾‾‾
///
///

abstract class NeumorphicPathProvider extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    return getPath(size);
  }

  Path getPath(Size size);

  @override
  bool shouldReclip(NeumorphicPathProvider oldClipper) {
    return false;
  }
}

//class to try
class MyNeumorphicTrianglePathProvider extends NeumorphicPathProvider {
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

class NeumorphicBoxShape {
  final BoxShape boxShape;
  final BorderRadius borderRadius;
  final bool _stadium;
  final NeumorphicPathProvider
      customShapePathProvider; //nullable, only set if using path

  const NeumorphicBoxShape._(
      {this.boxShape,
      this.borderRadius,
      bool stadium = false,
      this.customShapePathProvider})
      : this._stadium = stadium;

  const NeumorphicBoxShape.circle() : this._(boxShape: BoxShape.circle);

  const NeumorphicBoxShape.path(NeumorphicPathProvider pathProvider)
      : this._(customShapePathProvider: pathProvider);

  const NeumorphicBoxShape.roundRect(
      {BorderRadius borderRadius = BorderRadius.zero})
      : this._(boxShape: BoxShape.rectangle, borderRadius: borderRadius);

  ///                                                             _______
  /// a stadium is a roundrect with two circles on both side :   (       )
  ///                                                             ‾‾‾‾‾‾‾
  NeumorphicBoxShape.stadium()
      : this._(
            boxShape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(
                1000), //we handle this directly inside the neumorphic box decorator
            stadium: true);

  bool get isCustomShape => customShapePathProvider != null;

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
    if (b.isCustomShape) return b;
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
