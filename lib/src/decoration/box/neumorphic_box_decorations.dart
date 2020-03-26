import 'dart:ui';

import 'package:flutter/widgets.dart';

import '../../NeumorphicBoxShape.dart';
import 'painter/neumorphic_box_decoration_painter.dart';

import 'painter/neumorphic_emboss_box_decoration_painter.dart';
export 'painter/neumorphic_emboss_box_decoration_painter.dart';

@immutable
class NeumorphicBoxDecoration extends Decoration {
  final NeumorphicStyle style;
  final NeumorphicBoxShape shape;
  final bool splitBackgroundForeground;

  const NeumorphicBoxDecoration(
      {@required this.style,
      @required this.splitBackgroundForeground,
      @required this.shape});

  @override
  BoxPainter createBoxPainter([onChanged]) {
    if (style.depth >= 0) {
      return NeumorphicBoxDecorationPainter(
        drawGradient: !splitBackgroundForeground,
        style: style,
        onChanged: onChanged,
        shape: shape,
      );
    } else {
      //print("emboss : $accent");
      return NeumorphicEmbossBoxDecorationPainter(
        drawShadow: !splitBackgroundForeground,
        style: style,
        onChanged: onChanged,
        shape: shape,
      );
    }
  }

  @override
  NeumorphicBoxDecoration lerpFrom(Decoration a, double t) {
    if (a == null) return scale(t);
    if (a is NeumorphicBoxDecoration)
      return NeumorphicBoxDecoration.lerp(a, this, t);
    return super.lerpFrom(a, t) as NeumorphicBoxDecoration;
  }

  @override
  NeumorphicBoxDecoration lerpTo(Decoration b, double t) {
    if (b == null) return scale(1.0 - t);
    if (b is NeumorphicBoxDecoration)
      return NeumorphicBoxDecoration.lerp(this, b, t);
    return super.lerpTo(b, t) as NeumorphicBoxDecoration;
  }

  NeumorphicBoxDecoration scale(double factor) {
    return NeumorphicBoxDecoration(
        splitBackgroundForeground: this.splitBackgroundForeground,
        shape: NeumorphicBoxShape.lerp(null, shape, factor),
        style: style.copyWith());
  }

  static NeumorphicBoxDecoration lerp(
      NeumorphicBoxDecoration a, NeumorphicBoxDecoration b, double t) {
    assert(t != null);

    if (a == null && b == null) return null;
    if (a == null) return b.scale(t);
    if (b == null) return a.scale(1.0 - t);
    if (t == 0.0) return a;
    if (t == 1.0) return b;
    if (a.shape.boxShape != b.shape.boxShape) return b;

    var aStyle = a.style;
    var bStyle = b.style;

    return NeumorphicBoxDecoration(
        shape: NeumorphicBoxShape.lerp(a.shape, b.shape, t),
        splitBackgroundForeground: a.splitBackgroundForeground,
        style: a.style.copyWith(
          intensity: lerpDouble(aStyle.intensity, bStyle.intensity, t),
          depth: lerpDouble(aStyle.depth, bStyle.depth, t),
          color: Color.lerp(aStyle.color, bStyle.color, t),
          lightSource:
              LightSource.lerp(aStyle.lightSource, bStyle.lightSource, t),
        ));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NeumorphicBoxDecoration &&
          runtimeType == other.runtimeType &&
          //accent == other.accent &&
          style == other.style &&
          shape == other.shape;

  @override
  bool get isComplex => true;

  @override
  int get hashCode => style.hashCode ^ shape.hashCode;
}
