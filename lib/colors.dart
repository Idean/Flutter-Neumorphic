import 'dart:math';
import 'dart:ui';

class NeumorphicColors {
  static const background = Color(0xffF1F2F4);

  /// Generate a shadow color from the [base] color and a relative [intensity].
  /// Positive intensity denotes a darker shade while negative intensity
  /// denotes a lighter shade.
  /// Credit for the algorithm goes to https://neumorphism.io
  static Color generateGradientColors({Color colorBase, double intensity}) {
    final t = intensity ?? 0;
    String e = colorBase.value.toRadixString(16).substring(2);
    if (e.length < 6) e = e[0] + e[0] + e[1] + e[1] + e[2] + e[2];
    String o = '';
    for (int n = 0; n < 3; n++) {
      var a = int.parse(e.substring(2 * n, 2 * n + 2), radix: 16);
      a = min(max(0, (a + a * t).round()), 255);
      o += ('00' + a.toRadixString(16)).substring(a.toRadixString(16).length);
    }

    return Color(int.parse(o, radix: 16)).withAlpha(255);
  }
}
