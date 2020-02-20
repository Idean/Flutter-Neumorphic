import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

BoxDecoration generateNeumorphicDecorator(
    {
    /*nullable*/ Color accent,
    /*nullable*/ NeumorphicStyle style,
    /*nullable*/ NeumorphicTheme theme,
    /*nullable*/ BoxShape shape
    }) {
  if (theme == null) {
    theme = neumorphicDefaultTheme;
  }

  if (style == null) {
    style = NeumorphicStyle();
  }

  style = style.copyWithThemeIfNull(theme);

  //will only use style from here, style is not null

  final borderRadius = style.borderRadius == 0 ? null : BorderRadius.circular(style.borderRadius);

  List<BoxShadow> boxShadows;
  Color innerColor;
  Gradient gradient;

  if (style.shape == NeumorphicShape.emboss) {
    innerColor = accent ?? style.baseColor;

    final whiteDistance = style.distance / 3;
    final darkDistance = style.distance / 6;

    boxShadows = [
      BoxShadow(
        color: NeumorphicColors.getAdjustColor(style.baseColor, style.distance),
        offset: embrossOffset(lightSource: style.lightSource, dark: false, distance: whiteDistance),
        blurRadius: whiteDistance,
      ),
      //BoxShadow(
      //  color: NeumorphicColors.getAdjustColor(style.baseColor, 0 - style.distance),
      //  offset: embrossOffset(lightSource: style.lightSource, dark: true, distance: darkDistance),
      //  blurRadius: darkDistance,
      //),
    ];

    gradient = NeumorphicColors.generateFlatGradients(
      color: NeumorphicColors.getAdjustColor(innerColor, 0 - style.distance / 2),
    );
    final convexConcaveOffset = sourceToOffset(style.lightSource, style.curveHeight);
    double darkFactor = style.curveHeight / 100 + 0.1;

    gradient = LinearGradient(
      begin: Alignment(
        -convexConcaveOffset.dx.clamp(-1, 1).toDouble(),
        -convexConcaveOffset.dy.clamp(-1, 1).toDouble(),
      ),
      end: Alignment(
        convexConcaveOffset.dx.clamp(-1, 1).toDouble(),
        convexConcaveOffset.dy.clamp(-1, 1).toDouble(),
      ),
      colors: [
       // Colors.grey,
        NeumorphicColors.generateGradientColors(
          colorBase: innerColor,
          intensity: -darkFactor,
        ),
        NeumorphicColors.generateGradientColors(
          colorBase: innerColor.withOpacity(0.5),
          updateAlpha: false,
          intensity: darkFactor,
        )
      ],
    );
  } else if (style.shape == NeumorphicShape.flat) {
    innerColor = accent ?? style.baseColor;
    final offset = sourceToOffset(style.lightSource, style.distance);

    if(offset == Offset.zero){
      boxShadows = [];
    } else {
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
    }

    gradient = NeumorphicColors.generateFlatGradients(
      color: NeumorphicColors.getAdjustColor(innerColor, 0 - style.distance / 2),
    );
  } else {
    final offset = sourceToOffset(style.lightSource, style.distance);

    print("offset : $offset");
    innerColor = accent ?? style.baseColor;

    if(offset == Offset.zero){
      boxShadows = [];
    } else {
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
    }

    double darkFactor = style.curveHeight / 60 + 0.1;
    double whiteFactor = style.curveHeight / 200 + 0.06;

    final convexConcaveOffset = sourceToOffset(style.lightSource, style.curveHeight);

    gradient = LinearGradient(
      begin: Alignment(
        -convexConcaveOffset.dx.clamp(-1, 1).toDouble(),
        -convexConcaveOffset.dy.clamp(-1, 1).toDouble(),
      ),
      end: Alignment(
        convexConcaveOffset.dx.clamp(-1, 1).toDouble(),
        convexConcaveOffset.dy.clamp(-1, 1).toDouble(),
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

  if(shape == null){
    shape = BoxShape.rectangle;
  }

  if(shape == BoxShape.circle){
    return BoxDecoration(
        boxShadow: boxShadows,
        gradient: gradient,
        shape: shape
    );
  } else {
    return BoxDecoration(
        borderRadius: borderRadius,
        boxShadow: boxShadows,
        gradient: gradient,
        shape: shape
    );
  }
}
