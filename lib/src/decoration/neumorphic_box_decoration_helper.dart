import 'package:flutter/widgets.dart';

import '../theme/theme.dart';

Shader getGradientShader({Rect gradientRect, LightSource source, double intensity=0.25}) {
  var sourceInvert = source.invert();

  final opacity = intensity * (3/5);

  final Gradient gradient = new LinearGradient(
    begin: Alignment(source.dx, source.dy),
    end: Alignment(sourceInvert.dx, sourceInvert.dy),
    colors: <Color>[
      NeumorphicColors.gradientShaderDarkColor.withOpacity(opacity),
      NeumorphicColors.gradientShaderWhiteColor.withOpacity(opacity * (2/5)),
    ],
    stops: [
      0,
      0.75, //was 1 but set to 0.75 to be less dark
    ],
  );

  return gradient.createShader(gradientRect);
}
