import 'dart:ui';

import 'package:flutter/widgets.dart';

import '../neumorphic_box_shape.dart';
import 'neumorphic_decoration_painter.dart';
import 'neumorphic_emboss_decoration_painter.dart';

@immutable
class NeumorphicDecoration extends Decoration {
  final NeumorphicStyle style;
  final NeumorphicBoxShape shape;
  final bool splitBackgroundForeground;
  final bool renderingByPath;
  final bool isForeground;

  NeumorphicDecoration({
    @required this.style,
    @required this.isForeground,
    @required this.renderingByPath,
    @required this.splitBackgroundForeground,
    @required this.shape,
  });

  @override
  BoxPainter createBoxPainter([onChanged]) {
    //print("createBoxPainter : ${style.depth}");
    if (style.depth >= 0) {
      return NeumorphicDecorationPainter(
        style: style,
        drawGradient: (isForeground && splitBackgroundForeground) ||
            (!isForeground && !splitBackgroundForeground),
        drawBackground: !isForeground,
        //only box draw background
        drawShadow: !isForeground,
        //only box draw shadow
        renderingByPath: this.renderingByPath,
        onChanged: onChanged,
        shape: shape,
      );
    } else {
      return NeumorphicEmbossDecorationPainter(
        drawBackground: !isForeground,
        style: style,
        drawShadow: (isForeground && splitBackgroundForeground) ||
            (!isForeground && !splitBackgroundForeground),
        onChanged: onChanged,
        shape: shape,
      );
    }
  }

  @override
  NeumorphicDecoration lerpFrom(Decoration a, double t) {
    if (a == null) return scale(t);
    if (a is NeumorphicDecoration) return NeumorphicDecoration.lerp(a, this, t);
    return super.lerpFrom(a, t) as NeumorphicDecoration;
  }

  @override
  NeumorphicDecoration lerpTo(Decoration b, double t) {
    if (b == null) return scale(1.0 - t);
    if (b is NeumorphicDecoration) return NeumorphicDecoration.lerp(this, b, t);
    return super.lerpTo(b, t) as NeumorphicDecoration;
  }

  NeumorphicDecoration scale(double factor) {
    print("scale");
    return NeumorphicDecoration(
        isForeground: this.isForeground,
        renderingByPath: this.renderingByPath,
        splitBackgroundForeground: this.splitBackgroundForeground,
        shape: NeumorphicBoxShape.lerp(null, shape, factor),
        style: style.copyWith());
  }

  static NeumorphicDecoration lerp(
      NeumorphicDecoration a, NeumorphicDecoration b, double t) {
    assert(t != null);

    //print("lerp $t ${a.style.depth}, ${b.style.depth}");

    if (a == null && b == null) return null;
    if (a == null) return b.scale(t);
    if (b == null) return a.scale(1.0 - t);
    if (t == 0.0) {
      //print("return a");
      return a;
    }
    if (t == 1.0) {
      //print("return b (1.0)");
      return b;
    }

    var aStyle = a.style;
    var bStyle = b.style;

    return NeumorphicDecoration(
        isForeground: a.isForeground,
        shape: NeumorphicBoxShape.lerp(a.shape, b.shape, t),
        splitBackgroundForeground: a.splitBackgroundForeground,
        renderingByPath: a.renderingByPath,
        style: a.style.copyWith(
          border: NeumorphicBorder.lerp(aStyle.border, bStyle.border, t),
          intensity: lerpDouble(aStyle.intensity, bStyle.intensity, t),
          surfaceIntensity:
              lerpDouble(aStyle.surfaceIntensity, bStyle.surfaceIntensity, t),
          depth: lerpDouble(aStyle.depth, bStyle.depth, t),
          color: Color.lerp(aStyle.color, bStyle.color, t),
          lightSource:
              LightSource.lerp(aStyle.lightSource, bStyle.lightSource, t),
        ));
  }

  @override
  bool get isComplex => true;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NeumorphicDecoration &&
          runtimeType == other.runtimeType &&
          style == other.style &&
          shape == other.shape &&
          splitBackgroundForeground == other.splitBackgroundForeground &&
          isForeground == other.isForeground &&
          renderingByPath == other.renderingByPath;

  @override
  int get hashCode =>
      style.hashCode ^
      shape.hashCode ^
      splitBackgroundForeground.hashCode ^
      isForeground.hashCode ^
      renderingByPath.hashCode;
}
