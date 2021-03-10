import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_neumorphic/src/widget/container.dart';

/// Defines default colors used in Neumorphic theme & shadows generators
@immutable
class NeumorphicColors {
  static const background = Color(0xFFDDE6E8);
  static const accent = Color(0xFF2196F3);
  static const variant = Color(0xFF00BCD4);
  static const disabled = Color(0xFF9E9E9E);

  static const darkBackground = Color(0xFF2D2F2F);
  static const darkAccent = Color(0xFF4CAF50);
  static const darkVariant = Color(0xFF607D8B);
  static const darkDisabled = Color(0xB3FFFFFF);
  static const darkDefaultTextColor = Color(0xB3FFFFFF);

  static const Color defaultBorder = Color(0x33000000);
  static const Color darkDefaultBorder = Color(0x33FFFFFF);

  static const Color decorationMaxWhiteColor =
      Color(0xFFFFFFFF); //for intensity = 1
  static const Color decorationMaxDarkColor =
      Color(0x8A000000); //for intensity = 1

  static const Color embossMaxWhiteColor =
      Color(0x99FFFFFF); //for intensity = 1
  static const Color embossMaxDarkColor = Color(0x73000000); //for intensity = 1

  static const Color _gradientShaderDarkColor = Color(0x8A000000);
  static const Color _gradientShaderWhiteColor = Color(0xFFFFFFFF);

  static const Color defaultTextColor = Color(0xFF000000);

  NeumorphicColors._();

  static Color decorationWhiteColor(Color color, {required double intensity}) {
    // intensity act on opacity;
    return _applyPercentageOnOpacity(
      maxColor: color,
      percent: intensity,
    );
  }

  static Color decorationDarkColor(Color color, {required double intensity}) {
    // intensity act on opacity;
    return _applyPercentageOnOpacity(
      maxColor: color,
      percent: intensity,
    );
  }

  static Color embossWhiteColor(Color color, {required double intensity}) {
    // intensity act on opacity;
    return _applyPercentageOnOpacity(
      maxColor: color,
      percent: intensity,
    );
  }

  static Color embossDarkColor(Color color, {required double intensity}) {
    // intensity act on opacity;
    return _applyPercentageOnOpacity(
      maxColor: color,
      percent: intensity,
    );
  }

  static Color gradientShaderDarkColor({required double intensity}) {
    // intensity act on opacity;
    return _applyPercentageOnOpacity(
        maxColor: NeumorphicColors._gradientShaderDarkColor,
        percent: intensity);
  }

  static Color gradientShaderWhiteColor({required double intensity}) {
    // intensity act on opacity;
    return _applyPercentageOnOpacity(
        maxColor: NeumorphicColors._gradientShaderWhiteColor,
        percent: intensity);
  }

  static Color _applyPercentageOnOpacity(
      {required Color maxColor, required double percent}) {
    final maxOpacity = maxColor.opacity;
    final maxIntensity = Neumorphic.MAX_INTENSITY;
    final newOpacity = percent * maxOpacity / maxIntensity;
    final newColor =
        maxColor.withOpacity(newOpacity); //<-- intensity act on opacity;
    return newColor;
  }
}
