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

  Paint backgroundPaint;
  Paint whiteShadowPaint;
  Paint whiteShadowMaskPaint;
  Paint blackShadowPaint;
  Paint blackShadowMaskPaint;
  Paint gradientPaint;

  ImageConfiguration configuration;
  double width;
  double height;
  double depth;
  double radius;

  MaskFilter maskFilter;

  BorderRadius borderRadius;

  Rect layerRect;
  Rect dstRect;
  Path customPath;

  RRect buttonRRect;
  RRect whiteShadowRRect;
  RRect blackShadowRRect;

  Offset originOffset;
  Offset centerOffset;
  Offset depthOffset;
  Offset whiteShadowOffset;
  Offset blackShadowOffset;

  LightSource gradientLightSource;
  bool enabled;

  NeumorphicForegroundDecorationPainter({
    /* this.accent, */
    @required this.style,
    @required NeumorphicBoxShape shape,
    @required this.enabled,
    @required VoidCallback onChanged,
  })  : this.shape = shape ?? NeumorphicBoxShape.roundRect(),
        super(onChanged) {
    var blackShadowColor = NeumorphicColors.decorationDarkColor(
      style.shadowDarkColor,
      intensity: style.intensity, //<-- intensity act on opacity
    );
    var whiteShadowColor = NeumorphicColors.decorationWhiteColor(
      style.shadowDarkColor,
      intensity: style.intensity, //<-- intensity act on opacity
    );

    backgroundPaint = Paint()..color = style.color;

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
        this.configuration != configuration ||
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

      //print("rectRect (W): ${rectRect.width}");

      this.radius = min(middleWidth, middleHeight);
      this.centerOffset = offset.translate(middleWidth, middleHeight);

      this.gradientLightSource = style.lightSource;

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
            source: style.shape == NeumorphicShape.concave
                ? this.gradientLightSource
                : this.gradientLightSource.invert(),
          );
      } else if (shape.isRoundRect || shape.isStadium) {

        layerRect = Rect.fromLTRB(
          offset.dx - this.width,
          offset.dy - this.height,
          offset.dx + 2 * this.width,
          offset.dy + 2 * this.height,
        );
        gradientPaint
          ..shader = getGradientShader(
            gradientRect: dstRect,
            intensity: style.surfaceIntensity,
            source: style.shape == NeumorphicShape.concave
                ? this.gradientLightSource
                : this.gradientLightSource.invert(),
          );
      } else if (shape.isCustomShape) {

        customPath =  shape.customShapePathProvider.getPath(configuration.size);

        layerRect = Rect.fromLTRB(
          offset.dx - this.width,
          offset.dy - this.height,
          offset.dx + 2 * this.width,
          offset.dy + 2 * this.height,
        );
        gradientPaint
          ..shader = getGradientShader(
            gradientRect: dstRect,
            intensity: style.surfaceIntensity,
            source: style.shape == NeumorphicShape.concave
                ? this.gradientLightSource
                : this.gradientLightSource.invert(),
          );
      }
    }

    final cornerRadius = (shape?.borderRadius ?? BorderRadius.zero);
    if ((this.invalidate || this.borderRadius != cornerRadius) &&
        !shape.isCircle) {
      this.borderRadius = cornerRadius;

      this.buttonRRect = RRect.fromRectAndCorners(
        dstRect,
        topLeft: this.borderRadius.topLeft,
        topRight: this.borderRadius.topRight,
        bottomRight: this.borderRadius.bottomRight,
        bottomLeft: this.borderRadius.bottomLeft,
      );
    }

    LightSource gradientLightSource = style.lightSource;
    double depth = style.depth.abs().clamp(0.0, this.radius / 3);

    if (this.invalidate ||
        this.gradientLightSource != gradientLightSource ||
        this.depth != depth) {
      this.depth = depth;
      this.gradientLightSource = gradientLightSource;
      this.depthOffset =
          this.gradientLightSource.offset.scale(this.depth, this.depth);
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
        whiteShadowRRect = RRect.fromRectAndCorners(
          dstRect.translate(depthOffset.dx, depthOffset.dy),
          topLeft: this.borderRadius.topLeft,
          topRight: this.borderRadius.topRight,
          bottomRight: this.borderRadius.bottomRight,
          bottomLeft: this.borderRadius.bottomLeft,
        );
        blackShadowRRect = RRect.fromRectAndCorners(
          dstRect.translate(-depthOffset.dx, -depthOffset.dy),
          topLeft: this.borderRadius.topLeft,
          topRight: this.borderRadius.topRight,
          bottomRight: this.borderRadius.bottomRight,
          bottomLeft: this.borderRadius.bottomLeft,
        );
      }
    }

    //print("style.depth ${style.depth}");

    //print("buttonRRect: ${this.buttonRRect.width}");

    if (enabled) {
      if (shape.isCircle) {
        if (style.shape == NeumorphicShape.concave ||
            style.shape == NeumorphicShape.convex) {
          canvas.save();
          canvas.drawCircle(centerOffset, radius, gradientPaint);
          canvas.restore();
        }
      } else if (shape.isRoundRect || shape.isStadium) {
        if (style.shape == NeumorphicShape.concave ||
            style.shape == NeumorphicShape.convex) {
          canvas.save();
          canvas.drawRRect(this.buttonRRect, gradientPaint);
          canvas.restore();
        }
      } else if (shape.isCustomShape) {
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
}
