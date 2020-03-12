import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';

import '../../../NeumorphicBoxShape.dart';
import '../../../theme/theme.dart';
export '../../../theme/theme.dart';

class NeumorphicEmbossBoxDecorationPainter extends BoxPainter {
  bool invalidate = false;

  //Color accent;

  NeumorphicStyle style;
  NeumorphicBoxShape shape;

  Paint backgroundPaint;

  double width;
  double height;
  double radius;
  double depth;

  Offset originOffset;
  Offset circleOffset;

  Rect layerRect;
  Rect backgroundRect;

  Radius cornerRadius;

  LightSource source;
  Color backgroundColor;

  RRect buttonRRect;

  NeumorphicEmbossBoxDecorationPainter(
      { //this.accent,
      @required this.style,
      NeumorphicBoxShape shape,
      @required VoidCallback onChanged})
      : this.shape = shape ?? NeumorphicBoxShape.roundRect(),
        super(onChanged) {
    this.backgroundColor = style.color;

    backgroundPaint = Paint()..color = backgroundColor;
  }

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    this.invalidate = false;

    var width = configuration.size.width;
    var height = configuration.size.height;

    if (this.originOffset != offset ||
        this.width != width ||
        this.height != height) {
      this.width = width;
      this.height = height;
      this.originOffset = offset;
      this.invalidate = true;

      var middleWidth = this.width / 2;
      var middleHeight = this.height / 2;

      layerRect = offset & configuration.size;
      radius = min(middleWidth, middleHeight);

      if (shape.isCircle) {
        circleOffset = offset.translate(middleWidth, middleHeight);
      } else {
        backgroundRect = Rect.fromLTRB(offset.dx, offset.dy,
            offset.dx + this.width, offset.dy + this.height);
      }
    }

    var cornerRadius = (shape?.borderRadius?.topLeft ?? Radius.zero);
    if ((this.invalidate || this.cornerRadius != cornerRadius) &&
        !shape.isCircle) {
      this.cornerRadius = Radius.circular(cornerRadius.x.clamp(0.0, radius));
      this.buttonRRect =
          RRect.fromRectAndRadius(backgroundRect, this.cornerRadius);
    }

    LightSource source = style.lightSource;
    var depth = style.depth.abs().clamp(0.0, radius / 5);
    var backgroundColor = /*accent ??*/ style.color;
    //print("accent: $accent");
    if (this.invalidate ||
        this.source != source ||
        this.depth != depth ||
        this.backgroundColor != backgroundColor) {
      this.depth = depth;
      this.source = source;
      this.backgroundColor = backgroundColor;

      backgroundPaint..color = backgroundColor;
    }

    if (shape.isCircle) {
      canvas.drawCircle(circleOffset, radius, backgroundPaint);
    } else {
      //backgroundPaint..color = accent;
      canvas.drawRRect(buttonRRect, backgroundPaint);
    }
  }

  Rect getWhiteShadowMaskRect(
      LightSource source, Size size, Offset offset, double depth) {
    var xDepth = source.dx * depth;
    var yDepth = source.dy * depth;
    var xPadding = 2 * (1 - source.dx.abs()) * depth;
    var yPadding = 2 * (1 - source.dy.abs()) * depth;

    var left = xDepth - xPadding;
    var top = yDepth - yPadding;
    var right = xDepth + xPadding;
    var bottom = yDepth + yPadding;

    return Rect.fromLTRB(
      offset.dx + left,
      offset.dy + top,
      offset.dx + size.width + right,
      offset.dy + size.height + bottom,
    );
  }

  Rect getBlackShadowMaskRect(
      LightSource source, Size size, Offset offset, double depth) {
    var xDepth = source.dx * depth;
    var yDepth = source.dy * depth;
    var xPadding = 2 * (1 - source.dx.abs()) * depth;
    var yPadding = 2 * (1 - source.dy.abs()) * depth;

    var left = xDepth + xPadding;
    var top = yDepth + yPadding;
    var right = xDepth - xPadding;
    var bottom = yDepth - yPadding;

    return Rect.fromLTRB(
      offset.dx - left,
      offset.dy - top,
      offset.dx + size.width - right,
      offset.dy + size.height - bottom,
    );
  }
}
