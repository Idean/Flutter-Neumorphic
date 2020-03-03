import 'dart:ui';

import 'colors.dart';
import 'light_source.dart';
import 'shape.dart';
import 'widget/container.dart';

export 'colors.dart';
export 'light_source.dart';
export 'shape.dart';
export 'widget/container.dart';

//region theme
const double _defaultDepth = 4;
const double _defaultIntensity = 0.5;
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

  double get depth => _depth?.clamp(Neumorphic.MIN_DEPTH, Neumorphic.MAX_DEPTH);

  double get intensity =>
      _intensity?.clamp(Neumorphic.MIN_INTENSITY, Neumorphic.MAX_INTENSITY);

  const NeumorphicThemeData({
    this.baseColor = _defaultBaseColor,
    double depth = _defaultDepth,
    double intensity = _defaultIntensity,
    this.accentColor = _defaultAccent,
    this.variantColor = _defaultVariant,
    this.lightSource = _defaultLightSource,
  })  : this._depth = depth,
        this._intensity = intensity;

  @override
  String toString() {
    return 'NeumorphicTheme{baseColor: $baseColor, accentColor: $accentColor, variantColor: $variantColor, _depth: $_depth, intensity: $intensity, lightSource: $lightSource}';
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
          lightSource == other.lightSource;

  @override
  int get hashCode =>
      baseColor.hashCode ^
      accentColor.hashCode ^
      variantColor.hashCode ^
      _depth.hashCode ^
      intensity.hashCode ^
      lightSource.hashCode;

  NeumorphicThemeData copyWith({
    Color baseColor,
    Color accentColor,
    Color variantColor,
    double depth,
    double intensity,
    LightSource lightSource,
  }) {
    return new NeumorphicThemeData(
      baseColor: baseColor ?? this.baseColor,
      accentColor: accentColor ?? this.accentColor,
      variantColor: variantColor ?? this.variantColor,
      depth: depth ?? this._depth,
      intensity: intensity ?? this._intensity,
      lightSource: lightSource ?? this.lightSource,
    );
  }

  NeumorphicThemeData copyFrom({
    NeumorphicThemeData other,
  }) {
    return new NeumorphicThemeData(
      baseColor: other.baseColor ?? this.baseColor,
      accentColor: other.accentColor ?? this.accentColor,
      variantColor: other.variantColor ?? this.variantColor,
      depth: other.depth ?? this._depth,
      intensity: other.intensity ?? this._intensity,
      lightSource: other.lightSource ?? this.lightSource,
    );
  }
}
//endregion

//region style
const NeumorphicShape _defaultShape = NeumorphicShape.concave;
//const double _defaultBorderRadius = 5;

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
  final Color color;
  final double _depth;
  final double _intensity;
  final LightSource lightSource;

  final NeumorphicShape shape;

  const NeumorphicStyle({
    this.shape = _defaultShape,
    this.lightSource,
    this.color,
    double depth,
    double intensity,
  })  : this._depth = depth,
        this._intensity = intensity;

  double get depth => _depth?.clamp(Neumorphic.MIN_DEPTH, Neumorphic.MAX_DEPTH);

  double get intensity =>
      _intensity?.clamp(Neumorphic.MIN_INTENSITY, Neumorphic.MAX_INTENSITY);

  NeumorphicStyle copyWithThemeIfNull(NeumorphicThemeData theme) {
    return NeumorphicStyle(
        color: this.color ?? theme.baseColor,
        shape: this.shape,
        depth: this.depth ?? theme.depth,
        intensity: this.intensity ?? theme.intensity,
        lightSource: this.lightSource ?? theme.lightSource);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NeumorphicStyle &&
          runtimeType == other.runtimeType &&
          color == other.color &&
          depth == other.depth &&
          intensity == other.intensity &&
          lightSource == other.lightSource &&
          shape == other.shape;

  @override
  int get hashCode =>
      color.hashCode ^
      depth.hashCode ^
      intensity.hashCode ^
      lightSource.hashCode ^
      shape.hashCode;

  NeumorphicStyle copyWith({
    Color color,
    double depth,
    double intensity,
    LightSource lightSource,
    double borderRadius,
    NeumorphicShape shape,
  }) {
    return new NeumorphicStyle(
      color: color ?? this.color,
      depth: depth ?? this.depth,
      intensity: intensity ?? this.intensity,
      lightSource: lightSource ?? this.lightSource,
      shape: shape ?? this.shape,
    );
  }

  @override
  String toString() {
    return 'NeumorphicStyle{color: $color, _depth: $_depth, intensity: $intensity, lightSource: $lightSource, shape: $shape}';
  }
}
//endregion
