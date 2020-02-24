import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'NeumorphicBoxShape.dart';

Offset limitOffset(Offset offset, double minXY, double maxXY) {
  final dx = offset.dx.clamp(minXY, maxXY);
  final dy = offset.dy.clamp(minXY, maxXY);
  return Offset(dx, dy);
}

List<BoxShadow> generateMultipleShadow({
  @required Color color,
  bool dark,
  @required Offset offset,
  @required double intensity,
  @required double scaleFactor,
  @required double blurRadius,
}) {
  if (dark) {
    return [
      BoxShadow(
        color: NeumorphicColors.generateGradientColors(
          colorBase: color,
          intensity: intensity,
        ),
        offset: offset.scale(scaleFactor, scaleFactor),
        blurRadius: blurRadius,
      )
    ];
  } else {
    return [
      BoxShadow(
        color: NeumorphicColors.generateGradientColors(
          colorBase: color,
          intensity: intensity,
        ),
        offset: offset.scale(scaleFactor, scaleFactor),
        blurRadius: blurRadius,
      ),
      BoxShadow(
        color: NeumorphicColors.generateGradientColors(
          colorBase: color,
          intensity: intensity,
        ),
        offset: offset.scale(scaleFactor, 0.2),
        blurRadius: blurRadius,
      ),
      BoxShadow(
        color: NeumorphicColors.generateGradientColors(
          colorBase: color,
          intensity: intensity,
        ),
        offset: offset.scale(0.25, scaleFactor),
        blurRadius: blurRadius,
      )
    ];
  }
}

List<BoxShadow> generateUsualBoxShadow({@required Offset offset, @required Color color, @required double intensity, @required double depth, @required double limit}) {
  if (offset == Offset.zero) {
    return [];
  }

  //white
  final List<BoxShadow> lightShadows = [];

  //print("offset shadow : $offset");

  //big and clear
  //lightShadows.addAll(generateMultipleShadow(
  //  dark: false,
  //  color: color,
  //  offset:  limitOffset(offset, -30, 30),
  //  intensity: 0.05 * (depth / 40) * intensity / 5,
  //  scaleFactor: 0.6,
  //  blurRadius: depth / 4,
  //));

  //medium depth
  lightShadows.addAll(generateMultipleShadow(
    dark: false,
    color: color,
    offset: limitOffset(offset, -18, 18).scale(
      1 + depth / 40,
      1 + depth / 40,
    ),
    intensity: 0.25 * (depth / 40) * intensity / 4,
    scaleFactor: 0.3,
    blurRadius: depth / 6,
  ));

  //////small & lighten
  lightShadows.addAll(generateMultipleShadow(
    dark: false,
    color: color,
    offset: limitOffset(offset, -20, 20).scale(
      depth / 30,
      depth / 30,
    ),
    intensity: 0.4 * (depth / 40) * intensity / 3,
    scaleFactor: 0.25,
    blurRadius: depth / 6,
  ));

  final List<BoxShadow> darkShadows = [];

  //big and clear
  darkShadows.addAll(generateMultipleShadow(
    dark: true,
    color: color,
    offset: limitOffset(offset, -30, 30),
    intensity: -1.5 * (depth / 12) * intensity / 5,
    scaleFactor: -1.0,
    blurRadius: depth,
  ));

  //medium depth
  darkShadows.addAll(generateMultipleShadow(
    dark: true,
    color: color,
    offset: limitOffset(offset, -20, 20),
    intensity: -1.5 * (depth / 12) * intensity / 4,
    scaleFactor: -0.5,
    blurRadius: depth / 2,
  ));

  //small & darken
  darkShadows.addAll(generateMultipleShadow(
    dark: true,
    color: color,
    offset: limitOffset(offset, -10, 10),
    intensity: -1.5 * (depth / 12) * intensity / 3,
    scaleFactor: -0.25,
    blurRadius: depth / 8,
  ));

  final List<BoxShadow> shadows = [];
  shadows.addAll(darkShadows);
  shadows.addAll(lightShadows);

  return shadows;
}

BoxDecoration generateNeumorphicDecoratorEmboss({
  /*nullable*/ Color accent,
  NeumorphicStyle style,
  NeumorphicBoxShape shape,
}) {
  List<BoxShadow> boxShadows;
  var innerColor = accent ?? style.baseColor;
  final offset = style.lightSource.toOffset(style.depth);

  if (offset == Offset.zero) {
    boxShadows = [];
  } else {
    var blackShadow = NeumorphicColors.generateGradientColors(
      colorBase: innerColor,
      intensity: -1 * (style.intensity * 0.1),
    );

    var whiteShadow = NeumorphicColors.generateGradientColors(
      colorBase: innerColor,
      intensity: style.intensity * 0.1,
    );

    var depthShadow = NeumorphicColors.darken(innerColor, 0.2);

    var spreadRadius = -style.depth * 0.9;

    boxShadows = [
      BoxShadow(
        color: blackShadow,
        offset: offset.scale(1, -1),
        blurRadius: style.depth,
        spreadRadius: spreadRadius,
      ),
      BoxShadow(
        color: blackShadow,
        offset: offset.scale(-1, 1),
        blurRadius: style.depth,
        spreadRadius: spreadRadius,
      ),
      BoxShadow(
        color: whiteShadow,
        offset: offset.scale(1, -1),
        blurRadius: style.depth,
        spreadRadius: spreadRadius,
      ),
      BoxShadow(
        color: whiteShadow,
        offset: offset.scale(-1, 1),
        blurRadius: style.depth,
        spreadRadius: spreadRadius,
      ),
      BoxShadow(
        color: blackShadow,
        offset: offset.scale(1, 1),
        blurRadius: style.depth,
        spreadRadius: spreadRadius,
      ),
      BoxShadow(
        color: blackShadow,
        offset: offset.scale(0, 1),
        blurRadius: style.depth,
        spreadRadius: spreadRadius,
      ),
      BoxShadow(
        color: blackShadow,
        offset: offset.scale(1, 0),
        blurRadius: style.depth,
        spreadRadius: spreadRadius,
      ),
      BoxShadow(
        color: whiteShadow,
        offset: offset.scale(0, -1),
        blurRadius: style.depth,
        spreadRadius: spreadRadius,
      ),
      BoxShadow(
        color: whiteShadow,
        offset: offset.scale(-1, 0),
        blurRadius: style.depth,
        spreadRadius: spreadRadius,
      ),
      BoxShadow(
        color: whiteShadow,
        offset: offset.scale(-1, -1),
        blurRadius: style.depth,
        spreadRadius: spreadRadius,
      ),
      BoxShadow(
        color: depthShadow,
        offset: Offset(0, 0),
      ),
      BoxShadow(
        color: innerColor,
        offset: offset.scale(-1, -1),
        blurRadius: style.depth,
        spreadRadius: spreadRadius,
      )
    ];
  }

  if (shape.isCircle) {
    return BoxDecoration(
      boxShadow: boxShadows,
      shape: shape.boxShape,
    );
  } else {
    return BoxDecoration(
      borderRadius: shape.borderRadius,
      boxShadow: boxShadows,
      shape: shape.boxShape,
    );
  }
}

BoxDecoration generateNeumorphicDecoratorFlat({
/*nullable*/ @required Color accent,
  @required NeumorphicStyle style,
  @required NeumorphicBoxShape shape,
}) {
  final Color innerColor = accent ?? style.baseColor;

  final List<BoxShadow> boxShadows = generateUsualBoxShadow(
    offset: style.lightSource.toOffset(style.depth),
    depth: style.depth,
    intensity: style.intensity,
    color: style.baseColor,
    limit: 8.0,
  );

  final Gradient gradient = NeumorphicColors.generateFlatGradients(
    color: NeumorphicColors.getAdjustColor(innerColor, 0 - style.depth / 2),
  );

  if (shape.isCircle) {
    return BoxDecoration(
      boxShadow: boxShadows,
      gradient: gradient,
      shape: shape.boxShape,
    );
  } else {
    return BoxDecoration(
      borderRadius: shape.borderRadius,
      boxShadow: boxShadows,
      gradient: gradient,
      shape: shape.boxShape,
    );
  }
}

BoxDecoration generateNeumorphicDecoratorConcaveConvex({
/*nullable*/ Color accent,
  NeumorphicStyle style,
  NeumorphicBoxShape shape,
}) {
  final Color innerColor = accent ?? style.baseColor;
  final double depth = style.depth.clamp(0, Neumorphic.MAX_DEPTH);

  final List<BoxShadow> boxShadows = generateUsualBoxShadow(
    offset: style.lightSource.toOffset(depth),
    depth: depth,
    intensity: style.intensity,
    color: style.baseColor,
    limit: 8.0,
  );

  final curveFactor = style.curveFactor.clamp(0, 1);

  final whiteFactor = 0 + ((curveFactor / 3.5) * depth / 300) + curveFactor / 3.5;
  final darkFactor = 0 - ((curveFactor / 2.5) * (depth / 28)) - curveFactor / 20;

  //print("curveFactor: $curveFactor style.depth: ${style.depth}");
  //print("whiteFactor: $whiteFactor");
  //print("darkFactor: $darkFactor");

  final convexConcaveOffset = style.lightSource.toOffset(style.curveFactor);

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
        0.9,
        1
      ]);

  if (shape.isCircle) {
    return BoxDecoration(
      boxShadow: boxShadows,
      gradient: gradient,
      shape: shape.boxShape,
    );
  } else {
    return BoxDecoration(
      borderRadius: shape.borderRadius,
      boxShadow: boxShadows,
      gradient: gradient,
      shape: shape.boxShape,
    );
  }
}

BoxDecoration generateNeumorphicDecorator(
    {
    /*nullable*/ Color accent,
    NeumorphicStyle style,
    NeumorphicBoxShape shape}) {
  //if depth is negative, force emboss
  if (style.depth < 0) {
    return generateNeumorphicDecoratorEmboss(
      accent: accent,
      style: style.copyWith(depth: -style.depth),
      shape: shape,
    );
  }

  if (style.shape == NeumorphicShape.emboss) {
    return generateNeumorphicDecoratorEmboss(
      accent: accent,
      style: style,
      shape: shape,
    );
  } else if (style.shape == NeumorphicShape.flat) {
    return generateNeumorphicDecoratorFlat(
      accent: accent,
      style: style,
      shape: shape,
    );
  } else {
    return generateNeumorphicDecoratorConcaveConvex(
      accent: accent,
      style: style,
      shape: shape,
    );
  }
}

Widget generateNeumorphicChild({
  Color accent,
  NeumorphicStyle style,
  NeumorphicBoxShape shape,
  Widget child,
}) {
  return child;
}
