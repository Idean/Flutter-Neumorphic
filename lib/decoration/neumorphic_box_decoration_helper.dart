
import 'package:flutter/material.dart' as materialColors; //TODO rmove this later ?
import 'package:flutter/widgets.dart';

import '../flutter_neumorphic.dart';
import '../theme.dart';

Shader getGradientShader(Rect gradientRect, LightSource source) {

  var sourceInvert = source.invert();

  final Gradient gradient = new LinearGradient(
    begin: Alignment(source.dx, source.dy),
    end: Alignment(sourceInvert.dx, sourceInvert.dy),
    colors: <Color>[
      materialColors.Colors.black12,
      materialColors.Colors.white12,
    ],
    stops: [
      0,
      1,
    ],
  );

  return gradient.createShader(gradientRect);
}
