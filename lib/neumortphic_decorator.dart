import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

Offset limitOffset(Offset offset, double minXY, double maxXY) {
  final dx = offset.dx.clamp(minXY, maxXY);
  final dy = offset.dy.clamp(minXY, maxXY);
  return Offset(dx, dy);
}

List<BoxShadow> generateMultipleShadow({@required Color color, bool dark, @required Offset offset, @required double intensity, @required double scaleFactor, @required double blurRadius}) {
  if(dark){
     return [BoxShadow(
       color: NeumorphicColors.generateGradientColors(colorBase: color, intensity: intensity),
       offset: offset.scale(scaleFactor, scaleFactor),
       blurRadius: blurRadius,
     )];
  } else {
    return [
      BoxShadow(
        color: NeumorphicColors.generateGradientColors(colorBase: color, intensity: intensity),
        offset: offset.scale(scaleFactor, scaleFactor),
        blurRadius: blurRadius,
      ),
      BoxShadow(
        color: NeumorphicColors.generateGradientColors(colorBase: color, intensity: intensity),
        offset: offset.scale(scaleFactor, 0.2),
        blurRadius: blurRadius,
      ),
      BoxShadow(
        color: NeumorphicColors.generateGradientColors(colorBase: color, intensity: intensity),
        offset: offset.scale(0.25, scaleFactor),
        blurRadius: blurRadius,
      )
    ];
  }
}

List<BoxShadow> generateUsualBoxShadow({@required Offset offset, @required Color color, @required double intensity, @required double distance, @required double limit}) {
  if (offset == Offset.zero) {
    return [];
  }

  //white
  final List<BoxShadow> lightShadows = [];

  //print("offset shadow : $offset");

  //big and clear
  lightShadows.addAll(generateMultipleShadow(
    dark: false,
    color: color,
    offset:  limitOffset(offset, -30, 30),
    intensity: 0.75 * (distance / 30) * intensity / 10,
    scaleFactor: 1.0,
    blurRadius: distance / 2,
  ));

  //medium distance
  lightShadows.addAll(generateMultipleShadow(
    dark: false,
    color: color,
    offset:  limitOffset(offset, -20, 20),
    intensity: 0.75 * (distance / 40) * intensity / 5,
    scaleFactor: 0.5,
    blurRadius: distance / 2,
  ));

  //////small & lighten
  lightShadows.addAll(generateMultipleShadow(
    dark: false,
    color: color,
    offset: limitOffset(offset, -20, 20),
    intensity: 0.75 * (distance / 40) * intensity / 3,
    scaleFactor: 0.25,
    blurRadius: distance /8,
  ));

  final List<BoxShadow> darkShadows = [];

  //big and clear
  darkShadows.addAll(generateMultipleShadow(
    dark: true,
    color: color,
    offset:  limitOffset(offset, -30, 30),
    intensity: -1.5 * (distance / 12) * intensity / 5,
    scaleFactor: -1.0,
    blurRadius: distance,
  ));

  //medium distance
  darkShadows.addAll(generateMultipleShadow(
    dark: true,
    color: color,
    offset:  limitOffset(offset, -20, 20),
    intensity: -1.5 * (distance / 12) * intensity / 4,
    scaleFactor: -0.5,
    blurRadius: distance / 2,
  ));

  //small & darken
  darkShadows.addAll(generateMultipleShadow(
    dark: true,
    color: color,
    offset: limitOffset(offset, -10, 10),
    intensity: -1.5 * (distance / 12) * intensity / 3,
    scaleFactor: -0.25,
    blurRadius: distance /8,
  ));

  final List<BoxShadow> shadows = [];
  shadows.addAll(darkShadows);
  shadows.addAll(lightShadows);

  return shadows;
}

BoxDecoration generateNeumorphicDecoratorEmboss({
  /*nullable*/ Color accent,
  NeumorphicStyle style,
  BoxShape shape,
}) {
  final Color innerColor = accent ?? style.baseColor;
  var offset = sourceToOffset(style.lightSource, style.distance);

  //limit offset
  offset = limitOffset(offset, -7, 7);

  // shadows
  List<BoxShadow> boxShadows = [];
  if (offset != Offset.zero) {
    boxShadows = [
      BoxShadow(
        color: NeumorphicColors.generateGradientColors(colorBase: style.baseColor, intensity: -1 * ((style.distance / 10) * style.intensity * 0.5)),
        offset: offset.scale(-1, -1),
        spreadRadius: 2,
        blurRadius: style.distance,
      ),
      BoxShadow(
        color: NeumorphicColors.generateGradientColors(colorBase: style.baseColor, intensity: style.intensity),
        offset: offset,
        blurRadius: style.distance,
      ),
    ];
  }

  //body
  final Gradient gradient = NeumorphicColors.generateEmbossGradients(
    color: NeumorphicColors.generateGradientColors(colorBase: innerColor, intensity: -1 * (1 + (style.distance / 5)) * style.intensity),
  );

  if (shape == BoxShape.circle) {
    return BoxDecoration(
      boxShadow: boxShadows,
      gradient: gradient,
      shape: shape,
    );
  } else {
    return BoxDecoration(
      borderRadius: style.borderRadius == 0 ? null : BorderRadius.circular(style.borderRadius),
      boxShadow: boxShadows,
      gradient: gradient,
      shape: shape,
    );
  }
}

BoxDecoration generateNeumorphicDecoratorFlat({
/*nullable*/ @required Color accent,
  @required NeumorphicStyle style,
  @required BoxShape shape,
}) {
  final Color innerColor = accent ?? style.baseColor;

  final List<BoxShadow> boxShadows =
      generateUsualBoxShadow(offset: sourceToOffset(style.lightSource, style.distance), distance: style.distance, intensity: style.intensity, color: style.baseColor, limit: 8.0);

  final Gradient gradient = NeumorphicColors.generateFlatGradients(
    color: NeumorphicColors.getAdjustColor(innerColor, 0 - style.distance / 2),
  );

  if (shape == BoxShape.circle) {
    return BoxDecoration(
      boxShadow: boxShadows,
      gradient: gradient,
      shape: shape,
    );
  } else {
    return BoxDecoration(
      borderRadius: style.borderRadius == 0 ? null : BorderRadius.circular(style.borderRadius),
      boxShadow: boxShadows,
      gradient: gradient,
      shape: shape,
    );
  }
}

BoxDecoration generateNeumorphicDecoratorConcaveConvex({
/*nullable*/ Color accent,
  NeumorphicStyle style,
  BoxShape shape,
}) {
  final Color innerColor = accent ?? style.baseColor;

  final List<BoxShadow> boxShadows =
      generateUsualBoxShadow(offset: sourceToOffset(style.lightSource, style.distance), distance: style.distance, intensity: style.intensity, color: style.baseColor, limit: 8.0);

  final curveFactor = style.curveFactor.clamp(0, 1);

  final whiteFactor = 0.0 + ((curveFactor / 2.5) * style.distance / 40);
  final darkFactor = 0.0 - ((curveFactor / 2.5) * (style.distance / 28));

  final convexConcaveOffset = sourceToOffset(style.lightSource, style.curveFactor);

  final Gradient gradient = LinearGradient(
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
          intensity: style.shape == NeumorphicShape.convex ? whiteFactor : darkFactor,
        ),
       NeumorphicColors.generateGradientColors(
         colorBase: innerColor,
         intensity: style.shape == NeumorphicShape.convex ? whiteFactor : darkFactor,
       ),
       NeumorphicColors.generateGradientColors(
         colorBase: innerColor,
         intensity: style.shape == NeumorphicShape.convex ? darkFactor : whiteFactor,
       ),
        NeumorphicColors.generateGradientColors(
          colorBase: innerColor,
          intensity: style.shape == NeumorphicShape.convex ? darkFactor : whiteFactor,
        )
      ],
      stops: [
        0,
        0.30,
        0.95,
        1
      ]);

  if (shape == BoxShape.circle) {
    return BoxDecoration(
      boxShadow: boxShadows,
      gradient: gradient,
      shape: shape,
    );
  } else {
    return BoxDecoration(
      borderRadius: style.borderRadius == 0 ? null : BorderRadius.circular(style.borderRadius),
      boxShadow: boxShadows,
      gradient: gradient,
      shape: shape,
    );
  }
}

BoxDecoration generateNeumorphicDecorator(
    {
    /*nullable*/ Color accent,
    NeumorphicStyle style,
    BoxShape shape}) {
  if (style.shape == NeumorphicShape.emboss) {
    return generateNeumorphicDecoratorEmboss(accent: accent, style: style, shape: shape);
  } else if (style.shape == NeumorphicShape.flat) {
    return generateNeumorphicDecoratorFlat(accent: accent, style: style, shape: shape);
  } else {
    return generateNeumorphicDecoratorConcaveConvex(accent: accent, style: style, shape: shape);
  }
}

Widget generateNeumprphicChild({Color accent, NeumorphicStyle style, BoxShape shape, Widget child}) {
  return child;
}
