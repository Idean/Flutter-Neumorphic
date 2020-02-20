import 'dart:ui';

import 'package:flutter_neumorphic/colors.dart';

import 'light_source.dart';
import 'shape.dart';

export 'light_source.dart';
export 'shape.dart';

const NeumorphicTheme neumorphicDefaultTheme = NeumorphicTheme();

//region theme
const double _defaultBlur = 8;
const double _defaultDistance = 4;
const double _defaultIntensity = 0.2;
const LightSource _defaultLightSource = LightSource.bottomRight;
const Color _defaultBaseColor = NeumorphicColors.background;

class NeumorphicTheme {
  final Color baseColor;
  final double blur;
  final double distance;
  final double intensity;
  final LightSource lightSource;

  const NeumorphicTheme({
    this.baseColor = _defaultBaseColor,
    this.distance = _defaultDistance,
    this.intensity = _defaultIntensity,
    this.blur = _defaultBlur,
    this.lightSource = _defaultLightSource,
  });
}
//endregion

//region style
const NeumorphicShape _defaultShape = NeumorphicShape.concave;
const double _defaultBorderRaious = 5;

class NeumorphicStyle {

  final Color baseColor;
  final double blur;
  final double distance;
  final double intensity;
  final LightSource lightSource;

  final double borderRadius;
  final NeumorphicShape shape;

  const NeumorphicStyle({
    this.borderRadius = _defaultBorderRaious,
    this.shape = _defaultShape,
    this.lightSource,
    this.baseColor,
    this.blur,
    this.distance,
    this.intensity,
  });

  NeumorphicStyle copyWithThemeIfNull(NeumorphicTheme theme) {
    return new NeumorphicStyle(
        borderRadius: this.borderRadius,
        baseColor: this.baseColor ?? theme.baseColor,
        shape: this.shape,
        blur: this.blur ?? theme.blur,
        distance: this.distance ?? theme.distance,
        intensity: this.intensity ?? theme.intensity,
        lightSource: this.lightSource ?? theme.lightSource);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is NeumorphicStyle &&
              runtimeType == other.runtimeType &&
              baseColor == other.baseColor &&
              blur == other.blur &&
              distance == other.distance &&
              intensity == other.intensity &&
              lightSource == other.lightSource &&
              borderRadius == other.borderRadius &&
              shape == other.shape;

  @override
  int get hashCode =>
      baseColor.hashCode ^
      blur.hashCode ^
      distance.hashCode ^
      intensity.hashCode ^
      lightSource.hashCode ^
      borderRadius.hashCode ^
      shape.hashCode;

  NeumorphicStyle copyWith({
    Color baseColor,
    double blur,
    double distance,
    double intensity,
    LightSource lightSource,
    double borderRadius,
    NeumorphicShape shape,
  }) {
    return new NeumorphicStyle(
      baseColor: baseColor ?? this.baseColor,
      blur: blur ?? this.blur,
      distance: distance ?? this.distance,
      intensity: intensity ?? this.intensity,
      lightSource: lightSource ?? this.lightSource,
      borderRadius: borderRadius ?? this.borderRadius,
      shape: shape ?? this.shape,
    );
  }

}
//endregion
