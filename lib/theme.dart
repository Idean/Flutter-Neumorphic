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
const double _defaultIntensity = 0.25;
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

class NeumorphicStyle extends NeumorphicTheme {
  final double borderRadius;
  final bool gradientBackground;
  final NeumorphicShape shape;

  const NeumorphicStyle({
    this.borderRadius = _defaultBorderRaious,
    this.gradientBackground = true,
    this.shape = _defaultShape,
    Color baseColor,
    LightSource lightSource,
    double blur,
    double distance,
    double intensity,
  }) : super(
          baseColor: baseColor,
          lightSource: lightSource,
          blur: blur,
          distance: distance,
          intensity: intensity,
        );

  NeumorphicStyle copyWithThemeIfNull(NeumorphicTheme theme) {
    return new NeumorphicStyle(
        borderRadius: this.borderRadius,
        gradientBackground: this.gradientBackground,
        shape: this.shape,
        blur: this.blur ?? theme.blur,
        distance: this.distance ?? theme.distance,
        intensity: this.intensity ?? theme.intensity,
        lightSource: this.lightSource ?? theme.lightSource,
        baseColor: this.baseColor ?? theme.baseColor);
  }
}
//endregion
