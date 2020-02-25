import 'dart:ui';

import 'package:flutter_neumorphic/colors.dart';

import 'flutter_neumorphic.dart';
import 'light_source.dart';
import 'shape.dart';

export 'light_source.dart';
export 'shape.dart';

//region theme
const double _defaultDepth = 4;
const double _defaultIntensity = 0.2;
const double _defaultCurveFactor = 1;
const Color _defaultAccent = NeumorphicColors.accent;
const Color _defaultVariant = NeumorphicColors.variant;
const LightSource _defaultLightSource = LightSource.bottomRight;
const Color _defaultBaseColor = NeumorphicColors.background;

class NeumorphicTheme {
  final Color baseColor;
  final Color accentColor;
  final Color variantColor;
  final double _depth;
  final double intensity;
  final LightSource lightSource;
  final double _curveFactor;

  double get curveFactor => _curveFactor?.clamp(Neumorphic.MIN_CURVE, Neumorphic.MAX_CURVE);
  double get depth => _depth?.clamp(Neumorphic.MIN_DEPTH, Neumorphic.MAX_DEPTH);

  const NeumorphicTheme({
    this.baseColor = _defaultBaseColor,
    double depth = _defaultDepth,
    this.intensity = _defaultIntensity,
    this.accentColor = _defaultAccent,
    this.variantColor = _defaultVariant,
    this.lightSource = _defaultLightSource,
    double curveFactor = _defaultCurveFactor
  }) : this._depth = depth, this._curveFactor = curveFactor;
}
//endregion

//region style
const NeumorphicShape _defaultShape = NeumorphicShape.concave;
const double _defaultBorderRadius = 5;

const neumorphicDefaultTheme = NeumorphicTheme();

class NeumorphicStyle {

  final Color baseColor;
  final double _depth;
  final double intensity;
  final LightSource lightSource;
  final double _curveFactor;

  final double borderRadius;
  final NeumorphicShape shape;

  const NeumorphicStyle({
    this.borderRadius = _defaultBorderRadius,
    this.shape = _defaultShape,
    this.lightSource,
    this.baseColor,
    double curveFactor,
    double depth,
    this.intensity,
  }) : this._depth = depth, this._curveFactor = curveFactor;

  double get curveFactor => _curveFactor?.clamp(Neumorphic.MIN_CURVE, Neumorphic.MAX_CURVE);
  double get depth => _depth?.clamp(Neumorphic.MIN_DEPTH, Neumorphic.MAX_DEPTH);

  NeumorphicStyle copyWithThemeIfNull(NeumorphicTheme theme) {
    return new NeumorphicStyle(
        borderRadius: this.borderRadius,
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
              borderRadius == other.borderRadius &&
              shape == other.shape;

  @override
  int get hashCode =>
      baseColor.hashCode ^
      depth.hashCode ^
      curveFactor.hashCode ^
      intensity.hashCode ^
      lightSource.hashCode ^
      borderRadius.hashCode ^
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
      borderRadius: borderRadius ?? this.borderRadius,
      shape: shape ?? this.shape,
    );
  }

}
//endregion
