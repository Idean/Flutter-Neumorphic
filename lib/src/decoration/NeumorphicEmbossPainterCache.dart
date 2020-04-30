import 'dart:math';
import 'dart:ui';

import '../../flutter_neumorphic.dart';

class NeumorphicEmbossPainterCache {

  Offset _cacheOffset;
  Offset get originOffset => _cacheOffset;

  double _cacheWidth;
  double get width => _cacheWidth;
  double _cacheHeight;
  double get height => _cacheHeight;
  double _cacheRadius;

  Rect _layerRect;
  Rect get layerRect => _layerRect;

  NeumorphicEmbossPainterCache();

  bool updateSize({Offset newOffset, double newWidth, double newHeight, Size newSize}){
    if (this._cacheOffset != newOffset ||
        this._cacheWidth != newWidth ||
        this._cacheHeight != newHeight) {

      this._cacheWidth = newWidth;
      this._cacheHeight = newHeight;
      this._cacheOffset = newOffset;

      var middleWidth = this._cacheWidth / 2;
      var middleHeight = this._cacheHeight / 2;

      this._layerRect = _cacheOffset & newSize;
      this._cacheRadius = min(middleWidth, middleHeight);

      return true;
    }

    return false;
  }

  double _cacheStyleDepth; //old style depth
  double _depth; //depth used to draw
  double get depth => _depth; //depth used to draw
  bool updateStyleDepth(double newStyleDepth){
    if(_cacheStyleDepth != newStyleDepth){
      _cacheStyleDepth = newStyleDepth;

      _depth = _cacheStyleDepth.abs().clamp(0.0, _cacheRadius / 5);

      this._updateMaskFilter(newDepth: _depth);

      return true;
    }
    return false;
  }

  Color _cacheColor;
  Color get backgroundColor => _cacheColor;
  bool updateStyleColor(Color newColor){
    if(_cacheColor != newColor){
      _cacheColor = newColor;

      return true;
    }
    return false;
  }

  bool _cacheOppositeShadowLightSource; //store the old style lightsource property
  LightSource _cacheLightSource; //store the old style lightsource

  LightSource _lightSource; //used to draw
  LightSource get lightSource => _lightSource; //used to draw
  bool updateLightSource(LightSource newLightSource, bool newOppositeShadowLightSource) {
    bool invalidateLightSource = false;
    if(newLightSource != _cacheLightSource){
      _cacheLightSource = newLightSource;
      invalidateLightSource = true;
    }

    bool invalidateOppositeLightSource = false;
    if(newOppositeShadowLightSource != _cacheOppositeShadowLightSource){
      _cacheOppositeShadowLightSource = newOppositeShadowLightSource;
      invalidateOppositeLightSource = true;
    }

    if(invalidateLightSource || invalidateOppositeLightSource){
      if(_cacheOppositeShadowLightSource) {
        _lightSource = _cacheLightSource.invert();
      } else {
        _lightSource = _cacheLightSource;
      }

      return true;
    }

    return false;
  }

  MaskFilter _maskFilterBlur;
  MaskFilter get maskFilterBlur => _maskFilterBlur;
  void _updateMaskFilter({double newDepth}) {
    this._maskFilterBlur = MaskFilter.blur(BlurStyle.normal, newDepth);
  }

  double _styleIntensity;
  Color _styleShadowLightColorEmboss;
  Color _shadowLightColorEmboss;
  Color get shadowLightColorEmboss => _shadowLightColorEmboss;
  Color _styleShadowDarkColorEmboss;
  Color _shadowDarkColorEmboss;
  Color get shadowDarkColorEmboss => _shadowDarkColorEmboss;

  bool updateShadowColor({Color newShadowLightColorEmboss, Color newShadowDarkColorEmboss, double newIntensity,}) {
    bool invalidateIntensity = false;
    bool invalidate = false;
    if(_styleIntensity != newIntensity){
      invalidate = true;
      invalidateIntensity = true;
      _styleIntensity = newIntensity;
    }
    //light
    if(invalidateIntensity || _styleShadowLightColorEmboss != newShadowLightColorEmboss){
      _styleShadowLightColorEmboss = newShadowLightColorEmboss;
      _shadowLightColorEmboss = NeumorphicColors.embossWhiteColor(
        _styleShadowLightColorEmboss,
        intensity: _styleIntensity,
      );
      invalidate = true;
    }
    //dark
    if(invalidate || _styleShadowDarkColorEmboss != newShadowDarkColorEmboss){
      _styleShadowDarkColorEmboss = newShadowDarkColorEmboss;
      _shadowDarkColorEmboss = NeumorphicColors.embossDarkColor(
        _styleShadowDarkColorEmboss,
        intensity: _styleIntensity,
      );
      invalidate = true;
    }
    return invalidate;
  }

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
  void updateTranslations(){
    this.xDepth = this.lightSource.dx * this.depth;
    this.yDepth = this.lightSource.dy * this.depth;
    this.xPadding = 2 * (1 - this.lightSource.dx.abs()) * this.depth;
    this.yPadding = 2 * (1 - this.lightSource.dy.abs()) * this.depth;

    this.witheShadowLeftTranslation = xDepth - xPadding;
    this.witheShadowTopTranslation = yDepth - yPadding;

    this.blackShadowLeftTranslation = -(xDepth + xPadding);
    this.blackShadowTopTranslation = -(yDepth + yPadding);

    this.scaledWidth = this._cacheWidth + 2 * xPadding;
    this.scaledHeight = this._cacheHeight + 2 * yPadding;

    this.scaleX = this.scaledWidth / this.width;
    this.scaleY = this.scaledHeight / this.height;
  }

  final List<Path> subPaths = [];
  Path _path;
  Path get path => _path;
  void updatePath({Path newPath}) {
    this._path = newPath;
    subPaths.clear();
    var pathMetrics = newPath.computeMetrics();
    for (var item in pathMetrics) {
      subPaths.add(item.extractPath(0, item.length));
    }
  }
}