import 'dart:ui';

import 'package:flutter_neumorphic/colors.dart';

import 'light_source.dart';
import 'shape.dart';

export 'light_source.dart';
export 'shape.dart';

const NeumorphicTheme neumorphicDefaultTheme = NeumorphicTheme();

//region theme
const double _defaultDistance = 4;
const double _defaultIntensity = 0.2;
const double _defaultCurveHeight = 6;
const LightSource _defaultLightSource = LightSource.bottomRight;
const Color _defaultBaseColor = NeumorphicColors.background;

class NeumorphicTheme {
  final Color baseColor;
  final double distance;
  final double intensity;
  final LightSource lightSource;
  final double curveHeight;

  const NeumorphicTheme({
    this.baseColor = _defaultBaseColor,
    this.distance = _defaultDistance,
    this.intensity = _defaultIntensity,
    this.lightSource = _defaultLightSource,
    this.curveHeight = _defaultCurveHeight
  });
}
//endregion

//region style
const NeumorphicShape _defaultShape = NeumorphicShape.concave;
const double _defaultBorderRaious = 5;

class NeumorphicStyle {

  final Color baseColor;
  final double distance;
  final double intensity;
  final LightSource lightSource;
  final double curveHeight;

  final double borderRadius;
  final NeumorphicShape shape;

  const NeumorphicStyle({
    this.borderRadius = _defaultBorderRaious,
    this.shape = _defaultShape,
    this.lightSource,
    this.baseColor,
    this.curveHeight,
    this.distance,
    this.intensity,
  });

  NeumorphicStyle copyWithThemeIfNull(NeumorphicTheme theme) {
    return new NeumorphicStyle(
        borderRadius: this.borderRadius,
        baseColor: this.baseColor ?? theme.baseColor,
        shape: this.shape,
        distance: this.distance ?? theme.distance,
        intensity: this.intensity ?? theme.intensity,
        curveHeight: this.curveHeight ?? theme.curveHeight,
        lightSource: this.lightSource ?? theme.lightSource);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is NeumorphicStyle &&
              runtimeType == other.runtimeType &&
              baseColor == other.baseColor &&
              distance == other.distance &&
              curveHeight == other.curveHeight &&
              intensity == other.intensity &&
              lightSource == other.lightSource &&
              borderRadius == other.borderRadius &&
              shape == other.shape;

  @override
  int get hashCode =>
      baseColor.hashCode ^
      distance.hashCode ^
      curveHeight.hashCode ^
      intensity.hashCode ^
      lightSource.hashCode ^
      borderRadius.hashCode ^
      shape.hashCode;

  NeumorphicStyle copyWith({
    Color baseColor,
    double distance,
    double intensity,
    double curveHeight,
    LightSource lightSource,
    double borderRadius,
    NeumorphicShape shape,
  }) {
    return new NeumorphicStyle(
      baseColor: baseColor ?? this.baseColor,
      distance: distance ?? this.distance,
      intensity: intensity ?? this.intensity,
      curveHeight: curveHeight ?? this.curveHeight,
      lightSource: lightSource ?? this.lightSource,
      borderRadius: borderRadius ?? this.borderRadius,
      shape: shape ?? this.shape,
    );
  }

}
//endregion
