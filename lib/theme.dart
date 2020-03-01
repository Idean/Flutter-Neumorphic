import 'dart:ui';

import 'package:flutter_neumorphic/colors.dart';

import 'flutter_neumorphic.dart';
import 'light_source.dart';
import 'shape.dart';

export 'light_source.dart';
export 'shape.dart';

//region theme
const double _defaultDepth = 4;
const double _defaultIntensity = 0.5;
const double _defaultCurveFactor = 1;
const Color _defaultAccent = NeumorphicColors.accent;
const Color _defaultVariant = NeumorphicColors.variant;
const LightSource _defaultLightSource = LightSource.topLeft;
const Color _defaultBaseColor = NeumorphicColors.background;

class NeumorphicThemeData {
  final Color baseColor;
  final Color accentColor;
  final Color variantColor;
  final double _depth;
  final double _intensity;
  final LightSource lightSource;
  final double _curveFactor;

  double get curveFactor => _curveFactor?.clamp(Neumorphic.MIN_CURVE, Neumorphic.MAX_CURVE);
  double get depth => _depth?.clamp(Neumorphic.MIN_DEPTH, Neumorphic.MAX_DEPTH);
  double get intensity => _intensity?.clamp(Neumorphic.MIN_INTENSITY, Neumorphic.MAX_INTENSITY);

  const NeumorphicThemeData({
    this.baseColor = _defaultBaseColor,
    double depth = _defaultDepth,
    double intensity = _defaultIntensity,
    this.accentColor = _defaultAccent,
    this.variantColor = _defaultVariant,
    this.lightSource = _defaultLightSource,
    double curveFactor = _defaultCurveFactor
  }) : this._depth = depth, this._curveFactor = curveFactor, this._intensity = intensity;

  @override
  String toString() {
    return 'NeumorphicTheme{baseColor: $baseColor, accentColor: $accentColor, variantColor: $variantColor, _depth: $_depth, intensity: $intensity, lightSource: $lightSource, _curveFactor: $_curveFactor}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is NeumorphicThemeData &&
              runtimeType == other.runtimeType &&
              baseColor == other.baseColor &&
              accentColor == other.accentColor &&
              variantColor == other.variantColor &&
              _depth == other._depth &&
              intensity == other.intensity &&
              lightSource == other.lightSource &&
              _curveFactor == other._curveFactor;

  @override
  int get hashCode =>
      baseColor.hashCode ^
      accentColor.hashCode ^
      variantColor.hashCode ^
      _depth.hashCode ^
      intensity.hashCode ^
      lightSource.hashCode ^
      _curveFactor.hashCode;





}
//endregion

//region style
const NeumorphicShape _defaultShape = NeumorphicShape.concave;
const double _defaultBorderRadius = 5;

const neumorphicDefaultTheme = NeumorphicThemeData(
  baseColor: NeumorphicColors.background,
  accentColor: NeumorphicColors.accent,
  variantColor: NeumorphicColors.variant,
);
const neumorphicDefaultDarkTheme = NeumorphicThemeData(
  baseColor: NeumorphicColors.darkBackground,
  accentColor: NeumorphicColors.darkAccent,
  variantColor: NeumorphicColors.darkVariant,
);

class NeumorphicStyle {

  final Color baseColor;
  final double _depth;
  final double _intensity;
  final LightSource lightSource;
  final double _curveFactor;

  final NeumorphicShape shape;

  const NeumorphicStyle({
    this.shape = _defaultShape,
    this.lightSource,
    this.baseColor,
    double curveFactor,
    double depth,
    double intensity,
  }) : this._depth = depth, this._curveFactor = curveFactor, this._intensity = intensity;

  double get curveFactor => _curveFactor?.clamp(Neumorphic.MIN_CURVE, Neumorphic.MAX_CURVE);
  double get depth => _depth?.clamp(Neumorphic.MIN_DEPTH, Neumorphic.MAX_DEPTH);
  double get intensity => _intensity?.clamp(Neumorphic.MIN_INTENSITY, Neumorphic.MAX_INTENSITY);

  NeumorphicStyle copyWithThemeIfNull(NeumorphicThemeData theme) {
    return new NeumorphicStyle(
        baseColor: this.baseColor ?? theme.baseColor,
        shape: this.shape,
        depth: this.depth ?? theme.depth,
        intensity: this.intensity ?? theme.intensity,
        curveFactor: this.curveFactor ?? theme.curveFactor,
        lightSource: this.lightSource ?? theme.lightSource);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is NeumorphicStyle &&
              runtimeType == other.runtimeType &&
              baseColor == other.baseColor &&
              depth == other.depth &&
              curveFactor == other.curveFactor &&
              intensity == other.intensity &&
              lightSource == other.lightSource &&
              shape == other.shape;

  @override
  int get hashCode =>
      baseColor.hashCode ^
      depth.hashCode ^
      curveFactor.hashCode ^
      intensity.hashCode ^
      lightSource.hashCode ^
      shape.hashCode;

  NeumorphicStyle copyWith({
    Color baseColor,
    double depth,
    double intensity,
    double curveFactor,
    LightSource lightSource,
    double borderRadius,
    NeumorphicShape shape,
  }) {
    return new NeumorphicStyle(
      baseColor: baseColor ?? this.baseColor,
      depth: depth ?? this.depth,
      intensity: intensity ?? this.intensity,
      curveFactor: curveFactor ?? this.curveFactor,
      lightSource: lightSource ?? this.lightSource,
      shape: shape ?? this.shape,
    );
  }

  @override
  String toString() {
    return 'NeumorphicStyle{baseColor: $baseColor, _depth: $_depth, intensity: $intensity, lightSource: $lightSource, _curveFactor: $_curveFactor, shape: $shape}';
  }


}
//endregion
