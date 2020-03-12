import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';

import '../../../NeumorphicBoxShape.dart';
import '../../../theme/theme.dart';
import '../../neumorphic_box_decoration_helper.dart';

class NeumorphicForegroundDecorationPainter extends BoxPainter {
  bool invalidate = false;

  //Color accent;

  NeumorphicStyle style;
  NeumorphicBoxShape shape;

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

  Radius shapeRadius;
  Radius cornerRadius;

  Rect layerRect;
  Rect rectRect;

  RRect buttonRRect;
  RRect whiteShadowRRect;
  RRect blackShadowRRect;

  Offset originOffset;
  Offset centerOffset;
  Offset depthOffset;
  Offset whiteShadowOffset;
  Offset blackShadowOffset;

  LightSource externalShadowLightSource;

  NeumorphicForegroundDecorationPainter({
    /* this.accent, */
    @required this.style,
    NeumorphicBoxShape shape,
    @required VoidCallback onChanged,
  }) : this.shape = shape ?? NeumorphicBoxShape.roundRect(),
        super(onChanged) {
    var blackShadowColor = NeumorphicColors.decorationMaxDarkColor.withOpacity(style.intensity); //<-- intensity act on opacity
    var whiteShadowColor = NeumorphicColors.decorationMaxWhiteColor.withOpacity(style.intensity); //<-- intensity act on opacity

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

    if (this.originOffset != offset || this.width != width || this.height != height) {
      this.width = width;
      this.height = height;
      this.originOffset = offset;
      this.invalidate = true;

      var middleWidth = this.width / 2;
      var middleHeight = this.height / 2;

      this.rectRect = Rect.fromLTWH(
        this.originOffset.dx,
        this.originOffset.dy,
        this.width,
        this.height,
      );

      this.radius = min(middleWidth, middleHeight);
      this.centerOffset = offset.translate(middleWidth, middleHeight);

      this.externalShadowLightSource = style.lightSource;

      if (shape.isCircle) {
        layerRect = Rect.fromCircle(
          center: centerOffset,
          radius: this.radius * 2,
        );
        gradientPaint
          ..shader = getGradientShader(
            gradientRect: Rect.fromCircle(
              center: centerOffset,
              radius: radius,
            ),
            intensity: style.surfaceIntensity,
            source: style.shape == NeumorphicShape.concave ? this.externalShadowLightSource : this.externalShadowLightSource.invert(),
          );
      } else {
        layerRect = Rect.fromLTRB(
          offset.dx - this.width,
          offset.dy - this.height,
          offset.dx + 2 * this.width,
          offset.dy + 2 * this.height,
        );
        gradientPaint
          ..shader = getGradientShader(
            gradientRect: rectRect,
            intensity: style.surfaceIntensity,
            source: style.shape == NeumorphicShape.concave ? this.externalShadowLightSource : this.externalShadowLightSource.invert(),
          );
      }
    }

    var shapeRadius = (shape?.borderRadius?.topLeft ?? Radius.zero);
    if ((this.invalidate || this.shapeRadius != shapeRadius) && !shape.isCircle) {
      this.shapeRadius = shapeRadius;

      var cornerRadius = Radius.circular(this.shapeRadius.x.clamp(
            0.0,
            this.radius,
          ));

      if (this.cornerRadius != cornerRadius) {
        this.cornerRadius = cornerRadius;
        this.buttonRRect = RRect.fromRectAndRadius(rectRect, this.cornerRadius);
      }
    }

    LightSource source = style.lightSource;
    double depth = style.depth.abs().clamp(0.0, this.radius / 3);

    if (this.invalidate || this.externalShadowLightSource != source || this.depth != depth) {
      this.depth = depth;
      this.externalShadowLightSource = source;
      this.depthOffset = this.externalShadowLightSource.offset.scale(this.depth, this.depth);
      this.maskFilter = MaskFilter.blur(BlurStyle.normal, this.depth);
      this.whiteShadowPaint..maskFilter = this.maskFilter;
      this.blackShadowPaint..maskFilter = this.maskFilter;

      if (shape.isCircle) {
        whiteShadowOffset = centerOffset.translate(
          depthOffset.dx,
          depthOffset.dy,
        );
        blackShadowOffset = centerOffset.translate(
          -depthOffset.dx,
          -depthOffset.dy,
        );
      } else {
        whiteShadowRRect = RRect.fromRectAndRadius(
          rectRect.translate(depthOffset.dx, depthOffset.dy),
          cornerRadius,
        );
        blackShadowRRect = RRect.fromRectAndRadius(
          rectRect.translate(-depthOffset.dx, -depthOffset.dy),
          cornerRadius,
        );
      }
    }

    //print("style.depth ${style.depth}");

    if (shape.isCircle) {
      if (style.shape == NeumorphicShape.concave || style.shape == NeumorphicShape.convex) {
        canvas.drawCircle(centerOffset, radius, gradientPaint);
      }
    } else {
      if (style.shape == NeumorphicShape.concave || style.shape == NeumorphicShape.convex) {
        canvas.drawRRect(this.buttonRRect, gradientPaint);
      }
    }
  }
}
