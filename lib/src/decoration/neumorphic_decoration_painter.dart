import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import '../NeumorphicBoxShape.dart';
import '../theme/theme.dart';
import 'neumorphic_box_decoration_helper.dart';

class NeumorphicDecorationPainter extends BoxPainter {
  bool invalidate = false;

  NeumorphicStyle style;
  NeumorphicBoxShape shape;

  Paint backgroundPaint;
  Paint whiteShadowPaint;
  Paint whiteShadowMaskPaint;
  Paint blackShadowPaint;
  Paint blackShadowMaskPaint;
  Paint gradientPaint;

  double width;
  double height;
  double depth;
  double radius;

  MaskFilter maskFilter;

  Rect layerRect;
  Path path;

  Offset originOffset;
  Offset depthOffset;

  LightSource externalShadowLightSource;

  bool drawGradient;
  bool drawShadow;
  bool drawBackground;
  bool renderingByPath;

  NeumorphicDecorationPainter(
      {@required this.style,
      @required this.shape,
      @required this.drawGradient,
      @required this.drawShadow,
      @required this.drawBackground,
      @required VoidCallback onChanged,
      this.renderingByPath = true})
      : super(onChanged) {

    backgroundPaint = Paint();

    whiteShadowPaint = Paint();
    whiteShadowMaskPaint = Paint()..blendMode = BlendMode.dstOut;

    blackShadowPaint = Paint();
    blackShadowMaskPaint = Paint()..blendMode = BlendMode.dstOut;

    gradientPaint = Paint();

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

      this.radius = min(middleWidth, middleHeight);

      path = shape.customShapePathProvider.getPath(configuration.size);

      layerRect = Rect.fromLTRB(
        originOffset.dx - this.width,
        originOffset.dy - this.height,
        originOffset.dx + 2 * this.width,
        originOffset.dy + 2 * this.height,
      );
    }

    LightSource externalShadowLightSource = style.lightSource;
    if (style.oppositeShadowLightSource) {
      externalShadowLightSource = externalShadowLightSource.invert();
    }
    double depth = style.depth.abs().clamp(0.0, this.radius / 3);

    if (this.invalidate ||
        this.externalShadowLightSource != externalShadowLightSource ||
        this.depth != depth) {
      this.depth = depth;
      this.externalShadowLightSource = externalShadowLightSource;
      this.depthOffset =
          this.externalShadowLightSource.offset.scale(this.depth, this.depth);
      this.maskFilter = MaskFilter.blur(BlurStyle.normal, this.depth);
      this.whiteShadowPaint..maskFilter = this.maskFilter;
      this.blackShadowPaint..maskFilter = this.maskFilter;
    }

    backgroundPaint..color = style.color;

    whiteShadowPaint
      ..color = NeumorphicColors.decorationWhiteColor(style.shadowLightColor,
          intensity: style.intensity);
    blackShadowPaint
      ..color = NeumorphicColors.decorationDarkColor(style.shadowDarkColor,
          intensity: style.intensity);

    var pathMetrics = path.computeMetrics();

    for (var item in pathMetrics) {
      var subPath = item.extractPath(0, item.length);

      if(drawShadow) {
        _drawShadow(offset: offset, canvas: canvas, path: subPath);
      }

      if(drawBackground) {
        _drawBackground(offset: offset, canvas: canvas, path: subPath);
      }

      if (this.drawGradient && renderingByPath) {
        _drawPath(offset: offset, canvas: canvas, path: subPath);
      }
    }

    if (this.drawGradient && !renderingByPath) {
      _drawPath(offset: offset, canvas: canvas, path: path);
    }

  }

  void _drawBackground({Canvas canvas, Offset offset, Path path}) {
    canvas.save();
    canvas.translate(offset.dx, offset.dy);
    canvas.drawPath(path, backgroundPaint);
    canvas.restore();
  }

  void _drawShadow({Canvas canvas, Offset offset, Path path}){
    if (style.depth.abs() >= 0.1) {
      canvas.saveLayer(layerRect, whiteShadowPaint);
      canvas.translate(
          offset.dx + depthOffset.dx, offset.dy + depthOffset.dy);
      canvas.drawPath(path, whiteShadowPaint);
      canvas.translate(-depthOffset.dx, -depthOffset.dy);
      canvas.drawPath(path, whiteShadowMaskPaint);
      canvas.restore();

      canvas.saveLayer(layerRect, blackShadowPaint);
      canvas.translate(
          offset.dx - depthOffset.dx, offset.dy - depthOffset.dy);
      canvas.drawPath(path, blackShadowPaint);
      canvas.translate(depthOffset.dx, depthOffset.dy);
      canvas.drawPath(path, blackShadowMaskPaint);
      canvas.restore();
    }
  }

  void _drawPath({Canvas canvas, Offset offset, Path path}){
    if (style.shape == NeumorphicShape.concave ||
        style.shape == NeumorphicShape.convex) {
      var pathRect = path.getBounds();

      gradientPaint
        ..shader = getGradientShader(
          gradientRect: pathRect,
          intensity: style.surfaceIntensity,
          source: style.shape == NeumorphicShape.concave
              ? this.style.lightSource
              : this.style.lightSource.invert(),
        );

      canvas.saveLayer(
        pathRect.translate(offset.dx, offset.dy),
        gradientPaint,
      );
      canvas.translate(offset.dx, offset.dy);
      canvas.drawPath(path, gradientPaint);
      canvas.restore();
    }
  }
}
