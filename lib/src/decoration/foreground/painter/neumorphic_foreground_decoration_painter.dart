import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';

import '../../../NeumorphicBoxShape.dart';
import '../../../theme/theme.dart';
import '../../neumorphic_box_decoration_helper.dart';

class NeumorphicForegroundDecorationPainter extends BoxPainter {

  NeumorphicStyle style;
  NeumorphicBoxShape shape;

  Paint backgroundPaint;
  Paint gradientPaint;

  double width;
  double height;

  Rect layerRect;
  Rect dstRect;
  Path customPath;

  Offset originOffset;

  bool enabled;

  NeumorphicForegroundDecorationPainter({
    /* this.accent, */
    @required this.style,
    @required NeumorphicBoxShape shape,
    @required this.enabled,
    @required VoidCallback onChanged,
  })
      : this.shape = shape ?? NeumorphicBoxShape.rect(),
        super(onChanged) {
    backgroundPaint = Paint()
      ..color = style.color;

    gradientPaint = Paint();
  }

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {

    var width = configuration.size.width;
    var height = configuration.size.height;

    if (this.originOffset != offset ||
        this.width != width ||
        this.height != height) {
      this.width = width;
      this.height = height;
      this.originOffset = offset;

      this.dstRect = Rect.fromLTWH(
        this.originOffset.dx,
        this.originOffset.dy,
        this.width,
        this.height,
      );

      customPath = shape.customShapePathProvider.getPath(configuration.size);

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
              ? this.style.lightSource
              : this.style.lightSource.invert(),
        );
    }

    if (enabled) {
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
