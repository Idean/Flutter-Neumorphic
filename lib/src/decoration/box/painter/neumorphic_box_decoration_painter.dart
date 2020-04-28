import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import '../../../NeumorphicBoxShape.dart';
import '../../../theme/theme.dart';
import '../../neumorphic_box_decoration_helper.dart';

class NeumorphicBoxDecorationPainter extends BoxPainter {
  bool invalidate = false;

  //Color accent;

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
  Rect dstRect;
  Path customPath;

  Offset originOffset;
  Offset depthOffset;

  LightSource externalShadowLightSource;
  bool drawGradient;

  NeumorphicBoxDecorationPainter({
    /* this.accent, */
    @required this.style,
    @required NeumorphicBoxShape shape,
    @required this.drawGradient,
    @required VoidCallback onChanged,
  })  : this.shape = shape ?? NeumorphicBoxShape.rect(),
        super(onChanged) {
    var color = /*accent ??*/ style.color;

    var blackShadowColor = NeumorphicColors.decorationDarkColor(
        style.shadowDarkColor,
        intensity: style.intensity //<-- intensity act on opacity
        );

    var whiteShadowColor = NeumorphicColors.decorationWhiteColor(
        style.shadowLightColor,
        intensity: style.intensity //<-- intensity act on opacity
        );

    backgroundPaint = Paint()..color = color;

    whiteShadowPaint = Paint()..color = whiteShadowColor;
    whiteShadowMaskPaint = Paint()..blendMode = BlendMode.dstOut;

    blackShadowPaint = Paint()..color = blackShadowColor;
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

      this.dstRect = Rect.fromLTWH(
        this.originOffset.dx,
        this.originOffset.dy,
        this.width,
        this.height,
      );

      this.radius = min(middleWidth, middleHeight);

      customPath = shape.customShapePathProvider.getPath(configuration.size);

      layerRect = Rect.fromLTRB(
        originOffset.dx - this.width,
        originOffset.dy - this.height,
        originOffset.dx + 2 * this.width,
        originOffset.dy + 2 * this.height,
      );

      gradientPaint
        ..shader = getGradientShader(
          gradientRect: dstRect,
          intensity: style.surfaceIntensity,
          source: style.shape == NeumorphicShape.concave
              ? this.style.lightSource
              : this.style.lightSource.invert(),
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

    whiteShadowPaint
      ..color = NeumorphicColors.decorationWhiteColor(style.shadowLightColor,
          intensity: style.intensity); //<-- intensity act on opacity;
    blackShadowPaint
      ..color = NeumorphicColors.decorationDarkColor(style.shadowDarkColor,
          intensity: style.intensity); //<-- intensity act on opacity;

    if (style.depth.abs() >= 0.1) {
      canvas.saveLayer(layerRect, whiteShadowPaint);
      canvas.translate(offset.dx + depthOffset.dx, offset.dy + depthOffset.dy);
      canvas.drawPath(customPath, whiteShadowPaint);
      canvas.translate(-depthOffset.dx, -depthOffset.dy);
      canvas.drawPath(customPath, whiteShadowMaskPaint);
      canvas.restore();

      canvas.saveLayer(layerRect, blackShadowPaint);
      canvas.translate(offset.dx - depthOffset.dx, offset.dy - depthOffset.dy);
      canvas.drawPath(customPath, blackShadowPaint);
      canvas.translate(depthOffset.dx, depthOffset.dy);
      canvas.drawPath(customPath, blackShadowMaskPaint);
      canvas.restore();
    }

    canvas.save();
    canvas.translate(offset.dx, offset.dy);
    canvas.drawPath(customPath, backgroundPaint);
    canvas.restore();

    if (this.drawGradient) {
      if (style.shape == NeumorphicShape.concave ||
          style.shape == NeumorphicShape.convex) {
        canvas.saveLayer(layerRect, gradientPaint);
        canvas.translate(offset.dx, offset.dy);
        canvas.drawPath(customPath, backgroundPaint);
        canvas.translate(-offset.dx, -offset.dy);
        canvas.drawRect(dstRect, gradientPaint..blendMode = BlendMode.srcATop);
        canvas.restore();
      }
    }
  }
}
