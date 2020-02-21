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
    final convexConcaveOffset = sourceToOffset(style.lightSource, style.distance);
    double darkFactor = style.distance / 80;

    gradient = LinearGradient(
      begin: Alignment(
        convexConcaveOffset.dx.clamp(-1, 1).toDouble(),
        convexConcaveOffset.dy.clamp(-1, 1).toDouble(),
      ),
      end: Alignment(
        -convexConcaveOffset.dx.clamp(-1, 1).toDouble(),
        -convexConcaveOffset.dy.clamp(-1, 1).toDouble(),
      ),

      colors: [
       // Colors.grey,
        NeumorphicColors.generateGradientColors(
          colorBase: innerColor,
          updateAlpha: false,
          intensity: 0,
        ).withOpacity(0),
        NeumorphicColors.generateGradientColors(
          colorBase: innerColor,
          intensity: -style.distance / 50,
        ).withOpacity(0.3),
        NeumorphicColors.generateGradientColors(
          colorBase: innerColor,
          intensity: -style.distance / 60,
        ).withOpacity(0.8),
        NeumorphicColors.generateGradientColors(
          colorBase: innerColor,
          intensity: -style.distance / 80,
        ).withOpacity(1),
      ],
        stops: [
          0,
          0.6,
          0.9,
          1
        ]
    );
  } else if (style.shape == NeumorphicShape.flat) {
    innerColor = accent ?? style.baseColor;
    final offset = sourceToOffset(style.lightSource, style.distance);

    if(offset == Offset.zero){
      boxShadows = [];
    } else {
      boxShadows = [
        BoxShadow(
          color: NeumorphicColors.generateGradientColors(colorBase: style.baseColor, intensity: -1 * style.intensity / 2),
          offset: offset.scale(-1, -1),
          blurRadius: style.distance / 4, //TODO
        ),
        BoxShadow(
          color: NeumorphicColors.generateGradientColors(colorBase: style.baseColor, intensity: style.intensity / 2.5),
          offset: offset,
          blurRadius: style.distance /4, //TODO
        ),
      ];
    }

    gradient = NeumorphicColors.generateFlatGradients(
      color: NeumorphicColors.getAdjustColor(innerColor, 0 - style.distance / 2),
    );
  } else {
    var offset = sourceToOffset(style.lightSource, style.distance);

    if(offset.dx < -6 || offset.dy < -6){
      offset = Offset(-6, -6);
    }
    if(offset.dx > 6 || offset.dy > 6){
      offset = Offset(6, 6);
    }

    print("offset : $offset");
    innerColor = accent ?? style.baseColor;

    if(offset == Offset.zero){
      boxShadows = [];
    } else {
      boxShadows = [
        BoxShadow(
          color: NeumorphicColors.generateGradientColors(colorBase: style.baseColor, intensity: -1 *  (style.intensity * style.distance) / 5),
          offset: offset.scale(-1, -1),
          blurRadius: style.distance / 2, //TODO
        ),
        BoxShadow(
          color: NeumorphicColors.generateGradientColors(colorBase: style.baseColor, intensity: 1),
          offset: offset,
          spreadRadius: style.distance / 10,
          blurRadius: (style.distance / 3.5), //TODO
        ),
      ];
    }

    double darkFactor = (style.distance / 50  + style.curveFactor.clamp(0, 1) / 15) / 2;
    double whiteFactor = (style.distance/ 60 + style.curveFactor.clamp(0, 1) / 15) / 2;

    final convexConcaveOffset = sourceToOffset(style.lightSource, style.curveFactor);

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
          intensity: style.shape == NeumorphicShape.convex ? whiteFactor : -darkFactor,
        ),
        NeumorphicColors.generateGradientColors(
                colorBase: innerColor,
                intensity: style.shape == NeumorphicShape.convex ? -darkFactor : whiteFactor,
              ),
        NeumorphicColors.generateGradientColors(
          colorBase: innerColor,
          intensity: style.shape == NeumorphicShape.convex ? -darkFactor : whiteFactor,
        )
      ],
      stops: [
        0,
        0.1,
        0.8,
        1
      ]
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
