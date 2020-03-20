import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter_neumorphic/src/widget/container.dart';

import '../colors.dart';
import '../light_source.dart';
import '../shape.dart';

export '../colors.dart';
export '../light_source.dart';
export '../shape.dart';

//region theme
const double _defaultDepth = 4;
const double _defaultIntensity = 0.5;
const Color _defaultAccent = NeumorphicColors.accent;
const Color _defaultVariant = NeumorphicColors.variant;
const Color _defaultDisabledColor = NeumorphicColors.disabled;
const Color _defaultTextColor = NeumorphicColors.defaultTextColor;
const LightSource _defaultLightSource = LightSource.topLeft;
const Color _defaultBaseColor = NeumorphicColors.background;

/// Used with the NeumorphicTheme
///
/// ```
/// NeumorphicTheme(
///   theme: NeumorphicThemeData(...)
///   darkTheme: : NeumorphicThemeData(...)
///   child: ...
/// )`
/// ``
///
/// Contains all default values used in child Neumorphic Elements as
/// default colors : baseColor, accentColor, variantColor
/// default depth & intensities, used to generate white / dark shadows
/// default lightsource, used to calculate the angle of the shadow
/// @see [LightSource]
///
@immutable
class NeumorphicThemeData {
  final Color baseColor;
  final Color accentColor;
  final Color variantColor;
  final Color disabledColor;
  final Color defaultTextColor; //TODO maybe use TextStyle here
  final double _depth;
  final double _intensity;
  final LightSource lightSource;

  /// Get this theme's depth, clamp to min/max neumorphic constants
  double get depth => _depth?.clamp(Neumorphic.MIN_DEPTH, Neumorphic.MAX_DEPTH);

  /// Get this theme's intensity, clamp to min/max neumorphic constants
  double get intensity =>
      _intensity?.clamp(Neumorphic.MIN_INTENSITY, Neumorphic.MAX_INTENSITY);

  const NeumorphicThemeData({
    this.baseColor = _defaultBaseColor,
    double depth = _defaultDepth,
    double intensity = _defaultIntensity,
    this.accentColor = _defaultAccent,
    this.variantColor = _defaultVariant,
    this.disabledColor = _defaultDisabledColor,
    this.defaultTextColor = _defaultTextColor,
    this.lightSource = _defaultLightSource,
  })  : this._depth = depth,
        this._intensity = intensity;

  const NeumorphicThemeData.dark({
    this.baseColor = NeumorphicColors.darkBackground,
    double depth = _defaultDepth,
    double intensity = _defaultIntensity,
    this.accentColor = _defaultAccent,
    this.variantColor = NeumorphicColors.darkVariant,
    this.disabledColor = NeumorphicColors.darkDisabled,
    this.defaultTextColor = NeumorphicColors.darkDefaultTextColor,
    this.lightSource = _defaultLightSource,
  })  : this._depth = depth,
        this._intensity = intensity;


  @override
  String toString() {
    return 'NeumorphicTheme{baseColor: $baseColor, accentColor: $accentColor, variantColor: $variantColor, disabledColor: $disabledColor, _depth: $_depth, intensity: $intensity, lightSource: $lightSource}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NeumorphicThemeData &&
          runtimeType == other.runtimeType &&
          baseColor == other.baseColor &&
          accentColor == other.accentColor &&
          disabledColor == other.disabledColor &&
          variantColor == other.variantColor &&
          defaultTextColor == other.defaultTextColor &&
          _depth == other._depth &&
          _intensity == other._intensity &&
          lightSource == other.lightSource;

  @override
  int get hashCode =>
      baseColor.hashCode ^
      accentColor.hashCode ^
      variantColor.hashCode ^
      disabledColor.hashCode ^
      defaultTextColor.hashCode ^
      _depth.hashCode ^
      _intensity.hashCode ^
      lightSource.hashCode;

  /// Create a copy of this theme
  /// With possibly new values given from this method's arguments
  NeumorphicThemeData copyWith({
    Color baseColor,
    Color accentColor,
    Color variantColor,
    Color disabledColor,
    Color defaultTextColor,
    double depth,
    double intensity,
    LightSource lightSource,
  }) {
    return new NeumorphicThemeData(
      baseColor: baseColor ?? this.baseColor,
      accentColor: accentColor ?? this.accentColor,
      variantColor: variantColor ?? this.variantColor,
      disabledColor: disabledColor ?? this.disabledColor,
      defaultTextColor: defaultTextColor ?? this.defaultTextColor,
      depth: depth ?? this._depth,
      intensity: intensity ?? this._intensity,
      lightSource: lightSource ?? this.lightSource,
    );
  }

  /// Create a copy of this theme
  /// With possibly new values given from the given second theme
  NeumorphicThemeData copyFrom({
    NeumorphicThemeData other,
  }) {
    return new NeumorphicThemeData(
      baseColor: other.baseColor ?? this.baseColor,
      accentColor: other.accentColor ?? this.accentColor,
      variantColor: other.variantColor ?? this.variantColor,
      disabledColor: other.disabledColor ?? this.disabledColor,
      defaultTextColor: other.defaultTextColor ?? this.defaultTextColor,
      depth: other.depth ?? this._depth,
      intensity: other.intensity ?? this._intensity,
      lightSource: other.lightSource ?? this.lightSource,
    );
  }
}
//endregion

//region style
const NeumorphicShape _defaultShape = NeumorphicShape.flat;
//const double _defaultBorderRadius = 5;

const neumorphicDefaultTheme = NeumorphicThemeData(
  baseColor: NeumorphicColors.background,
  accentColor: NeumorphicColors.accent,
  variantColor: NeumorphicColors.variant,
  disabledColor: NeumorphicColors.disabled,
  defaultTextColor: NeumorphicColors.defaultTextColor,
);
const neumorphicDefaultDarkTheme = NeumorphicThemeData(
  baseColor: NeumorphicColors.darkBackground,
  accentColor: NeumorphicColors.darkAccent,
  variantColor: NeumorphicColors.darkVariant,
  disabledColor: NeumorphicColors.darkDisabled,
  defaultTextColor: NeumorphicColors.darkDefaultTextColor,
);

class NeumorphicStyle {
  final Color color;
  final double _depth;
  final double _intensity;
  final double _surfaceIntensity;
  final LightSource lightSource;

  final bool oppositeShadowLightSource;

  final NeumorphicShape shape;
  final NeumorphicThemeData theme;

  const NeumorphicStyle({
    this.shape = _defaultShape,
    this.lightSource,
    this.color,
    double depth,
    double intensity,
    double surfaceIntensity = 0.25,
    this.oppositeShadowLightSource = false,
  })  : this._depth = depth,
        this.theme = null,
        this._intensity = intensity,
        this._surfaceIntensity = surfaceIntensity;

  // with theme constructor is only available privately, please use copyWithThemeIfNull
  const NeumorphicStyle._withTheme({
    this.theme,
    this.shape = _defaultShape,
    this.lightSource,
    this.color,
    this.oppositeShadowLightSource = false,
    double depth,
    double intensity,
    double surfaceIntensity = 0.25,
  })  : this._depth = depth,
        this._intensity = intensity,
        this._surfaceIntensity = surfaceIntensity;

  double get depth => _depth?.clamp(Neumorphic.MIN_DEPTH, Neumorphic.MAX_DEPTH);

  double get intensity =>
      _intensity?.clamp(Neumorphic.MIN_INTENSITY, Neumorphic.MAX_INTENSITY);

  double get surfaceIntensity => _surfaceIntensity?.clamp(
      Neumorphic.MIN_INTENSITY, Neumorphic.MAX_INTENSITY);

  NeumorphicStyle copyWithThemeIfNull(NeumorphicThemeData theme) {
    return NeumorphicStyle._withTheme(
        theme: theme,
        color: this.color ?? theme.baseColor,
        shape: this.shape,
        depth: this.depth ?? theme.depth,
        intensity: this.intensity ?? theme.intensity,
        surfaceIntensity: this.surfaceIntensity,
        oppositeShadowLightSource: this.oppositeShadowLightSource,
        lightSource: this.lightSource ?? theme.lightSource);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NeumorphicStyle &&
          runtimeType == other.runtimeType &&
          color == other.color &&
          _depth == other._depth &&
          _intensity == other._intensity &&
          _surfaceIntensity == other._surfaceIntensity &&
          lightSource == other.lightSource &&
          oppositeShadowLightSource == other.oppositeShadowLightSource &&
          shape == other.shape &&
          theme == other.theme;

  @override
  int get hashCode =>
      color.hashCode ^
      _depth.hashCode ^
      _intensity.hashCode ^
      _surfaceIntensity.hashCode ^
      lightSource.hashCode ^
      oppositeShadowLightSource.hashCode ^
      shape.hashCode ^
      theme.hashCode;

  NeumorphicStyle copyWith({
    Color color,
    double depth,
    double intensity,
    double surfaceIntensity,
    LightSource lightSource,
    double borderRadius,
    bool oppositeShadowLightSource,
    NeumorphicShape shape,
  }) {
    return NeumorphicStyle._withTheme(
      color: color ?? this.color,
      depth: depth ?? this.depth,
      theme: this.theme,
      intensity: intensity ?? this.intensity,
      surfaceIntensity: surfaceIntensity ?? this.surfaceIntensity,
      lightSource: lightSource ?? this.lightSource,
      oppositeShadowLightSource: oppositeShadowLightSource ?? this.oppositeShadowLightSource,
      shape: shape ?? this.shape,
    );
  }

  @override
  String toString() {
    return 'NeumorphicStyle{color: $color, _depth: $_depth, intensity: $intensity, lightSource: $lightSource, shape: $shape, theme: $theme, oppositeShadowLightSource: $oppositeShadowLightSource}';
  }
}
//endregion
