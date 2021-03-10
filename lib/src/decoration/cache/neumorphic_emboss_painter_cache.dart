import 'dart:ui';

import '../../../flutter_neumorphic.dart';
import 'abstract_neumorphic_painter_cache.dart';

class NeumorphicEmbossPainterCache
    extends AbstractNeumorphicEmbossPainterCache {
  @override
  Color generateShadowDarkColor(
      {required Color color, required double intensity}) {
    return NeumorphicColors.embossDarkColor(
      color,
      intensity: intensity,
    );
  }

  @override
  Color generateShadowLightColor(
      {required Color color, required double intensity}) {
    return NeumorphicColors.embossWhiteColor(
      color,
      intensity: intensity,
    );
  }

  Rect updateLayerRect({required Offset newOffset, required Size newSize}) {
    return newOffset & newSize;
  }

  NeumorphicEmbossPainterCache() : super();

  late double xDepth;
  late double yDepth;
  late double xPadding;
  late double yPadding;
  late double blackShadowLeftTranslation;
  late double blackShadowTopTranslation;
  late double witheShadowLeftTranslation;
  late double witheShadowTopTranslation;
  late double scaledWidth;
  late double scaledHeight;

  late double scaleX;
  late double scaleY;

  //call after _cacheWidth & _cacheHeight set
  @override
  void updateTranslations() {
    this.xDepth = this.lightSource.dx * this.depth;
    this.yDepth = this.lightSource.dy * this.depth;
    this.xPadding = 2 * (1 - this.lightSource.dx.abs()) * this.depth;
    this.yPadding = 2 * (1 - this.lightSource.dy.abs()) * this.depth;

    this.witheShadowLeftTranslation = xDepth - xPadding;
    this.witheShadowTopTranslation = yDepth - yPadding;

    this.blackShadowLeftTranslation = -(xDepth + xPadding);
    this.blackShadowTopTranslation = -(yDepth + yPadding);

    this.scaledWidth = this.width + 2 * xPadding;
    this.scaledHeight = this.height + 2 * yPadding;

    this.scaleX = this.scaledWidth / this.width;
    this.scaleY = this.scaledHeight / this.height;
  }
}
