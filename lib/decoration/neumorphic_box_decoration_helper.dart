import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../flutter_neumorphic.dart';
import '../theme.dart';

Shader getGradientShader(Rect gradientRect, LightSource source) {

  var sourceInvert = source.invert();

  final Gradient gradient = new LinearGradient(
    begin: Alignment(source.dx, source.dy),
    end: Alignment(sourceInvert.dx, sourceInvert.dy),
    colors: <Color>[
      Colors.black12,
      Colors.white12,
    ],
    stops: [
      0,
      1,
    ],
  );

  return gradient.createShader(gradientRect);
}
