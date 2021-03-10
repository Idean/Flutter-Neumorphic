import 'dart:math';
import 'dart:ui';

import '../../../flutter_neumorphic.dart';

abstract class AbstractNeumorphicEmbossPainterCache {
  Offset? _cacheOffset;
  Offset get originOffset => _cacheOffset ?? Offset.zero;

  double? _cacheWidth;
  double get width => _cacheWidth ?? 0;
  double? _cacheHeight;
  double get height => _cacheHeight ?? 0;
  double? _cacheRadius;
  double get cacheRadius => _cacheRadius ?? 0;

  Rect? _layerRect;
  Rect? get layerRect => _layerRect;

  AbstractNeumorphicEmbossPainterCache();

  bool updateSize({required Offset newOffset, required Size newSize}) {
    if (this._cacheOffset != newOffset ||
        this._cacheWidth != newSize.width ||
        this._cacheHeight != newSize.height) {
      this._cacheWidth = newSize.width;
      this._cacheHeight = newSize.height;
      this._cacheOffset = newOffset;

      var middleWidth = newSize.width / 2;
      var middleHeight = newSize.height / 2;

      _layerRect = this.updateLayerRect(newOffset: newOffset, newSize: newSize);

      this._cacheRadius = min(middleWidth, middleHeight);

      return true;
    }

    return false;
  }

  Rect updateLayerRect({required Offset newOffset, required Size newSize});

  double? _cacheStyleDepth; //old style depth
  double? _depth; //depth used to draw
  double get depth => _depth ?? 0; //depth used to draw
  bool updateStyleDepth(double newStyleDepth, double radiusFactor) {
    if (_cacheStyleDepth != newStyleDepth) {
      _cacheStyleDepth = newStyleDepth;

      final depth =
          newStyleDepth.abs().clamp(0.0, _cacheRadius ?? 0 / radiusFactor);
      _depth = depth;

      this._updateMaskFilter(newDepth: depth);

      return true;
    }
    return false;
  }

  Offset? _depthOffset;
  Offset get depthOffset => _depthOffset ?? Offset.zero;
  void updateDepthOffset() {
    if (_depth != null) {
      _depthOffset = this.lightSource.offset.scale(_depth!, _depth!);
    }
  }

  Color? _cacheColor;
  Color get backgroundColor => _cacheColor ?? Colors.transparent;
  bool updateStyleColor(Color newColor) {
    if (_cacheColor != newColor) {
      _cacheColor = newColor;

      return true;
    }
    return false;
  }

  bool?
      _cacheOppositeShadowLightSource; //store the old style lightsource property
  LightSource? _cacheLightSource; //store the old style lightsource

  LightSource? _lightSource; //used to draw
  LightSource get lightSource =>
      _lightSource ?? LightSource.bottom; //used to draw
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

    final cacheLightSource = this._cacheLightSource;
    final cacheOppositeShadowLightSource = this._cacheOppositeShadowLightSource;
    if (cacheOppositeShadowLightSource != null &&
        cacheLightSource != null &&
        (invalidateLightSource || invalidateOppositeLightSource)) {
      if (cacheOppositeShadowLightSource) {
        _lightSource = cacheLightSource.invert();
      } else {
        _lightSource = cacheLightSource;
      }

      return true;
    }

    return false;
  }

  MaskFilter? _maskFilterBlur;
  MaskFilter? get maskFilterBlur => _maskFilterBlur;
  void _updateMaskFilter({required double newDepth}) {
    this._maskFilterBlur = MaskFilter.blur(BlurStyle.normal, newDepth);
  }

  double? _styleIntensity;
  Color? _styleShadowLightColor;
  Color? _shadowLightColor;
  Color? get shadowLightColor => _shadowLightColor;
  Color? _styleShadowDarkColor;
  Color? _shadowDarkColor;
  Color? get shadowDarkColor => _shadowDarkColor;

  Color generateShadowLightColor(
      {required Color color, required double intensity});

  Color generateShadowDarkColor(
      {required Color color, required double intensity});

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
          color: newShadowLightColorEmboss, intensity: newIntensity);

      invalidate = true;
    }
    //dark
    if (invalidate || _styleShadowDarkColor != newShadowDarkColorEmboss) {
      _styleShadowDarkColor = newShadowDarkColorEmboss;
      _shadowDarkColor = this.generateShadowDarkColor(
        color: newShadowDarkColorEmboss,
        intensity: newIntensity,
      );
      invalidate = true;
    }
    return invalidate;
  }

  //call after _cacheWidth & _cacheHeight set
  void updateTranslations();

  final List<Path> subPaths = [];
  Path? _path;
  Path get path => _path ?? Path();
  void updatePath({required Path newPath}) {
    this._path = newPath;
    subPaths.clear();
    var pathMetrics = newPath.computeMetrics();
    for (var item in pathMetrics) {
      subPaths.add(item.extractPath(0, item.length));
    }
  }
}
