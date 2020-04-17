import 'dart:math';

import 'package:flutter/foundation.dart';
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

  BorderRadius borderRadius;

  Rect layerRect;
  Rect rectRect;
  Path customPath;

  RRect buttonRRect;
  RRect whiteShadowRRect;
  RRect blackShadowRRect;

  Offset originOffset;
  Offset centerOffset;
  Offset depthOffset;
  Offset whiteShadowOffset;
  Offset blackShadowOffset;

  LightSource externalShadowLightSource;
  LightSource gradientLightSource;
  bool drawGradient;

  NeumorphicBoxDecorationPainter({
    /* this.accent, */
    @required this.style,
    @required NeumorphicBoxShape shape,
    @required this.drawGradient,
    @required VoidCallback onChanged,
  })  : this.shape = shape ?? NeumorphicBoxShape.roundRect(),
        super(onChanged) {
    var color = /*accent ??*/ style.color;
    var blackShadowColor = NeumorphicColors.decorationDarkColor(
        style.shadowDarkColor,
        intensity: style.intensity); //<-- intensity act on opacity
    var whiteShadowColor = NeumorphicColors.decorationWhiteColor(
        style.shadowLightColor,
        intensity: style.intensity); //<-- intensity act on opacity

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

      this.rectRect = Rect.fromLTWH(
        this.originOffset.dx,
        this.originOffset.dy,
        this.width,
        this.height,
      );

      this.gradientLightSource = style.lightSource;

      this.radius = min(middleWidth, middleHeight);
      this.centerOffset = offset.translate(middleWidth, middleHeight);

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
            gradientRect: rectRect,
            intensity: style.surfaceIntensity,
            source: style.shape == NeumorphicShape.concave
                ? this.gradientLightSource
                : this.gradientLightSource.invert(),
          );
      } else if (shape.isCustomShape) {
        this.customPath =
            shape.customShapePathProvider.getPath(configuration.size);

        gradientPaint
          ..shader = getGradientShader(
            gradientRect: Rect.fromLTWH(
              0,
              0,
              this.width - this.originOffset.dx,
              this.height - this.originOffset.dy,
            ),
            intensity: style.surfaceIntensity,
            source: style.shape == NeumorphicShape.concave
                ? this.gradientLightSource
                : this.gradientLightSource.invert(),
          );
      }
    }

    var cornerRadius = (shape?.borderRadius ?? BorderRadius.zero);
    if ((this.invalidate || this.borderRadius != cornerRadius) &&
        !shape.isCircle) {
      this.borderRadius = cornerRadius;

      this.buttonRRect = RRect.fromRectAndCorners(
        rectRect,
        topLeft: this.borderRadius.topLeft,
        topRight: this.borderRadius.topRight,
        bottomRight: this.borderRadius.bottomRight,
        bottomLeft: this.borderRadius.bottomLeft,
      );
    }

    LightSource externalShadowLightSource = style.lightSource;
    if (style.oppositeShadowLightSource) {
      externalShadowLightSource = externalShadowLightSource.invert();
    }
    LightSource gradientLightSource = style.lightSource;
    double depth = style.depth.abs().clamp(0.0, this.radius / 3);

    if (this.invalidate ||
        this.externalShadowLightSource != externalShadowLightSource ||
        this.gradientLightSource != gradientLightSource ||
        this.depth != depth) {
      this.depth = depth;
      this.externalShadowLightSource = externalShadowLightSource;
      this.gradientLightSource = gradientLightSource;
      this.depthOffset =
          this.externalShadowLightSource.offset.scale(this.depth, this.depth);
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
          rectRect.translate(depthOffset.dx, depthOffset.dy),
          topLeft: this.borderRadius.topLeft,
          topRight: this.borderRadius.topRight,
          bottomRight: this.borderRadius.bottomRight,
          bottomLeft: this.borderRadius.bottomLeft,
        );
        blackShadowRRect = RRect.fromRectAndCorners(
          rectRect.translate(-depthOffset.dx, -depthOffset.dy),
          topLeft: this.borderRadius.topLeft,
          topRight: this.borderRadius.topRight,
          bottomRight: this.borderRadius.bottomRight,
          bottomLeft: this.borderRadius.bottomLeft,
        );
      }
    }

    whiteShadowPaint
      ..color = NeumorphicColors.decorationWhiteColor(style.shadowLightColor,
          intensity: style.intensity); //<-- intensity act on opacity;
    blackShadowPaint
      ..color = NeumorphicColors.decorationDarkColor(style.shadowDarkColor,
          intensity: style.intensity); //<-- intensity act on opacity;

    //print("style.depth ${style.depth}");

    if (shape.isCircle) {
      if (style.depth.abs() >= 0.1) {
        //avoid binking on android if depth near 0
        canvas.saveLayer(layerRect, whiteShadowPaint);
        canvas.drawCircle(whiteShadowOffset, radius, whiteShadowPaint);
        canvas.drawCircle(centerOffset, radius, whiteShadowMaskPaint);
        canvas.restore();

        canvas.saveLayer(layerRect, blackShadowPaint);
        canvas.drawCircle(blackShadowOffset, radius, blackShadowPaint);
        canvas.drawCircle(centerOffset, radius, blackShadowMaskPaint);
        canvas.restore();
      }

      canvas.drawCircle(centerOffset, radius, backgroundPaint);

      if (this.drawGradient) {
        if (style.shape == NeumorphicShape.concave ||
            style.shape == NeumorphicShape.convex) {
          canvas.drawCircle(centerOffset, radius, gradientPaint);
        }
      }
    } else if (shape.isRoundRect || shape.isStadium) {
      if (style.depth.abs() >= 0.1) {
        //avoid binking on android if depth near 0
        canvas.saveLayer(layerRect, whiteShadowPaint);
        canvas.drawRRect(whiteShadowRRect, whiteShadowPaint);
        canvas.drawRRect(buttonRRect, whiteShadowMaskPaint);
        canvas.restore();

        canvas.saveLayer(layerRect, blackShadowPaint);
        canvas.drawRRect(blackShadowRRect, blackShadowPaint);
        canvas.drawRRect(buttonRRect, blackShadowMaskPaint);
        canvas.restore();
      }

      canvas.drawRRect(buttonRRect, backgroundPaint);

      if (this.drawGradient) {
        if (style.shape == NeumorphicShape.concave ||
            style.shape == NeumorphicShape.convex) {
          canvas.drawRRect(this.buttonRRect, gradientPaint);
        }
      }
    } else if (shape.isCustomShape) {
      if (style.depth.abs() >= 0.1) {
        //avoid binking on android if depth near 0
        canvas.saveLayer(layerRect, whiteShadowPaint);
        canvas.translate(
            offset.dx + depthOffset.dx, offset.dy + depthOffset.dy);
        canvas.drawPath(customPath, whiteShadowPaint);
        canvas.restore();

        canvas.saveLayer(layerRect, whiteShadowMaskPaint);
        canvas.translate(
            offset.dx + depthOffset.dx, offset.dy + depthOffset.dy);
        canvas.drawPath(customPath, whiteShadowMaskPaint);
        canvas.restore();

        canvas.saveLayer(layerRect, blackShadowPaint);
        canvas.translate(
            offset.dx - depthOffset.dx, offset.dy - depthOffset.dy);
        canvas.drawPath(customPath, blackShadowPaint);
        canvas.restore();

        canvas.saveLayer(layerRect, blackShadowMaskPaint);
        canvas.translate(
            offset.dx - depthOffset.dx, offset.dy - depthOffset.dy);
        canvas.drawPath(customPath, blackShadowMaskPaint);
        canvas.restore();
      }

      if (this.drawGradient) {
        if (style.shape == NeumorphicShape.concave ||
            style.shape == NeumorphicShape.convex) {
          canvas.save();
          canvas.translate(offset.dx, offset.dy);
          canvas.drawPath(customPath, gradientPaint);

          canvas.restore();
        }
      } else {
        canvas.save();
        canvas.translate(offset.dx, offset.dy);

        canvas.drawPath(customPath, backgroundPaint);
        canvas.restore();
      }
    }
  }
}
