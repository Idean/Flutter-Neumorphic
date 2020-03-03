import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart' as material;
import 'package:flutter/painting.dart';

class NeumorphicColors {
  static const background = Color(0xFFDDE6E8);
  static const accent = material.Colors.blue;
  static const variant = material.Colors.cyan;

  static const darkBackground = Color(0xFF2D2F2F);
  static const darkAccent = material.Colors.green;
  static const darkVariant = material.Colors.blueGrey;

  static Color decorationMaxWhiteColor = material.Colors.white; //for intensity = 1
  static Color decorationMaxDarkColor = material.Colors.black45; //for intensity = 1

  static Color embossMaxWhiteColor = material.Colors.white60; //for intensity = 1
  static Color embossMaxDarkColor = material.Colors.black45; //for intensity = 1

  static Color gradientShaderDarkColor = material.Colors.black12;
  static Color gradientShaderWhiteColor = material.Colors.white12;

  /// Generate a shadow color from the [base] color and a relative [intensity].
  /// Positive intensity denotes a darker shade while negative intensity
  /// denotes a lighter shade.
  /// Credit for the algorithm goes to https://neumorphism.io
  static Color generateGradientColors(
      {Color colorBase, double intensity, bool updateAlpha = true}) {
    final t = intensity ?? 0;
    String e = colorBase.value.toRadixString(16).substring(2);
    if (e.length < 6) e = e[0] + e[0] + e[1] + e[1] + e[2] + e[2];
    String o = '';
    for (int n = 0; n < 3; n++) {
      var a = int.parse(e.substring(2 * n, 2 * n + 2), radix: 16);
      a = min(max(0, (a + a * t).round()), 255);
      o += ('00' + a.toRadixString(16)).substring(a.toRadixString(16).length);
    }

    final generatedColor = Color(int.parse(o, radix: 16));
    if (updateAlpha) {
      return generatedColor.withAlpha(255);
    } else {
      return generatedColor;
    }
  }

  static Color darken(Color color, [double amount = .1]) {
    assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(color);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));

    return hslDark.toColor();
  }

  static Gradient generateFlatGradients({Color color}) => LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          color,
          color,
        ],
      );

  static Color getAdjustColor(Color baseColor, double amount) {
    Map<String, int> colors = {
      'r': baseColor.red,
      'g': baseColor.green,
      'b': baseColor.blue
    };

    colors = colors.map((key, value) {
      if (value + amount < 0) {
        return MapEntry(key, 0);
      }
      if (value + amount > 255) {
        return MapEntry(key, 255);
      }
      return MapEntry(key, (value + amount).floor());
    });
    return Color.fromRGBO(colors['r'], colors['g'], colors['b'], 1);
  }
}
