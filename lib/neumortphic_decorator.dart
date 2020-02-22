import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

BoxDecoration generateNeumorphicDecoratorEmboss({
  /*nullable*/ Color accent,
  NeumorphicStyle style,
  BoxShape shape,
}) {
  final Color innerColor = accent ?? style.baseColor;
  final offset = sourceToOffset(style.lightSource, style.distance);

  // shadows
  List<BoxShadow> boxShadows = [];
  if (offset != Offset.zero) {
    boxShadows = [
      BoxShadow(
        color: NeumorphicColors.generateGradientColors(colorBase: style.baseColor, intensity: -1 * (style.intensity * 0.5)),
        offset: offset.scale(-1, -1),
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
    color: NeumorphicColors.generateGradientColors(colorBase: innerColor, intensity: -1 * style.intensity),
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
/*nullable*/ Color accent,
  NeumorphicStyle style,
  BoxShape shape,
}) {
  final offset = sourceToOffset(style.lightSource, style.distance);
  final Color innerColor = accent ?? style.baseColor;

  List<BoxShadow> boxShadows = [];
  if (offset != Offset.zero) {
    boxShadows = [
      BoxShadow(
        color: NeumorphicColors.generateGradientColors(colorBase: style.baseColor, intensity: -1 * style.intensity),
        offset: offset,
        blurRadius: style.distance, //TODO
      ),
      BoxShadow(
        color: NeumorphicColors.generateGradientColors(colorBase: style.baseColor, intensity: style.intensity),
        offset: offset.scale(-1, -1),
        blurRadius: style.distance, //TODO
      ),
    ];
  }

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
  final offset = sourceToOffset(style.lightSource, style.distance);

  final Color innerColor = accent ?? style.baseColor;

  List<BoxShadow> boxShadows = [];
  if (offset != Offset.zero) {
    boxShadows = [
      BoxShadow(
        color: NeumorphicColors.generateGradientColors(colorBase: style.baseColor, intensity: -1 * style.intensity / 2),
        offset: offset,
        blurRadius: style.distance / 1.5, //TODO
      ),
      BoxShadow(
        color: NeumorphicColors.generateGradientColors(colorBase: style.baseColor, intensity: style.intensity / 2.5),
        offset: offset.scale(-1, -1),
        blurRadius: style.distance / 1.5, //TODO
      ),
    ];
  }

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
