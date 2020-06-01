import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

@immutable
class NeumorphicAppBarThemeData {
  final Color color;
  final IconThemeData iconTheme;
  final NeumorphicStyle buttonStyle;
  final EdgeInsets buttonPadding;
  final bool centerTitle;
  final TextStyle textStyle;

  const NeumorphicAppBarThemeData({
    this.color = Colors.transparent,
    this.iconTheme,
    this.textStyle,
    this.buttonStyle = const NeumorphicStyle(),
    this.centerTitle,
    this.buttonPadding = const EdgeInsets.all(0),
  });
}
