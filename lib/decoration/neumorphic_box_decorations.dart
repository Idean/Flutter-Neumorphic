import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic/decoration/neumorphic_emboss_box_decoration.dart';

import '../NeumorphicBoxShape.dart';
import '../flutter_neumorphic.dart';
import 'neumorphic_box_decoration.dart';
import '../theme.dart';

class NeumorphicBoxDecoration extends Decoration {

  final Color accent;
  final NeumorphicStyle style;
  final NeumorphicBoxShape shape;

  NeumorphicBoxDecoration({@required this.accent, @required this.style, this.shape});

  @override
  BoxPainter createBoxPainter([onChanged]) {
    if(style.depth > 0) {
      return NeumorphicBoxDecorationPainter(
        style: style,
        onChanged: onChanged,
        shape: shape,
        accent: accent,
      );
    } else {
      //print("emboss : $accent");
      return NeumorphicEmbossBoxDecorationPainter(
        style: style,
        onChanged: onChanged,
        shape: shape,
        accent: accent,
      );
    }
  }

  @override
  NeumorphicBoxDecoration lerpFrom(Decoration a, double t) {
    if (a == null)
      return scale(t);
    if (a is NeumorphicBoxDecoration)
      return NeumorphicBoxDecoration.lerp(a, this, t);
    return super.lerpFrom(a, t) as NeumorphicBoxDecoration;
  }

  @override
  NeumorphicBoxDecoration lerpTo(Decoration b, double t) {
    if (b == null)
      return scale(1.0 - t);
    if (b is NeumorphicBoxDecoration)
      return NeumorphicBoxDecoration.lerp(this, b, t);
    return super.lerpTo(b, t) as NeumorphicBoxDecoration;
  }

  NeumorphicBoxDecoration scale(double factor) {
    return NeumorphicBoxDecoration(
        shape: NeumorphicBoxShape.lerp(null, shape, factor),
        accent: Color.lerp(null, accent, factor),
        style: style.copyWith(
          color: Color.lerp(null, style.color, factor),
        )
    );
  }

  static NeumorphicBoxDecoration lerp(NeumorphicBoxDecoration a, NeumorphicBoxDecoration b, double t) {

    assert(t != null);

    if (a == null && b == null)
      return null;
    if (a == null)
      return b.scale(t);
    if (b == null)
      return a.scale(1.0 - t);
    if (t == 0.0)
      return a;
    if (t == 1.0)
      return b;
    if(a.shape.boxShape != b.shape.boxShape)
      return b;

    var aStyle = a.style;
    var bStyle = b.style;

    return NeumorphicBoxDecoration(
      shape: NeumorphicBoxShape.lerp(a.shape, b.shape, t),
      accent: Color.lerp(a.accent, b.accent, t),
      style: a.style.copyWith(
        intensity: lerpDouble(aStyle.intensity, bStyle.intensity, t),
        depth: lerpDouble(aStyle.depth, bStyle.depth, t),
        color: Color.lerp(aStyle.color, bStyle.color, t),
        lightSource: LightSource.lerp(aStyle.lightSource, bStyle.lightSource, t),
      )
    );

  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is NeumorphicBoxDecoration &&
              runtimeType == other.runtimeType &&
              accent == other.accent &&
              style == other.style &&
              shape == other.shape;

  @override
  int get hashCode =>
      accent.hashCode ^
      style.hashCode ^
      shape.hashCode;

}
