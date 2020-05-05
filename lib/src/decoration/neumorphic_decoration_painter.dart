import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import '../neumorphic_box_shape.dart';
import '../theme/theme.dart';
import 'cache/neumorphic_painter_cache.dart';
import 'neumorphic_box_decoration_helper.dart';
import 'neumorphic_emboss_decoration_painter.dart';

class NeumorphicDecorationPainter extends BoxPainter {
  final NeumorphicStyle style;
  final NeumorphicBoxShape shape;

  NeumorphicPainterCache _cache;

  Paint _backgroundPaint;
  Paint _whiteShadowPaint;
  Paint _whiteShadowMaskPaint;
  Paint _blackShadowPaint;
  Paint _blackShadowMaskPaint;
  Paint _gradientPaint;
  Paint _borderPaint;

  void generatePainters() {
    this._backgroundPaint = Paint();
    this._whiteShadowPaint = Paint();
    this._whiteShadowMaskPaint = Paint()..blendMode = BlendMode.dstOut;
    this._blackShadowPaint = Paint();
    this._blackShadowMaskPaint = Paint()..blendMode = BlendMode.dstOut;
    this._gradientPaint = Paint();

    this._borderPaint = Paint()
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.bevel
      ..style = PaintingStyle.stroke;
  }

  final bool drawGradient;
  final bool drawShadow;
  final bool drawBackground;
  final bool renderingByPath;

  NeumorphicDecorationPainter({
    @required this.style,
    @required this.shape,
    @required this.drawGradient,
    @required this.drawShadow,
    @required this.drawBackground,
    @required VoidCallback onChanged,
    this.renderingByPath = true,
  }) : super(onChanged);

  void _updateCache(Offset offset, ImageConfiguration configuration) {
    if (_cache == null) {
      _cache = NeumorphicPainterCache();
      generatePainters();
    } else {
      //print("reuse painter");
    }

    final bool invalidateSize =
        this._cache.updateSize(newOffset: offset, newSize: configuration.size);
    if (invalidateSize) {
      _cache.updatePath(
          newPath: shape.customShapePathProvider.getPath(configuration.size));
    }

    final bool invalidateLightSource = this
        ._cache
        .updateLightSource(style.lightSource, style.oppositeShadowLightSource);
    final bool invalidateColor = this._cache.updateStyleColor(style.color);
    if (invalidateColor) {
      _backgroundPaint..color = _cache.backgroundColor;
    }

    final bool invalidateDepth = this._cache.updateStyleDepth(style.depth, 3);
    if (invalidateDepth) {
      _blackShadowPaint..maskFilter = _cache.maskFilterBlur;
      _whiteShadowPaint..maskFilter = _cache.maskFilterBlur;
    }

    final bool invalidateShadowColors = this._cache.updateShadowColor(
          newShadowLightColorEmboss: style.shadowLightColor,
          newShadowDarkColorEmboss: style.shadowDarkColor,
          newIntensity: style.intensity,
        );
    if (invalidateShadowColors) {
      _whiteShadowPaint..color = _cache.shadowLightColor;
      _blackShadowPaint..color = _cache.shadowDarkColor;
    }

    if (invalidateDepth || invalidateLightSource) {
      _cache.updateDepthOffset();
    }

    if (invalidateLightSource || invalidateDepth || invalidateSize) {
      _cache.updateTranslations();
    }
  }

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    _updateCache(offset, configuration);

    for (var subPath in _cache.subPaths) {
      if (drawShadow) {
        _drawShadow(offset: offset, canvas: canvas, path: subPath);
      }
    }

    if (renderingByPath) {
      for (var subPath in _cache.subPaths) {
        _drawElement(offset: offset, canvas: canvas, path: subPath);
      }
    } else {
      _drawElement(offset: offset, canvas: canvas, path: _cache.path);
    }
  }

  void _drawElement({Canvas canvas, Offset offset, Path path}) {
    if (drawBackground) {
      _drawBackground(offset: offset, canvas: canvas, path: path);
    }
    if (this.drawGradient) {
      _drawGradient(offset: offset, canvas: canvas, path: path);
    }
    if (style.border != null && style.border.isEnabled) {
      _drawBorder(canvas: canvas, offset: offset, path: path);
    }
  }

  void _drawBorder({Canvas canvas, Offset offset, Path path}) {
    if (style.border.width > 0) {
      canvas
        ..save()
        ..translate(offset.dx, offset.dy)
        ..drawPath(
            path,
            _borderPaint
              ..color = style.border.color ?? Color(0x00000000)
              ..strokeWidth = style.border.width ?? 0)
        ..restore();
    }
  }

  void _drawBackground({Canvas canvas, Offset offset, Path path}) {
    canvas
      ..save()
      ..translate(offset.dx, offset.dy)
      ..drawPath(path, _backgroundPaint)
      ..restore();
  }

  void _drawShadow({Canvas canvas, Offset offset, Path path}) {
    if (style.depth.abs() >= 0.1) {
      canvas
        ..saveLayer(_cache.layerRect, _whiteShadowPaint)
        ..translate(offset.dx + _cache.depthOffset.dx,
            offset.dy + _cache.depthOffset.dy)
        ..drawPath(path, _whiteShadowPaint)
        ..translate(-_cache.depthOffset.dx, -_cache.depthOffset.dy)
        ..drawPath(path, _whiteShadowMaskPaint)
        ..restore();

      canvas
        ..saveLayer(_cache.layerRect, _blackShadowPaint)
        ..translate(offset.dx - _cache.depthOffset.dx,
            offset.dy - _cache.depthOffset.dy)
        ..drawPath(path, _blackShadowPaint)
        ..translate(_cache.depthOffset.dx, _cache.depthOffset.dy)
        ..drawPath(path, _blackShadowMaskPaint)
        ..restore();
    }
  }

  void _drawGradient({Canvas canvas, Offset offset, Path path}) {
    if (style.shape == NeumorphicShape.concave ||
        style.shape == NeumorphicShape.convex) {
      final pathRect = path.getBounds();

      _gradientPaint
        ..shader = getGradientShader(
          gradientRect: pathRect,
          intensity: style.surfaceIntensity,
          source: style.shape == NeumorphicShape.concave
              ? this.style.lightSource
              : this.style.lightSource.invert(),
        );

      canvas
        ..saveLayer(
          pathRect.translate(offset.dx, offset.dy),
          _gradientPaint,
        )
        ..translate(offset.dx, offset.dy)
        ..drawPath(path, _gradientPaint)
        ..restore();
    }
  }
}
