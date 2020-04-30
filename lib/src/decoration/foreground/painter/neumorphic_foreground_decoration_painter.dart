import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import '../../../NeumorphicBoxShape.dart';
import '../../../theme/theme.dart';
import '../../neumorphic_box_decoration_helper.dart';

class NeumorphicForegroundDecorationPainter extends BoxPainter {
  NeumorphicStyle style;
  NeumorphicBoxShape shape;

  Paint backgroundPaint;
  Paint gradientPaint;

  Size size;

  Path path;

  bool enabled;
  bool renderingByPath;

  NeumorphicForegroundDecorationPainter(
      {@required this.style,
      @required this.shape,
      @required this.enabled,
      @required VoidCallback onChanged,
      this.renderingByPath = true})
      : super(onChanged) {
    backgroundPaint = Paint();
    gradientPaint = Paint()..blendMode = BlendMode.srcATop;
  }

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {

    backgroundPaint.color = style.color;

    if (size != configuration.size) {
      size = configuration.size;
      path = shape.customShapePathProvider.getPath(size);
    }

    if (enabled) {
      if (style.shape == NeumorphicShape.concave ||
          style.shape == NeumorphicShape.convex) {
        if (renderingByPath) {
          var pathMetrics = path.computeMetrics();

          for (var item in pathMetrics) {
            var subPath = item.extractPath(0, item.length);

            var subPathRect = subPath.getBounds();

            gradientPaint
              ..shader = getGradientShader(
                gradientRect: subPathRect,
                intensity: style.surfaceIntensity,
                source: style.shape == NeumorphicShape.concave
                    ? this.style.lightSource
                    : this.style.lightSource.invert(),
              );

            canvas.saveLayer(
              subPathRect.translate(offset.dx, offset.dy),
              gradientPaint,
            );
            canvas.translate(offset.dx, offset.dy);
            canvas.drawPath(subPath, backgroundPaint);
            canvas.drawRect(subPathRect, gradientPaint);
            canvas.restore();
          }
        } else {
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
          canvas.drawPath(path, backgroundPaint);
          canvas.drawRect(pathRect, gradientPaint);
          canvas.restore();
        }
      }
    }
  }
}
