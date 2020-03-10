import 'dart:ui';

import '../../shape.dart';
import '../container.dart';

///
/// Work in progress
/// Add a border inside a [Neumorphic] container
/// The NeumorphicBorder code can changes over time
///
/// Works fine with NeumorphicBoxShape.circle & NeumorphicBoxShape.stadium
/// For roundrect, setting it will works, but updating the width will sometimes don't work
///
class NeumorphicBorder {
  final Color color;
  final double width;
  final double _intensity;
  final double _depth;
  final NeumorphicShape shape;

  NeumorphicBorder({
    this.color,
    this.width,
    double depth = 5,
    double intensity,
    this.shape = NeumorphicShape.convex,
  }) : this._depth = depth, this._intensity = intensity;

  double get depth => _depth?.clamp(Neumorphic.MIN_DEPTH, Neumorphic.MAX_DEPTH);

  double get intensity =>
      _intensity?.clamp(Neumorphic.MIN_INTENSITY, Neumorphic.MAX_INTENSITY);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is NeumorphicBorder &&
              runtimeType == other.runtimeType &&
              color == other.color &&
              width == other.width &&
              _intensity == other._intensity &&
              _depth == other._depth &&
              shape == other.shape;

  @override
  int get hashCode =>
      color.hashCode ^
      width.hashCode ^
      _intensity.hashCode ^
      _depth.hashCode ^
      shape.hashCode;



}