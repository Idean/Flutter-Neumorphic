
import 'package:flutter/widgets.dart';

import '../flutter_neumorphic.dart';
import '../theme.dart';

Shader getGradientShader(Rect gradientRect, LightSource source) {

  var sourceInvert = source.invert();

  final Gradient gradient = new LinearGradient(
    begin: Alignment(source.dx, source.dy),
    end: Alignment(sourceInvert.dx, sourceInvert.dy),
    colors: <Color>[
      NeumorphicColors.gradientShaderDarkColor,
      NeumorphicColors.gradientShaderWhiteColor
    ],
    stops: [
      0,
      0.75,
    ],
  );

  return gradient.createShader(gradientRect);
}
