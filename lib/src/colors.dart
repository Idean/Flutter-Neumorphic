import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' as material;
import 'package:flutter/painting.dart';

/// Defines default colors used in Neumorphic theme & shadows generators
@immutable
class NeumorphicColors {
  static const background = Color(0xFFDDE6E8);
  static const accent = material.Colors.blue;
  static const variant = material.Colors.cyan;

  static const darkBackground = Color(0xFF2D2F2F);
  static const darkAccent = material.Colors.green;
  static const darkVariant = material.Colors.blueGrey;

  static Color decorationMaxWhiteColor =
      material.Colors.white; //for intensity = 1
  static Color decorationMaxDarkColor =
      material.Colors.black45; //for intensity = 1

  static Color embossMaxWhiteColor =
      material.Colors.white60; //for intensity = 1
  static Color embossMaxDarkColor = material.Colors.black45; //for intensity = 1

  static Color gradientShaderDarkColor = material.Colors.black12;
  static Color gradientShaderWhiteColor = material.Colors.white12;

  NeumorphicColors._();
}