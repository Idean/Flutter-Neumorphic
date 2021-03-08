import 'dart:math';
import 'dart:ui';

import '../../../flutter_neumorphic.dart';

abstract class AbstractNeumorphicEmbossPainterCache {
  late Offset _cacheOffset;
  Offset get originOffset => _cacheOffset;

  late double _cacheWidth;
  double get width => _cacheWidth;
  late double _cacheHeight;
  double get height => _cacheHeight;
  late double _cacheRadius;

  late Rect _layerRect;
  Rect get layerRect => _layerRect;

  AbstractNeumorphicEmbossPainterCache();

  bool updateSize({required Offset newOffset, required Size newSize}) {
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

  Rect updateLayerRect({required Offset newOffset, required Size newSize});

  late double _cacheStyleDepth; //old style depth
  late double _depth; //depth used to draw
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

  late Offset _depthOffset;
  Offset get depthOffset => _depthOffset;
  void updateDepthOffset() {
    _depthOffset = this.lightSource.offset.scale(_depth, _depth);
  }

  late Color _cacheColor;
  Color get backgroundColor => _cacheColor;
  bool updateStyleColor(Color newColor) {
    if (_cacheColor != newColor) {
      _cacheColor = newColor;

      return true;
    }
    return false;
  }

  late bool
      _cacheOppositeShadowLightSource; //store the old style lightsource property
  late LightSource _cacheLightSource; //store the old style lightsource

  late LightSource _lightSource; //used to draw
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

  late MaskFilter _maskFilterBlur;
  MaskFilter get maskFilterBlur => _maskFilterBlur;
  void _updateMaskFilter({required double newDepth}) {
    this._maskFilterBlur = MaskFilter.blur(BlurStyle.normal, newDepth);
  }

  late double _styleIntensity;
  late Color _styleShadowLightColor;
  late Color _shadowLightColor;
  Color get shadowLightColor => _shadowLightColor;
  late Color _styleShadowDarkColor;
  late Color _shadowDarkColor;
  Color get shadowDarkColor => _shadowDarkColor;

  Color generateShadowLightColor({required Color color, required double intensity});

  Color generateShadowDarkColor({required Color color, required double intensity});

  bool updateShadowColor({
    required Color newShadowLightColorEmboss,
    required Color newShadowDarkColorEmboss,
    required double newIntensity,
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
  late Path _path;
  Path get path => _path;
  void updatePath({required Path newPath}) {
    this._path = newPath;
    subPaths.clear();
    var pathMetrics = newPath.computeMetrics();
    for (var item in pathMetrics) {
      subPaths.add(item.extractPath(0, item.length));
    }
  }
}
