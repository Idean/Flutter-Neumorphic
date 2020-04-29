import 'dart:math';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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
  Paint whiteShadowPaint;
  Paint whiteShadowMaskPaint;
  Paint blackShadowPaint;
  Paint blackShadowMaskPaint;

  double width;
  double height;
  double radius;
  double depth;

  Offset originOffset;

  Rect layerRect;
  Rect backgroundRect;
  Path path;

  LightSource shadowLightSource;
  Color backgroundColor;

  bool drawShadow;

  NeumorphicEmbossBoxDecorationPainter(
      {@required this.style,
      @required NeumorphicBoxShape shape,
      @required this.drawShadow,
      @required VoidCallback onChanged})
      : this.shape = shape ?? NeumorphicBoxShape.rect(),
        super(onChanged) {
    this.backgroundColor = /*accent ??*/ style.color;
    var blackShadowColor = NeumorphicColors.embossDarkColor(
        style.shadowDarkColorEmboss,
        intensity: style.intensity);
    var whiteShadowColor = NeumorphicColors.embossWhiteColor(
        style.shadowLightColorEmboss,
        intensity: style.intensity);

    backgroundPaint = Paint()..color = backgroundColor;

    whiteShadowPaint = Paint()..color = whiteShadowColor;
    whiteShadowMaskPaint = Paint()..blendMode = BlendMode.dstOut;

    blackShadowPaint = Paint()..color = blackShadowColor;
    blackShadowMaskPaint = Paint()..blendMode = BlendMode.dstOut;
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

      layerRect = originOffset & configuration.size;
      radius = min(middleWidth, middleHeight);

      this.path = shape.customShapePathProvider.getPath(configuration.size);
    }

    LightSource shadowLightSource = style.lightSource;
    if (style.oppositeShadowLightSource) {
      shadowLightSource = shadowLightSource.invert();
    }

    var depth = style.depth.abs().clamp(0.0, radius / 5);
    var backgroundColor = style.color;

    if (this.invalidate ||
        this.shadowLightSource != shadowLightSource ||
        this.depth != depth ||
        this.backgroundColor != backgroundColor) {
      this.depth = depth;
      this.shadowLightSource = shadowLightSource;
      this.backgroundColor = backgroundColor;

      backgroundPaint..color = backgroundColor;

      MaskFilter mask = MaskFilter.blur(BlurStyle.normal, depth);
      blackShadowMaskPaint..maskFilter = mask;
      whiteShadowMaskPaint..maskFilter = mask;
    }

    whiteShadowPaint
      ..color = NeumorphicColors.embossWhiteColor(
        style.shadowLightColorEmboss,
        intensity: style.intensity,
      );
    blackShadowPaint
      ..color = NeumorphicColors.embossDarkColor(
        style.shadowDarkColorEmboss,
        intensity: style.intensity,
      );

    var pathMetrics = path.computeMetrics();

    for (var item in pathMetrics) {
      var subPath = item.extractPath(0, item.length);

      canvas.save();
      canvas.translate(originOffset.dx, originOffset.dy);
      canvas.drawPath(subPath, backgroundPaint);
      canvas.restore();

      if (drawShadow) {
        var xDepth = this.shadowLightSource.dx * depth;
        var yDepth = this.shadowLightSource.dy * depth;
        var xPadding = 2 * (1 - this.shadowLightSource.dx.abs()) * depth;
        var yPadding = 2 * (1 - this.shadowLightSource.dy.abs()) * depth;

        var witheShadowLeftTranslation = xDepth - xPadding;
        var witheShadowTopTranslation = yDepth - yPadding;

        var blackShadowLeftTranslation = -(xDepth + xPadding);
        var blackShadowTopTranslation = -(yDepth + yPadding);

        var scaledWidth = configuration.size.width + 2 * xPadding;
        var scaledHeight = configuration.size.height + 2 * yPadding;

        Matrix4 matrix4 = Matrix4.identity();
        matrix4.scale(scaledWidth / configuration.size.width,
            scaledHeight / configuration.size.height);

        canvas.saveLayer(layerRect, whiteShadowPaint);
        canvas.translate(originOffset.dx, originOffset.dy);
        canvas.drawPath(subPath, whiteShadowPaint);
        canvas.translate(witheShadowLeftTranslation, witheShadowTopTranslation);
        canvas.drawPath(
            subPath.transform(matrix4.storage), whiteShadowMaskPaint);
        canvas.restore();

        canvas.saveLayer(layerRect, blackShadowPaint);
        canvas.translate(originOffset.dx, originOffset.dy);
        canvas.drawPath(subPath, blackShadowPaint);
        canvas.translate(blackShadowLeftTranslation, blackShadowTopTranslation);
        canvas.drawPath(
            subPath.transform(matrix4.storage), blackShadowMaskPaint);
        canvas.restore();
      }
    }
  }
}
