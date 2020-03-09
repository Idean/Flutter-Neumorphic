import 'dart:ui';

import '../../shape.dart';

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
  final double depth;
  final NeumorphicShape shape;

  NeumorphicBorder({
    this.color,
    this.width,
    this.depth = 5,
    this.shape = NeumorphicShape.convex,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is NeumorphicBorder &&
              runtimeType == other.runtimeType &&
              color == other.color &&
              width == other.width &&
              depth == other.depth &&
              shape == other.shape;

  @override
  int get hashCode =>
      color.hashCode ^
      width.hashCode ^
      depth.hashCode ^
      shape.hashCode;
}