import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' show TextTheme;
import 'package:flutter_neumorphic/src/widget/container.dart';

import '../colors.dart';
import '../light_source.dart';
import '../shape.dart';

export '../colors.dart';
export '../light_source.dart';
export '../shape.dart';

//region theme
const double _defaultDepth = 4;
const double _defaultIntensity = 0.7;
const Color _defaultAccent = NeumorphicColors.accent;
const Color _defaultVariant = NeumorphicColors.variant;
const Color _defaultDisabledColor = NeumorphicColors.disabled;
const Color _defaultTextColor = NeumorphicColors.defaultTextColor;
const LightSource _defaultLightSource = LightSource.topLeft;
const Color _defaultBaseColor = NeumorphicColors.background;
const double _defaultBorderSize = 0.3;

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

  final Color shadowLightColor;
  final Color shadowDarkColor;
  final Color shadowLightColorEmboss;
  final Color shadowDarkColorEmboss;

  final Color borderColor;
  final double borderWidth;

  final Color defaultTextColor; //TODO maybe use TextStyle here
  final double _depth;
  final double _intensity;
  final LightSource lightSource;
  final bool disableDepth;
  /// Default text theme to use and apply across the app
  final TextTheme textTheme;
  /// Default style to use and apply across the app
  final NeumorphicStyle defaultStyle;

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
    this.defaultStyle = const NeumorphicStyle(),
    this.variantColor = _defaultVariant,
    this.disabledColor = _defaultDisabledColor,
    this.shadowLightColor = NeumorphicColors.decorationMaxWhiteColor,
    this.shadowDarkColor = NeumorphicColors.decorationMaxDarkColor,
    this.shadowLightColorEmboss = NeumorphicColors.embossMaxWhiteColor,
    this.shadowDarkColorEmboss = NeumorphicColors.embossMaxDarkColor,
    this.defaultTextColor = _defaultTextColor,
    this.lightSource = _defaultLightSource,
    this.textTheme = const TextTheme(),
    this.borderColor = NeumorphicColors.defaultBorder,
    this.borderWidth = _defaultBorderSize,
    this.disableDepth = false,
  })  : this._depth = depth,
        this._intensity = intensity;

  const NeumorphicThemeData.dark({
    this.baseColor = NeumorphicColors.darkBackground,
    double depth = _defaultDepth,
    double intensity = _defaultIntensity,
    this.defaultStyle = const NeumorphicStyle(),
    this.accentColor = _defaultAccent,
    this.textTheme = const TextTheme(),
    this.variantColor = NeumorphicColors.darkVariant,
    this.disabledColor = NeumorphicColors.darkDisabled,
    this.shadowLightColor = NeumorphicColors.decorationMaxWhiteColor,
    this.shadowDarkColor = NeumorphicColors.decorationMaxDarkColor,
    this.shadowLightColorEmboss = NeumorphicColors.embossMaxWhiteColor,
    this.shadowDarkColorEmboss = NeumorphicColors.embossMaxDarkColor,
    this.defaultTextColor = NeumorphicColors.darkDefaultTextColor,
    this.lightSource = _defaultLightSource,
    this.borderColor = NeumorphicColors.darkDefaultBorder,
    this.borderWidth = _defaultBorderSize,
    this.disableDepth = false,
  })  : this._depth = depth,
        this._intensity = intensity;

  @override
  String toString() {
    return 'NeumorphicTheme{baseColor: $baseColor, disableDepth: $disableDepth, accentColor: $accentColor, variantColor: $variantColor, disabledColor: $disabledColor, _depth: $_depth, intensity: $intensity, lightSource: $lightSource}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NeumorphicThemeData &&
          runtimeType == other.runtimeType &&
          baseColor == other.baseColor &&
          defaultStyle == other.defaultStyle &&
          textTheme == other.textTheme &&
          accentColor == other.accentColor &&
          shadowDarkColor == other.shadowDarkColor &&
          shadowLightColor == other.shadowLightColor &&
          shadowDarkColorEmboss == other.shadowDarkColorEmboss &&
          shadowLightColorEmboss == other.shadowLightColorEmboss &&
          disabledColor == other.disabledColor &&
          variantColor == other.variantColor &&
          disableDepth == other.disableDepth &&
          defaultTextColor == other.defaultTextColor &&
          borderWidth == other.borderWidth &&
          borderColor == other.borderColor &&
          _depth == other._depth &&
          _intensity == other._intensity &&
          lightSource == other.lightSource;

  @override
  int get hashCode =>
      baseColor.hashCode ^
      defaultStyle.hashCode ^
      textTheme.hashCode ^
      accentColor.hashCode ^
      variantColor.hashCode ^
      disabledColor.hashCode ^
      shadowDarkColor.hashCode ^
      shadowLightColor.hashCode ^
      shadowDarkColorEmboss.hashCode ^
      shadowLightColorEmboss.hashCode ^
      defaultTextColor.hashCode ^
      disableDepth.hashCode ^
      borderWidth.hashCode ^
      borderColor.hashCode ^
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
    Color shadowLightColor,
    Color shadowDarkColor,
    Color shadowLightColorEmboss,
    Color shadowDarkColorEmboss,
    Color defaultTextColor,
    TextTheme textTheme,
    NeumorphicStyle defaultStyle,
    bool disableDepth,
    double depth,
    double intensity,
    Color borderColor,
    double borderSize,
    LightSource lightSource,
  }) {
    return new NeumorphicThemeData(
      baseColor: baseColor ?? this.baseColor,
      defaultStyle: defaultStyle ?? this.defaultStyle,
      textTheme: textTheme ?? this.textTheme,
      accentColor: accentColor ?? this.accentColor,
      variantColor: variantColor ?? this.variantColor,
      disabledColor: disabledColor ?? this.disabledColor,
      defaultTextColor: defaultTextColor ?? this.defaultTextColor,
      disableDepth: disableDepth ?? this.disableDepth,
      shadowDarkColor: shadowDarkColor ?? this.shadowDarkColor,
      shadowLightColor: shadowLightColor ?? this.shadowLightColor,
      shadowDarkColorEmboss:
          shadowDarkColorEmboss ?? this.shadowDarkColorEmboss,
      shadowLightColorEmboss:
          shadowLightColorEmboss ?? this.shadowLightColorEmboss,
      depth: depth ?? this._depth,
      borderWidth: borderSize ?? this.borderWidth,
      borderColor: borderColor ?? this.borderColor,
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
      disableDepth: other.disableDepth ?? this.disableDepth,
      disabledColor: other.disabledColor ?? this.disabledColor,
      defaultTextColor: other.defaultTextColor ?? this.defaultTextColor,
      shadowDarkColor: other.shadowDarkColor ?? this.shadowDarkColor,
      shadowLightColor: other.shadowLightColor ?? this.shadowLightColor,
      shadowDarkColorEmboss:
          other.shadowDarkColorEmboss ?? this.shadowDarkColorEmboss,
      shadowLightColorEmboss:
          other.shadowLightColorEmboss ?? this.shadowLightColorEmboss,
      textTheme: other.textTheme ?? this.textTheme,
      defaultStyle: other.defaultStyle ?? this.defaultStyle,
      depth: other.depth ?? this._depth,
      borderColor: other.borderColor ?? this.borderColor,
      borderWidth: other.borderWidth ?? this.borderWidth,
      intensity: other.intensity ?? this._intensity,
      lightSource: other.lightSource ?? this.lightSource,
    );
  }
}
//endregion

//region style
const NeumorphicShape _defaultShape = NeumorphicShape.flat;
//const double _defaultBorderRadius = 5;

const neumorphicDefaultTheme = NeumorphicThemeData();
const neumorphicDefaultDarkTheme = NeumorphicThemeData.dark();

class NeumorphicBorder {
  final bool isEnabled;
  final Color color;
  final double width;

  const NeumorphicBorder({
    this.isEnabled = true,
    this.color,
    this.width,
  });

  const NeumorphicBorder.none()
      : this.isEnabled = true,
        this.color = const Color(0x00000000),
        this.width = 0;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NeumorphicBorder &&
          runtimeType == other.runtimeType &&
          isEnabled == other.isEnabled &&
          color == other.color &&
          width == other.width;

  @override
  int get hashCode => isEnabled.hashCode ^ color.hashCode ^ width.hashCode;

  @override
  String toString() {
    return 'NeumorphicBorder{isEnabled: $isEnabled, color: $color, width: $width}';
  }

  static NeumorphicBorder lerp(
      NeumorphicBorder a, NeumorphicBorder b, double t) {
    assert(t != null);

    if (a == null && b == null) return null;

    if (t == 0.0) return a;
    if (t == 1.0) return b;

    return NeumorphicBorder(
        color: Color.lerp(a.color, b.color, t),
        isEnabled: a.isEnabled,
        width: lerpDouble(a.width, b.width, t));
  }

  NeumorphicBorder copyWithThemeIfNull({Color color, double width}) {
    return NeumorphicBorder(
      isEnabled: this.isEnabled,
      color: this.color ?? color,
      width: this.width ?? width,
    );
  }
}

class NeumorphicStyle {
  final Color color;
  final double _depth;
  final double _intensity;
  final double _surfaceIntensity;
  final LightSource lightSource;
  final bool disableDepth;

  final NeumorphicBorder border;

  final bool oppositeShadowLightSource;

  final NeumorphicShape shape;
  final NeumorphicThemeData theme;

  //override the "white" color
  final Color shadowLightColor;

  //override the "dark" color
  final Color shadowDarkColor;

  //override the "white" color
  final Color shadowLightColorEmboss;

  //override the "dark" color
  final Color shadowDarkColorEmboss;

  const NeumorphicStyle({
    this.shape = _defaultShape,
    this.lightSource,
    this.border = const NeumorphicBorder.none(),
    this.color,
    this.shadowLightColor,
    this.shadowDarkColor,
    this.shadowLightColorEmboss,
    this.shadowDarkColorEmboss,
    double depth,
    double intensity,
    double surfaceIntensity = 0.25,
    this.disableDepth,
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
    this.border = const NeumorphicBorder.none(),
    this.shadowLightColor,
    this.shadowDarkColor,
    this.shadowLightColorEmboss,
    this.shadowDarkColorEmboss,
    this.oppositeShadowLightSource = false,
    this.disableDepth,
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
        border: this.border.copyWithThemeIfNull(
            color: theme.borderColor, width: theme.borderWidth),
        shadowDarkColor: this.shadowDarkColor ?? theme.shadowDarkColor,
        shadowLightColor: this.shadowLightColor ?? theme.shadowLightColor,
        shadowDarkColorEmboss:
            this.shadowDarkColorEmboss ?? theme.shadowDarkColorEmboss,
        shadowLightColorEmboss:
            this.shadowLightColorEmboss ?? theme.shadowLightColorEmboss,
        depth: this.depth ?? theme.depth,
        intensity: this.intensity ?? theme.intensity,
        disableDepth: this.disableDepth ?? theme.disableDepth,
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
          border == other.border &&
          shadowDarkColor == other.shadowDarkColor &&
          shadowLightColor == other.shadowLightColor &&
          shadowDarkColorEmboss == other.shadowDarkColorEmboss &&
          shadowLightColorEmboss == other.shadowLightColorEmboss &&
          disableDepth == other.disableDepth &&
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
      shadowDarkColor.hashCode ^
      shadowLightColor.hashCode ^
      shadowDarkColorEmboss.hashCode ^
      shadowLightColorEmboss.hashCode ^
      _depth.hashCode ^
      border.hashCode ^
      _intensity.hashCode ^
      disableDepth.hashCode ^
      _surfaceIntensity.hashCode ^
      lightSource.hashCode ^
      oppositeShadowLightSource.hashCode ^
      shape.hashCode ^
      theme.hashCode;

  NeumorphicStyle copyWith({
    Color color,
    NeumorphicBorder border,
    Color shadowLightColor,
    Color shadowDarkColor,
    Color shadowLightColorEmboss,
    Color shadowDarkColorEmboss,
    double depth,
    double intensity,
    double surfaceIntensity,
    LightSource lightSource,
    bool disableDepth,
    double borderRadius,
    bool oppositeShadowLightSource,
    NeumorphicShape shape,
  }) {
    return NeumorphicStyle._withTheme(
      color: color ?? this.color,
      border: border ?? this.border,
      shadowDarkColor: shadowDarkColor ?? this.shadowDarkColor,
      shadowLightColor: shadowLightColor ?? this.shadowLightColor,
      shadowDarkColorEmboss:
          shadowDarkColorEmboss ?? this.shadowDarkColorEmboss,
      shadowLightColorEmboss:
          shadowLightColorEmboss ?? this.shadowLightColorEmboss,
      depth: depth ?? this.depth,
      theme: this.theme,
      intensity: intensity ?? this.intensity,
      surfaceIntensity: surfaceIntensity ?? this.surfaceIntensity,
      disableDepth: disableDepth ?? this.disableDepth,
      lightSource: lightSource ?? this.lightSource,
      oppositeShadowLightSource:
          oppositeShadowLightSource ?? this.oppositeShadowLightSource,
      shape: shape ?? this.shape,
    );
  }

  @override
  String toString() {
    return 'NeumorphicStyle{color: $color, _depth: $_depth, intensity: $intensity, disableDepth: $disableDepth, lightSource: $lightSource, shape: $shape, theme: $theme, oppositeShadowLightSource: $oppositeShadowLightSource}';
  }

  NeumorphicStyle applyDisableDepth() {
    if (disableDepth == true) {
      return this.copyWith(depth: 0);
    } else {
      return this;
    }
  }
}
//endregion
