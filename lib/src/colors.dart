import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' as material;
import 'package:flutter/painting.dart';
import 'package:flutter_neumorphic/src/widget/container.dart';

/// Defines default colors used in Neumorphic theme & shadows generators
@immutable
class NeumorphicColors {
  static const background = Color(0xFFDDE6E8);
  static const accent = material.Colors.blue;
  static const variant = material.Colors.cyan;
  static const disabled = material.Colors.grey;

  static const darkBackground = Color(0xFF2D2F2F);
  static const darkAccent = material.Colors.green;
  static const darkVariant = material.Colors.blueGrey;
  static const darkDisabled = material.Colors.white70;

  static Color _decorationMaxWhiteColor =
      material.Colors.white; //for intensity = 1
  static Color _decorationMaxDarkColor =
      material.Colors.black54; //for intensity = 1

  static Color _embossMaxWhiteColor =
      material.Colors.white60; //for intensity = 1
  static Color _embossMaxDarkColor =
      material.Colors.black45; //for intensity = 1

  static Color _gradientShaderDarkColor = material.Colors.black54;
  static Color _gradientShaderWhiteColor = material.Colors.white;

  NeumorphicColors._();

  static Color decorationWhiteColor({@required double intensity}) {
    // intensity act on opacity;
    return _applyPercentageOnOpacity(
        maxColor: NeumorphicColors._decorationMaxWhiteColor,
        percent: intensity);
  }

  static Color decorationDarkColor({@required double intensity}) {
    // intensity act on opacity;
    return _applyPercentageOnOpacity(
        maxColor: NeumorphicColors._decorationMaxDarkColor, percent: intensity);
  }

  static Color embossWhiteColor({@required double intensity}) {
    // intensity act on opacity;
    return _applyPercentageOnOpacity(
        maxColor: NeumorphicColors._embossMaxWhiteColor, percent: intensity);
  }

  static Color embossDarkColor({@required double intensity}) {
    // intensity act on opacity;
    return _applyPercentageOnOpacity(
        maxColor: NeumorphicColors._embossMaxDarkColor, percent: intensity);
  }

  static Color gradientShaderDarkColor({@required double intensity}) {
    // intensity act on opacity;
    return _applyPercentageOnOpacity(
        maxColor: NeumorphicColors._gradientShaderDarkColor,
        percent: intensity);
  }

  static Color gradientShaderWhiteColor({@required double intensity}) {
    // intensity act on opacity;
    return _applyPercentageOnOpacity(
        maxColor: NeumorphicColors._gradientShaderWhiteColor,
        percent: intensity);
  }

  static Color _applyPercentageOnOpacity(
      {@required Color maxColor, @required double percent}) {
    final maxOpacity = maxColor.opacity;
    final maxIntensity = Neumorphic.MAX_INTENSITY;
    final newOpacity = percent * maxOpacity / maxIntensity;
    final newColor =
        maxColor.withOpacity(newOpacity); //<-- intensity act on opacity;
    return newColor;
  }
}
