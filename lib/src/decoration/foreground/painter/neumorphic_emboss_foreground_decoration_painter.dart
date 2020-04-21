import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';

import '../../../NeumorphicBoxShape.dart';
import '../../../theme/theme.dart';

export '../../../theme/theme.dart';

class NeumorphicEmbossForegroundDecorationPainter extends BoxPainter {
  bool invalidate = false;

  NeumorphicStyle style;
  NeumorphicBoxShape shape;

  Paint whiteShadowPaint;
  Paint whiteShadowMaskPaint;
  Paint blackShadowPaint;
  Paint blackShadowMaskPaint;

  double width;
  double height;
  double radius;
  double depth;

  Offset originOffset;
  Offset circleOffset;
  Offset whiteShadowMaskPaintOffset;
  Offset blackShadowMaskPaintOffset;

  Rect layerRect;
  Rect backgroundRect;
  Path customPath;

  BorderRadius borderRadius;

  LightSource shadowLightSource;
  Color backgroundColor;

  RRect buttonRRect;
  RRect whiteShadowMaskRect;
  RRect blackShadowMaskRect;

  bool enabled;

  NeumorphicEmbossForegroundDecorationPainter(
      { //this.accent,
      @required this.style,
      @required this.enabled,
      @required NeumorphicBoxShape shape,
      @required VoidCallback onChanged})
      : this.shape = shape ?? NeumorphicBoxShape.roundRect(),
        super(onChanged) {
    this.backgroundColor = /*accent ??*/ style.color;
    var blackShadowColor = NeumorphicColors.embossDarkColor(
      style.shadowDarkColorEmboss,
      intensity: style.intensity,
    );
    var whiteShadowColor = NeumorphicColors.embossWhiteColor(
      style.shadowLightColorEmboss,
      intensity: style.intensity,
    );

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

      layerRect = offset & configuration.size;
      radius = min(middleWidth, middleHeight);

      if (shape.isCircle) {
        circleOffset = offset.translate(middleWidth, middleHeight);
      } else if (shape.isRoundRect || shape.isStadium) {
        backgroundRect = Rect.fromLTRB(offset.dx, offset.dy,
            offset.dx + this.width, offset.dy + this.height);
      } else if (shape.isCustomShape) {
        this.customPath =
            shape.customShapePathProvider.getPath(configuration.size);
      }
    }

    var cornerRadius = (shape?.borderRadius ?? BorderRadius.zero);
    if ((this.invalidate || this.borderRadius != cornerRadius) && !shape.isCircle && !shape.isCustomShape) {
      this.borderRadius = cornerRadius;

      this.buttonRRect = RRect.fromRectAndCorners(
        backgroundRect,
        topLeft: this.borderRadius.topLeft,
        topRight: this.borderRadius.topRight,
        bottomRight: this.borderRadius.bottomRight,
        bottomLeft: this.borderRadius.bottomLeft,
      );
    }

    LightSource shadowLightSource = style.lightSource;
    if (style.oppositeShadowLightSource) {
      shadowLightSource = shadowLightSource.invert();
    }

    var depth = style.depth.abs().clamp(0.0, radius / 5);
    var backgroundColor = /*accent ??*/ style.color;
    //print("accent: $accent");
    if (this.invalidate ||
        this.shadowLightSource != shadowLightSource ||
        this.depth != depth ||
        this.backgroundColor != backgroundColor) {
      this.depth = depth;
      this.shadowLightSource = shadowLightSource;
      this.backgroundColor = backgroundColor;

      MaskFilter mask = MaskFilter.blur(BlurStyle.normal, depth);
      blackShadowMaskPaint..maskFilter = mask;
      whiteShadowMaskPaint..maskFilter = mask;

      if (shape.isCircle) {
        whiteShadowMaskPaintOffset = circleOffset.translate(
          this.depth * this.shadowLightSource.dx,
          this.depth * this.shadowLightSource.dy,
        );
        blackShadowMaskPaintOffset = circleOffset.translate(
          -this.depth * this.shadowLightSource.dx,
          -this.depth * this.shadowLightSource.dy,
        );
      } else if (shape.isStadium || shape.isRoundRect) {
        whiteShadowMaskRect = RRect.fromRectAndCorners(
          getWhiteShadowMaskRect(
            this.shadowLightSource,
            configuration.size,
            offset,
            this.depth,
          ),
          topLeft: this.borderRadius.topLeft,
          topRight: this.borderRadius.topRight,
          bottomRight: this.borderRadius.bottomRight,
          bottomLeft: this.borderRadius.bottomLeft,
        );
        blackShadowMaskRect = RRect.fromRectAndCorners(
          getBlackShadowMaskRect(
            this.shadowLightSource,
            configuration.size,
            offset,
            this.depth,
          ),
          topLeft: this.borderRadius.topLeft,
          topRight: this.borderRadius.topRight,
          bottomRight: this.borderRadius.bottomRight,
          bottomLeft: this.borderRadius.bottomLeft,
        );
      }
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

    if (enabled) {
      if (shape.isCircle) {
        canvas.saveLayer(layerRect, whiteShadowPaint);
        canvas.drawCircle(circleOffset, radius, whiteShadowPaint);
        canvas.drawCircle(
          whiteShadowMaskPaintOffset,
          radius,
          whiteShadowMaskPaint,
        );
        canvas.restore();

        canvas.saveLayer(layerRect, blackShadowPaint);
        canvas.drawCircle(circleOffset, radius, blackShadowPaint);
        canvas.drawCircle(
          blackShadowMaskPaintOffset,
          radius,
          blackShadowMaskPaint,
        );
        canvas.restore();
      } else if (shape.isRoundRect || shape.isStadium) {

        canvas.saveLayer(layerRect, whiteShadowPaint);
        canvas.drawRRect(buttonRRect, whiteShadowPaint);
        canvas.drawRRect(whiteShadowMaskRect, whiteShadowMaskPaint);
        canvas.restore();

        canvas.saveLayer(layerRect, blackShadowPaint);
        canvas.drawRRect(buttonRRect, blackShadowPaint);
        canvas.drawRRect(blackShadowMaskRect, blackShadowMaskPaint);
        canvas.restore();

      } else {

        final Rect pathBounds = customPath.getBounds();

        var xDepth = this.shadowLightSource.dx * depth;
        var yDepth = this.shadowLightSource.dy * depth;
        var xPadding = 2 * (1 - this.shadowLightSource.dx.abs()) * depth;
        var yPadding = 2 * (1 - this.shadowLightSource.dy.abs()) * depth;

        var left = xDepth - xPadding;
        var top = yDepth - yPadding;
        var right = xDepth + xPadding;
        var bottom = yDepth + yPadding;

        var newWidth = (offset.dx + configuration.size.width + right) - (offset.dx + left);
        var newHeight = (offset.dy + configuration.size.height + bottom) - (offset.dy + top);

        Matrix4 matrix4 = Matrix4.identity();
        matrix4.scale(newWidth / pathBounds.width, newHeight / pathBounds.height);
        customPath.transform(matrix4.storage);

        canvas.saveLayer(layerRect, whiteShadowPaint);
        canvas.translate(offset.dx, offset.dy);
        canvas.drawPath(customPath, whiteShadowPaint);
        canvas.translate(left, top);
        canvas.drawPath(customPath.transform(matrix4.storage), whiteShadowMaskPaint);
        canvas.restore();

        left = xDepth + xPadding;
        top = yDepth + yPadding;
        right = xDepth - xPadding;
        bottom = yDepth - yPadding;

        newWidth = (offset.dx + configuration.size.width - right) - (offset.dx - left);
        newHeight = (offset.dy + configuration.size.height - bottom) - (offset.dy - top);

        matrix4 = Matrix4.identity();
        matrix4.scale(newWidth / pathBounds.width, newHeight / pathBounds.height);
        customPath.transform(matrix4.storage);

        canvas.saveLayer(layerRect, blackShadowPaint);
        canvas.translate(offset.dx, offset.dy);
        canvas.drawPath(customPath, blackShadowPaint);
        canvas.translate(- left, - top);
        canvas.drawPath(customPath.transform(matrix4.storage), blackShadowMaskPaint);
        canvas.restore();

      }
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
