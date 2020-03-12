import 'dart:ui';

import 'package:flutter/widgets.dart';

import '../../NeumorphicBoxShape.dart';
import 'painter/neumorphic_emboss_foreground_decoration_painter.dart';
import 'painter/neumorphic_foreground_decoration_painter.dart';


@immutable
class NeumorphicForegroundDecoration extends Decoration {
  final NeumorphicStyle style;
  final NeumorphicBoxShape shape;
  final bool splitBackgroundForeground;

  const NeumorphicForegroundDecoration({@required this.style, @required this.splitBackgroundForeground, @required this.shape});

  @override
  BoxPainter createBoxPainter([onChanged]) {
    if (style.depth >= 0) {
      return NeumorphicForegroundDecorationPainter(
        style: style,
        enabled: splitBackgroundForeground,
        onChanged: onChanged,
        shape: shape,
      );
    } else {
      return NeumorphicEmbossForegroundDecorationPainter(
        style: style,
        enabled: splitBackgroundForeground,
        onChanged: onChanged,
        shape: shape,
      );
    }
  }

  @override
  NeumorphicForegroundDecoration lerpFrom(Decoration a, double t) {
    if (a == null) return scale(t);
    if (a is NeumorphicForegroundDecoration) return NeumorphicForegroundDecoration.lerp(a, this, t);
    return super.lerpFrom(a, t) as NeumorphicForegroundDecoration;
  }

  @override
  NeumorphicForegroundDecoration lerpTo(Decoration b, double t) {
    if (b == null) return scale(1.0 - t);
    if (b is NeumorphicForegroundDecoration) return NeumorphicForegroundDecoration.lerp(this, b, t);
    return super.lerpTo(b, t) as NeumorphicForegroundDecoration;
  }

  NeumorphicForegroundDecoration scale(double factor) {
    return NeumorphicForegroundDecoration(
        splitBackgroundForeground: this.splitBackgroundForeground,
        shape: NeumorphicBoxShape.lerp(null, shape, factor),
        style: style.copyWith());
  }

  static NeumorphicForegroundDecoration lerp(NeumorphicForegroundDecoration a, NeumorphicForegroundDecoration b, double t) {
    assert(t != null);

    //print("t : ${t}");
    //print("a ${a.style}");
    //print("b ${b.style}");

    if (a == null && b == null) return null;
    if (a == null) return b.scale(t);
    if (b == null) return a.scale(1.0 - t);
    if (t == 0.0) return a;
    if (t == 1.0) return b;
    if (a.shape.boxShape != b.shape.boxShape) return b;

    var aStyle = a.style;
    var bStyle = b.style;

    //print("aColor: ${aStyle.color} bColor: ${bStyle.color} lerp: ${Color.lerp(aStyle.color, bStyle.color, t)}");

    return NeumorphicForegroundDecoration(
        shape: NeumorphicBoxShape.lerp(a.shape, b.shape, t),
        splitBackgroundForeground: a.splitBackgroundForeground,
        style: a.style.copyWith(
          intensity: lerpDouble(aStyle.intensity, bStyle.intensity, t),
          surfaceIntensity: lerpDouble(aStyle.surfaceIntensity, bStyle.surfaceIntensity, t),
          depth: lerpDouble(aStyle.depth, bStyle.depth, t),
          color: Color.lerp(aStyle.color, bStyle.color, t),
          lightSource: LightSource.lerp(aStyle.lightSource, bStyle.lightSource, t),
        ));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NeumorphicForegroundDecoration &&
          runtimeType == other.runtimeType &&
          style == other.style &&
          shape == other.shape;

  @override
  int get hashCode =>
      style.hashCode ^
      shape.hashCode;

}
