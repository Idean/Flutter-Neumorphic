import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../NeumorphicBoxShape.dart';
import '../flutter_neumorphic.dart';
import '../theme.dart';

class NeumorphicEmbossBoxDecorationPainter extends BoxPainter {
  Color accent;
  NeumorphicStyle style;
  NeumorphicBoxShape shape;

  Paint backgroundPaint;
  Paint whiteShadowPaint;
  Paint whiteShadowMaskPaint;
  Paint blackShadowPaint;
  Paint blackShadowMaskPaint;

  NeumorphicEmbossBoxDecorationPainter(
      {this.accent,
        @required this.style,
        NeumorphicBoxShape shape,
        @required VoidCallback onChanged})
      : this.shape = shape ?? NeumorphicBoxShape.roundRect(),
        super(onChanged) {
    var color = accent ?? style.baseColor;
    var blackShadowColor = Colors.black45; // TODO : Add intensity ?
    var whiteShadowColor = Colors.white60; // TODO : Add intensity ?

    backgroundPaint = Paint()..color = color;

    whiteShadowPaint = Paint()..color = whiteShadowColor;
    whiteShadowMaskPaint = Paint()..blendMode = BlendMode.dstOut;

    blackShadowPaint = Paint()..color = blackShadowColor;
    blackShadowMaskPaint = Paint()..blendMode = BlendMode.dstOut;
  }

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    LightSource source = style.lightSource;

    var size = configuration.size;
    var middleWidth = size.width / 2;
    var middleHeight = size.height / 2;
    var radius = min(middleWidth, middleHeight);

    var cornerRadius = Radius.circular(
        (shape?.borderRadius?.topLeft ?? Radius.zero).x.clamp(0.0, radius));

    var depth = style.depth.abs().clamp(0.0, radius / 5);

    var blur = depth;

    MaskFilter mask = MaskFilter.blur(BlurStyle.normal, blur);
    blackShadowMaskPaint..maskFilter = mask;
    whiteShadowMaskPaint..maskFilter = mask;

    if (shape.isCircle) {
      Offset circleOffset = offset.translate(middleWidth, middleHeight);

      canvas.drawCircle(
        circleOffset,
        radius,
        backgroundPaint,
      );

      canvas.saveLayer(offset & size, whiteShadowPaint);
      canvas.drawCircle(
        circleOffset,
        radius,
        whiteShadowPaint,
      );

      canvas.drawCircle(
        circleOffset.translate(depth * source.dx, depth * source.dy),
        radius,
        whiteShadowMaskPaint,
      );

      canvas.restore();

      canvas.saveLayer(offset & size, blackShadowPaint);
      canvas.drawCircle(
        circleOffset,
        radius,
        blackShadowPaint,
      );

      canvas.drawCircle(
        circleOffset.translate(-depth * source.dx, -depth * source.dy),
        radius,
        blackShadowMaskPaint,
      );

      canvas.restore();
    } else {
      Rect backgroundRect = Rect.fromLTRB(offset.dx, offset.dy, offset.dx + size.width, offset.dy + size.height);

      canvas.drawRRect(
        RRect.fromRectAndRadius(backgroundRect, cornerRadius),
        backgroundPaint,
      );

      canvas.saveLayer(offset & size, whiteShadowPaint);
      canvas.drawRRect(
        RRect.fromRectAndRadius(backgroundRect, cornerRadius),
        whiteShadowPaint,
      );

      canvas.drawRRect(
        RRect.fromRectAndRadius(
            getWhiteShadowMaskRect(source, size, offset, depth), cornerRadius),
        whiteShadowMaskPaint,
      );

      canvas.restore();

      canvas.saveLayer(offset & size, blackShadowPaint);
      canvas.drawRRect(
        RRect.fromRectAndRadius(backgroundRect, cornerRadius),
        blackShadowPaint,
      );

      canvas.drawRRect(
        RRect.fromRectAndRadius(
            getBlackShadowMaskRect(source, size, offset, depth), cornerRadius),
        blackShadowMaskPaint,
      );

      canvas.restore();

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