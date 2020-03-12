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

  NeumorphicBoxDecorationPainter({
    /* this.accent, */
    @required this.style,
    NeumorphicBoxShape shape,
    @required VoidCallback onChanged,
  })  : this.shape = shape ?? NeumorphicBoxShape.roundRect(),
        super(onChanged) {
    var color = /*accent ??*/ style.color;
    var blackShadowColor = NeumorphicColors.decorationMaxDarkColor.withOpacity(style.intensity); //<-- intensity act on opacity
    var whiteShadowColor = NeumorphicColors.decorationMaxWhiteColor.withOpacity(style.intensity); //<-- intensity act on opacity

    backgroundPaint = Paint()..color = color;

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

      if (shape.isCircle) {
        layerRect = Rect.fromCircle(
          center: centerOffset,
          radius: this.radius * 2,
        );
      } else {
        layerRect = Rect.fromLTRB(
          offset.dx - this.width,
          offset.dy - this.height,
          offset.dx + 2 * this.width,
          offset.dy + 2 * this.height,
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

    whiteShadowPaint..color = NeumorphicColors.decorationMaxWhiteColor.withOpacity(style.intensity); //<-- intensity act on opacity;
    blackShadowPaint..color = NeumorphicColors.decorationMaxDarkColor.withOpacity(style.intensity); //<-- intensity act on opacity;

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
    } else {
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
    }
  }
}
