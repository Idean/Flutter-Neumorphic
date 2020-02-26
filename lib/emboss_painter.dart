import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'NeumorphicBoxShape.dart';
import 'flutter_neumorphic.dart';
import 'theme.dart';

class EmbossPainter extends CustomPainter {
  final Color accent;
  final NeumorphicStyle style;
  final NeumorphicBoxShape shape;

  EmbossPainter({this.accent, this.style, this.shape});

  @override
  void paint(Canvas canvas, Size size) {
    if (style.depth > 0.0) {
      Offset offset = Offset.zero;
      LightSource source = style.lightSource;

      var middleWidth = size.width / 2;
      var middleHeight = size.height / 2;
      var radius = min(middleWidth, middleHeight);

      var cornerRadius = Radius.circular(
          (shape?.borderRadius?.topLeft ?? Radius.zero).x.clamp(0.0, radius));

      var depth = style.depth.clamp(0.0, radius / 3);
      var depthOffset = source.offset.scale(depth, depth);

      var blur = depth;
      var blurX = (blur * source.dx).abs();
      var blurY = (blur * source.dy).abs();

      var color = accent ?? style.baseColor;
      var blackShadowColor = Colors.black45; // TODO : Add intensity ?
      var whiteShadowColor = Colors.white60; // TODO : Add intensity ?

      var backgroundPaint = Paint()..color = color;

      var whiteShadowPaint = Paint()..color = whiteShadowColor;
      var whiteShadowMaskPaint = Paint()
        ..blendMode = BlendMode.dstOut
        ..imageFilter = ui.ImageFilter.blur(sigmaX: blurX, sigmaY: blurY);

      var blackShadowPaint = Paint()..color = blackShadowColor;
      var blackShadowMaskPaint = Paint()
        ..blendMode = BlendMode.dstOut
        ..imageFilter = ui.ImageFilter.blur(sigmaX: blurX, sigmaY: blurY);

      if (shape.isCircle) {
        canvas.drawCircle(
          Offset(middleWidth, middleHeight),
          radius,
          backgroundPaint,
        );

        canvas.saveLayer(offset & size, whiteShadowPaint);
        canvas.drawCircle(
          Offset(middleWidth, middleHeight),
          radius,
          whiteShadowPaint,
        );

        canvas.drawCircle(
          Offset(middleWidth, middleHeight)
              .translate(depthOffset.dx, depthOffset.dy),
          radius,
          whiteShadowMaskPaint,
        );

        canvas.restore();

        canvas.saveLayer(offset & size, blackShadowPaint);
        canvas.drawCircle(
          Offset(middleWidth, middleHeight),
          radius,
          blackShadowPaint,
        );

        canvas.drawCircle(
          Offset(middleWidth, middleHeight)
              .translate(-depthOffset.dx, -depthOffset.dy),
          radius,
          blackShadowMaskPaint,
        );

        canvas.restore();
      } else {
        Rect backgroundRect = Rect.fromLTRB(0, 0, size.width, size.height);

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
              getWhiteShadowMaskRect(source, size, depthOffset), cornerRadius),
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
              getBlackShadowMaskRect(source, size, depthOffset), cornerRadius),
          blackShadowMaskPaint,
        );

        canvas.restore();
      }
    }
  }

  Rect getWhiteShadowMaskRect(
      LightSource source, Size size, Offset depthOffset) {
    var left = source.dx == 1.0 ? 0 : size.width;
    var top = source.dy == 1.0 ? 0 : size.height;
    var right = source.dx == -1.0 ? 0 : size.width;
    var bottom = source.dy == -1.0 ? 0 : size.height;

    return Rect.fromLTRB(
      depthOffset.dx - left,
      depthOffset.dy - top,
      size.width + depthOffset.dx + right,
      size.height + depthOffset.dy + bottom,
    );
  }

  Rect getBlackShadowMaskRect(
      LightSource source, Size size, Offset depthOffset) {
    var left = source.dx == -1.0 ? 0 : size.width;
    var top = source.dy == -1.0 ? 0 : size.height;
    var right = source.dx == 1.0 ? 0 : size.width;
    var bottom = source.dy == 1.0 ? 0 : size.height;

    return Rect.fromLTRB(
      -depthOffset.dx - left,
      -depthOffset.dy - top,
      size.width - depthOffset.dx + right,
      size.height - depthOffset.dy + bottom,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
