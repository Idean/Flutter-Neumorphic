import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import '../neumorphic_box_shape.dart';
import '../theme/theme.dart';
import 'cache/neumorphic_emboss_painter_cache.dart';

export '../theme/theme.dart';

class NeumorphicEmbossDecorationPainter extends BoxPainter {
  NeumorphicEmbossPainterCache _cache;

  final NeumorphicStyle style;
  final NeumorphicBoxShape shape;

  Paint _backgroundPaint;
  Paint _whiteShadowPaint;
  Paint _whiteShadowMaskPaint;
  Paint _blackShadowPaint;
  Paint _blackShadowMaskPaint;
  Paint _borderPaint;

  final bool drawShadow;
  final bool drawBackground;

  NeumorphicEmbossDecorationPainter(
      {@required this.style,
      @required NeumorphicBoxShape shape,
      @required this.drawBackground,
      @required this.drawShadow,
      @required VoidCallback onChanged})
      : this.shape = shape ?? NeumorphicBoxShape.rect(),
        super(onChanged);

  void _generatePainters() {
    this._backgroundPaint = Paint();
    this._whiteShadowPaint = Paint();
    this._whiteShadowMaskPaint = Paint()..blendMode = BlendMode.dstOut;
    this._blackShadowPaint = Paint();
    this._blackShadowMaskPaint = Paint()..blendMode = BlendMode.dstOut;

    this._borderPaint = Paint()
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.bevel
      ..style = PaintingStyle.stroke;
  }

  void _updateCache(
      {Offset offset,
      ImageConfiguration configuration,
      NeumorphicStyle newStyle}) {
    if (_cache == null) {
      _cache = NeumorphicEmbossPainterCache();
      _generatePainters();
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

    final bool invalidateDepth = this._cache.updateStyleDepth(style.depth, 5);
    if (invalidateDepth) {
      _blackShadowMaskPaint..maskFilter = _cache.maskFilterBlur;
      _whiteShadowMaskPaint..maskFilter = _cache.maskFilterBlur;
    }

    final bool invalidateShadowColors = this._cache.updateShadowColor(
          newShadowLightColorEmboss: style.shadowLightColorEmboss,
          newShadowDarkColorEmboss: style.shadowDarkColorEmboss,
          newIntensity: style.intensity,
        );
    if (invalidateShadowColors) {
      _whiteShadowPaint..color = _cache.shadowLightColor;
      _blackShadowPaint..color = _cache.shadowDarkColor;
    }

    if (invalidateLightSource || invalidateDepth || invalidateSize) {
      _cache.updateTranslations();
    }
  }

  void _paintBackground(Canvas canvas, Path path) {
    canvas
      ..save()
      ..translate(_cache.originOffset.dx, _cache.originOffset.dy)
      ..drawPath(path, _backgroundPaint)
      ..restore();
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

  void _paintShadows(Canvas canvas, Path path) {
    final Matrix4 matrix4 = Matrix4.identity()
      ..scale(_cache.scaleX, _cache.scaleY);

    canvas
      ..saveLayer(_cache.layerRect, _whiteShadowPaint)
      ..translate(_cache.originOffset.dx, _cache.originOffset.dy)
      ..drawPath(path, _whiteShadowPaint)
      ..translate(
          _cache.witheShadowLeftTranslation, _cache.witheShadowTopTranslation)
      ..drawPath(path.transform(matrix4.storage), _whiteShadowMaskPaint)
      ..restore();

    canvas
      ..saveLayer(_cache.layerRect, _blackShadowPaint)
      ..translate(_cache.originOffset.dx, _cache.originOffset.dy)
      ..drawPath(path, _blackShadowPaint)
      ..translate(
          _cache.blackShadowLeftTranslation, _cache.blackShadowTopTranslation)
      ..drawPath(path.transform(matrix4.storage), _blackShadowMaskPaint)
      ..restore();
  }

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    _updateCache(
        offset: offset, configuration: configuration, newStyle: this.style);
    for (var subPath in _cache.subPaths) {
      if (drawBackground) {
        _paintBackground(canvas, subPath);
      }

      if (style.border != null && style.border.isEnabled) {
        _drawBorder(canvas: canvas, offset: offset, path: subPath);
      }

      if (drawShadow) {
        _paintShadows(canvas, subPath);
      }
    }
  }
}
