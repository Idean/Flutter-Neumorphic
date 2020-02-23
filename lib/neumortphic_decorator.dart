import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

Offset limitOffset(Offset offset, double minXY, double maxXY) {
  final dx = offset.dx.clamp(minXY, maxXY);
  final dy = offset.dy.clamp(minXY, maxXY);
  return Offset(dx, dy);
}

List<BoxShadow> generateUsualBoxShadow({@required Offset offset, @required Color color, @required double intensity, @required double distance, @required double limit}) {
  if (offset == Offset.zero) {
    return [];
  }
  return [
    //white
    //big and clear
    BoxShadow(
      color: NeumorphicColors.generateGradientColors(colorBase: color, intensity: (distance / 10) * intensity / 3),
      offset: offset,
      blurRadius: distance / 2,
    ),
    //medium distance
    BoxShadow(
      color: NeumorphicColors.generateGradientColors(colorBase: color, intensity: (distance / 10) * intensity),
      offset: limitOffset(offset, -limit, limit),
      blurRadius: distance / 4,
    ),
    ////small & darken
    BoxShadow(
      color: NeumorphicColors.generateGradientColors(colorBase: color, intensity: (distance / 10) * intensity),
      offset: limitOffset(offset, -limit, limit),
      blurRadius: distance / 4,
    ),

    //dark
    //big and clear
    BoxShadow(
      color: NeumorphicColors.generateGradientColors(colorBase: color, intensity: (distance / 10) * -1 * intensity / 3),
      offset: offset.scale(-1 * (distance / 50), -1 * (distance / 50)),
      blurRadius: distance / 2,
    ),
    //medium distance
    BoxShadow(
      color: NeumorphicColors.generateGradientColors(colorBase: color, intensity: (distance / 10) * -1 * intensity / 2),
      offset: limitOffset(offset, -limit * (distance / 20), limit * (distance / 20)).scale(-1, -1),
      blurRadius: distance / 4,
    ),
    //small & darken
    BoxShadow(
      color: NeumorphicColors.generateGradientColors(colorBase: color, intensity: (distance / 10) * -1 * intensity),
      offset: limitOffset(offset, -limit, limit).scale(-1, -1),
      spreadRadius: 0.5,
      blurRadius: distance / 4,
    ),
  ];
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

  final List<BoxShadow> boxShadows = generateUsualBoxShadow(
      offset:  sourceToOffset(style.lightSource, style.distance),
      distance: style.distance,
      intensity: style.intensity,
      color: style.baseColor,
      limit:  8.0
  );

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

  final List<BoxShadow> boxShadows = generateUsualBoxShadow(
      offset:  sourceToOffset(style.lightSource, style.distance),
      distance: style.distance,
      intensity: style.intensity,
      color: style.baseColor,
      limit:  8.0
  );

  double darkFactor = (style.distance / 50 + style.curveFactor.clamp(0, 1) / 15) / 2;
  double whiteFactor = (style.distance / 60 + style.curveFactor.clamp(0, 1) / 15) / 2;

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
    /*nullable*/ BoxShape shape}) {
  //will only use style from here, style is not null

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
