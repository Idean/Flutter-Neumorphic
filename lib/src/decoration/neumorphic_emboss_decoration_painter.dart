import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import '../NeumorphicBoxShape.dart';
import '../theme/theme.dart';
import 'NeumorphicEmbossPainterCache.dart';

export '../theme/theme.dart';

class NeumorphicEmbossDecorationPainter extends BoxPainter {
  //Color accent;
  final NeumorphicEmbossPainterCache cache = NeumorphicEmbossPainterCache();

  final NeumorphicStyle style;
  final NeumorphicBoxShape shape;

  final Paint backgroundPaint = Paint();
  final Paint whiteShadowPaint = Paint();
  final Paint whiteShadowMaskPaint = Paint()..blendMode = BlendMode.dstOut;
  final Paint blackShadowPaint = Paint();
  final Paint blackShadowMaskPaint = Paint()..blendMode = BlendMode.dstOut;

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

  void _updateCache(
      {Offset offset,
      ImageConfiguration configuration,
      NeumorphicStyle newStyle}) {
    final bool invalidateSize = this.cache.updateSize(
        newOffset: offset,
        newWidth: configuration.size.width,
        newHeight: configuration.size.height,
        newSize: configuration.size);
    if (invalidateSize) {
      cache.updatePath(
          newPath: shape.customShapePathProvider.getPath(configuration.size));
    }

    final bool invalidateLightSource = this
        .cache
        .updateLightSource(style.lightSource, style.oppositeShadowLightSource);
    final bool invalidateColor = this.cache.updateStyleColor(style.color);
    if (invalidateColor) {
      backgroundPaint..color = cache.backgroundColor;
    }

    final bool invalidateDepth = this.cache.updateStyleDepth(style.depth);
    if (invalidateDepth) {
      blackShadowMaskPaint..maskFilter = cache.maskFilterBlur;
      whiteShadowMaskPaint..maskFilter = cache.maskFilterBlur;
    }

    final bool invalidateShadowColors = this.cache.updateShadowColor(
          newShadowLightColorEmboss: style.shadowLightColorEmboss,
          newShadowDarkColorEmboss: style.shadowDarkColorEmboss,
          newIntensity: style.intensity,
        );
    if (invalidateShadowColors) {
      whiteShadowPaint..color = cache.shadowLightColorEmboss;
      blackShadowPaint..color = cache.shadowDarkColorEmboss;
    }

    if (invalidateLightSource || invalidateDepth || invalidateSize) {
      cache.updateTranslations();
    }
  }

  void _paintBackground(Canvas canvas, Path path) {
    canvas
      ..save()
      ..translate(cache.originOffset.dx, cache.originOffset.dy)
      ..drawPath(path, backgroundPaint)
      ..restore();
  }

  void _paintShadows(Canvas canvas, Path path) {
    final Matrix4 matrix4 = Matrix4.identity()
      ..scale(cache.scaleX, cache.scaleY);

    canvas
      ..saveLayer(cache.layerRect, whiteShadowPaint)
      ..translate(cache.originOffset.dx, cache.originOffset.dy)
      ..drawPath(path, whiteShadowPaint)
      ..translate(
          cache.witheShadowLeftTranslation, cache.witheShadowTopTranslation)
      ..drawPath(path.transform(matrix4.storage), whiteShadowMaskPaint)
      ..restore();

    canvas
      ..saveLayer(cache.layerRect, blackShadowPaint)
      ..translate(cache.originOffset.dx, cache.originOffset.dy)
      ..drawPath(path, blackShadowPaint)
      ..translate(
          cache.blackShadowLeftTranslation, cache.blackShadowTopTranslation)
      ..drawPath(path.transform(matrix4.storage), blackShadowMaskPaint)
      ..restore();
  }

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    _updateCache(
        offset: offset, configuration: configuration, newStyle: this.style);
    for (var subPath in cache.subPaths) {
      if (drawBackground) {
        _paintBackground(canvas, subPath);
      }

      if (drawShadow) {
        _paintShadows(canvas, subPath);
      }
    }
  }
}
