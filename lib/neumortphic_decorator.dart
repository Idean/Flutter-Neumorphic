import 'package:flutter/painting.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

BoxDecoration generateNeumorphicDecorator({Color base, /*nullable*/ Color accent, /*nullable*/ NeumorphicStyle style, /*nullable*/ NeumorphicTheme theme}) {
  if (theme == null) {
    theme = neumorphicDefaultTheme;
  }

  if(style == null){
    style = NeumorphicStyle();
  }

  style = style.copyWithThemeIfNull(theme);

  //will only use style from here, style is not null

  final offset = sourceToOffset(style.lightSource, style.distance);

  final boxShadows = [
    BoxShadow(
      color: NeumorphicColors.generateShadowColors(base: base, intensity: -1 * style.intensity),
      offset: offset,
      blurRadius: theme.blur,
    ),
    BoxShadow(
      color: NeumorphicColors.generateShadowColors(base: base, intensity: style.intensity),
      offset: offset.scale(-1, -1),
      blurRadius: theme.blur,
    ),
  ];

  final borderRadius = style.borderRadius == 0
      ? null
      : BorderRadius.circular(style.borderRadius);

  if(accent != null){
    return BoxDecoration(
      borderRadius: borderRadius,
      color: accent,
      boxShadow: boxShadows,
    );
  } else {
    return BoxDecoration(
      borderRadius: borderRadius,
      color: base,
      boxShadow: boxShadows,
      gradient: LinearGradient(
        begin: Alignment(
          -offset.dx.clamp(-1, 1).toDouble(),
          -offset.dy.clamp(-1, 1).toDouble(),
        ),
        end: Alignment(
          offset.dx.clamp(-1, 1).toDouble(),
          offset.dy.clamp(-1, 1).toDouble(),
        ),
        colors: [
          style.gradientBackground ? NeumorphicColors.generateShadowColors(base: base, intensity: style.shape == NeumorphicShape.concave ? 0.07 : -0.1) : base,
          style.gradientBackground ? NeumorphicColors.generateShadowColors(base: base, intensity: style.shape == NeumorphicShape.concave ? -0.1 : 0.07) : base,
        ],
      ),
    );
  }
}