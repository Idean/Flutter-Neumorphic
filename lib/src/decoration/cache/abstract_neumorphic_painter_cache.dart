import 'dart:math';
import 'dart:ui';

import '../../../flutter_neumorphic.dart';

abstract class AbstractNeumorphicEmbossPainterCache {
  bool get isEmpty => _cacheOffset == null;

  Offset _cacheOffset;
  Offset get originOffset => _cacheOffset;

  double _cacheWidth;
  double get width => _cacheWidth;
  double _cacheHeight;
  double get height => _cacheHeight;
  double _cacheRadius;

  Rect _layerRect;
  Rect get layerRect => _layerRect;

  AbstractNeumorphicEmbossPainterCache();

  bool updateSize({Offset newOffset, Size newSize}) {
    if (this._cacheOffset != newOffset ||
        this._cacheWidth != newSize.width ||
        this._cacheHeight != newSize.height) {
      this._cacheWidth = newSize.width;
      this._cacheHeight = newSize.height;
      this._cacheOffset = newOffset;

      var middleWidth = this._cacheWidth / 2;
      var middleHeight = this._cacheHeight / 2;

      _layerRect = this.updateLayerRect(newOffset: newOffset, newSize: newSize);

      this._cacheRadius = min(middleWidth, middleHeight);

      return true;
    }

    return false;
  }

  Rect updateLayerRect({Offset newOffset, Size newSize});

  double _cacheStyleDepth; //old style depth
  double _depth; //depth used to draw
  double get depth => _depth; //depth used to draw
  bool updateStyleDepth(double newStyleDepth, double radiusFactor) {
    if (_cacheStyleDepth != newStyleDepth) {
      _cacheStyleDepth = newStyleDepth;

      _depth = _cacheStyleDepth.abs().clamp(0.0, _cacheRadius / radiusFactor);

      this._updateMaskFilter(newDepth: _depth);

      return true;
    }
    return false;
  }

  Offset _depthOffset;
  Offset get depthOffset => _depthOffset;
  void updateDepthOffset() {
    _depthOffset = this.lightSource.offset.scale(_depth, _depth);
  }

  Color _cacheColor;
  Color get backgroundColor => _cacheColor;
  bool updateStyleColor(Color newColor) {
    if (_cacheColor != newColor) {
      _cacheColor = newColor;

      return true;
    }
    return false;
  }

  bool
      _cacheOppositeShadowLightSource; //store the old style lightsource property
  LightSource _cacheLightSource; //store the old style lightsource

  LightSource _lightSource; //used to draw
  LightSource get lightSource => _lightSource; //used to draw
  bool updateLightSource(
      LightSource newLightSource, bool newOppositeShadowLightSource) {
    bool invalidateLightSource = false;
    if (newLightSource != _cacheLightSource) {
      _cacheLightSource = newLightSource;
      invalidateLightSource = true;
    }

    bool invalidateOppositeLightSource = false;
    if (newOppositeShadowLightSource != _cacheOppositeShadowLightSource) {
      _cacheOppositeShadowLightSource = newOppositeShadowLightSource;
      invalidateOppositeLightSource = true;
    }

    if (invalidateLightSource || invalidateOppositeLightSource) {
      if (_cacheOppositeShadowLightSource) {
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
  Color _styleShadowLightColor;
  Color _shadowLightColor;
  Color get shadowLightColor => _shadowLightColor;
  Color _styleShadowDarkColor;
  Color _shadowDarkColor;
  Color get shadowDarkColor => _shadowDarkColor;

  Color generateShadowLightColor({Color color, double intensity});

  Color generateShadowDarkColor({Color color, double intensity});

  bool updateShadowColor({
    Color newShadowLightColorEmboss,
    Color newShadowDarkColorEmboss,
    double newIntensity,
  }) {
    bool invalidateIntensity = false;
    bool invalidate = false;
    if (_styleIntensity != newIntensity) {
      invalidate = true;
      invalidateIntensity = true;
      _styleIntensity = newIntensity;
    }
    //light
    if (invalidateIntensity ||
        _styleShadowLightColor != newShadowLightColorEmboss) {
      _styleShadowLightColor = newShadowLightColorEmboss;
      _shadowLightColor = this.generateShadowLightColor(
          color: _styleShadowLightColor, intensity: _styleIntensity);

      invalidate = true;
    }
    //dark
    if (invalidate || _styleShadowDarkColor != newShadowDarkColorEmboss) {
      _styleShadowDarkColor = newShadowDarkColorEmboss;
      _shadowDarkColor = this.generateShadowDarkColor(
        color: _styleShadowDarkColor,
        intensity: _styleIntensity,
      );
      invalidate = true;
    }
    return invalidate;
  }

  //call after _cacheWidth & _cacheHeight set
  void updateTranslations();

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
