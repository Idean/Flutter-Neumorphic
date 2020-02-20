import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

BoxDecoration generateNeumorphicDecorator(
    {
    /*nullable*/ Color accent,
    /*nullable*/ NeumorphicStyle style,
    /*nullable*/ NeumorphicTheme theme}) {
  if (theme == null) {
    theme = neumorphicDefaultTheme;
  }

  if (style == null) {
    style = NeumorphicStyle();
  }

  style = style.copyWithThemeIfNull(theme);

  //will only use style from here, style is not null

  List<BoxShadow> boxShadows;
  Color innerColor;
  Gradient gradient;

  if (style.shape == NeumorphicShape.emboss) {
    innerColor = accent ?? style.baseColor;

    final whiteDistance = style.distance / 4;
    final darkDistance = style.distance / 6;

    boxShadows = [
      BoxShadow(
        color: NeumorphicColors.getAdjustColor(style.baseColor, style.distance),
        offset: embrossOffset(lightSource: style.lightSource, dark: false, distance: whiteDistance),
        blurRadius: whiteDistance,
      ),
      BoxShadow(
        color: NeumorphicColors.getAdjustColor(style.baseColor, 0 - style.distance),
        offset: embrossOffset(lightSource: style.lightSource, dark: true, distance: darkDistance),
        blurRadius: darkDistance,
      ),
    ];

    gradient = NeumorphicColors.generateFlatGradients(
      color: NeumorphicColors.getAdjustColor(innerColor, 0 - style.distance / 2),
    );
  } else if (style.shape == NeumorphicShape.flat) {
    innerColor = accent ?? style.baseColor;
    final offset = sourceToOffset(style.lightSource, style.distance);

    boxShadows = [
      BoxShadow(
        color: NeumorphicColors.generateGradientColors(colorBase: style.baseColor, intensity: -1 * style.intensity),
        offset: offset,
        blurRadius: theme.blur,
      ),
      BoxShadow(
        color: NeumorphicColors.generateGradientColors(colorBase: style.baseColor, intensity: style.intensity),
        offset: offset.scale(-1, -1),
        blurRadius: theme.blur,
      ),
    ];

    gradient = NeumorphicColors.generateFlatGradients(
      color: NeumorphicColors.getAdjustColor(innerColor, 0 - style.distance / 2),
    );
  } else {
    final offset = sourceToOffset(style.lightSource, style.distance);

    innerColor = accent ?? style.baseColor;

    boxShadows = [
      BoxShadow(
        color: NeumorphicColors.generateGradientColors(colorBase: style.baseColor, intensity: -1 * style.intensity),
        offset: offset,
        blurRadius: theme.blur,
      ),
      BoxShadow(
        color: NeumorphicColors.generateGradientColors(colorBase: style.baseColor, intensity: style.intensity),
        offset: offset.scale(-1, -1),
        blurRadius: theme.blur,
      ),
    ];

    double darkFactor = 0.2;
    double whiteFactor = 0.06;

    gradient = LinearGradient(
      begin: Alignment(
        -offset.dx.clamp(-1, 1).toDouble(),
        -offset.dy.clamp(-1, 1).toDouble(),
      ),
      end: Alignment(
        offset.dx.clamp(-1, 1).toDouble(),
        offset.dy.clamp(-1, 1).toDouble(),
      ),
      colors: [
        NeumorphicColors.generateGradientColors(
                colorBase: innerColor,
                intensity: style.shape == NeumorphicShape.convex ? whiteFactor : -darkFactor,
              ),
        NeumorphicColors.generateGradientColors(
                colorBase: innerColor,
                intensity: style.shape == NeumorphicShape.convex ? -darkFactor : whiteFactor,
              )
      ],
    );
  }

  final borderRadius = style.borderRadius == 0 ? null : BorderRadius.circular(style.borderRadius);

  return BoxDecoration(
    borderRadius: borderRadius,
    //color: innerColor,
    boxShadow: boxShadows,
    gradient: gradient,
  );
}
