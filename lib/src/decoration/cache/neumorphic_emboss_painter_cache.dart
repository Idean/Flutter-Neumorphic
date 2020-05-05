import 'dart:ui';

import '../../../flutter_neumorphic.dart';
import 'abstract_neumorphic_painter_cache.dart';

class NeumorphicEmbossPainterCache
    extends AbstractNeumorphicEmbossPainterCache {
  @override
  Color generateShadowDarkColor({Color color, double intensity}) {
    return NeumorphicColors.embossDarkColor(
      color,
      intensity: intensity,
    );
  }

  @override
  Color generateShadowLightColor({Color color, double intensity}) {
    return NeumorphicColors.embossWhiteColor(
      color,
      intensity: intensity,
    );
  }

  Rect updateLayerRect({Offset newOffset, Size newSize}) {
    return newOffset & newSize;
  }

  NeumorphicEmbossPainterCache() : super();

  double xDepth;
  double yDepth;
  double xPadding;
  double yPadding;
  double blackShadowLeftTranslation;
  double blackShadowTopTranslation;
  double witheShadowLeftTranslation;
  double witheShadowTopTranslation;
  double scaledWidth;
  double scaledHeight;

  double scaleX;
  double scaleY;

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
