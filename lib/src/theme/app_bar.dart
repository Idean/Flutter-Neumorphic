import 'dart:io';

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
  final NeumorphicAppBarIcons icons;

  const NeumorphicAppBarThemeData({
    this.color = Colors.transparent,
    this.iconTheme,
    this.textStyle,
    this.buttonStyle = const NeumorphicStyle(),
    this.centerTitle,
    this.buttonPadding = const EdgeInsets.all(0),
    this.icons = const NeumorphicAppBarIcons(),
  });
}

class NeumorphicAppBarIcons {
  final Icon closeIcon;
  final Icon menuIcon;
  final Icon _backIcon;

  const NeumorphicAppBarIcons({
    this.menuIcon = const Icon(Icons.menu),
    this.closeIcon = const Icon(Icons.close),
    Icon backIcon,
  }) : _backIcon = backIcon;

  //if back icon null then get platform oriented icon
  Icon get backIcon => _backIcon ?? _getBackIcon;
  Icon get _getBackIcon => Platform.isIOS || Platform.isMacOS
      ? const Icon(Icons.arrow_back_ios)
      : const Icon(Icons.arrow_back);

  NeumorphicAppBarIcons copyWith({
    Icon backIcon,
    Icon closeIcon,
    Icon menuIcon,
  }) {
    return NeumorphicAppBarIcons(
      backIcon: backIcon ?? this.backIcon,
      closeIcon: closeIcon ?? this.closeIcon,
      menuIcon: menuIcon ?? this.menuIcon,
    );
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is NeumorphicAppBarIcons &&
        o.backIcon == backIcon &&
        o.closeIcon == closeIcon &&
        o.menuIcon == menuIcon;
  }

  @override
  int get hashCode =>
      backIcon.hashCode ^ closeIcon.hashCode ^ menuIcon.hashCode;

  @override
  String toString() =>
      'NeumorphicAppBarIcons(backIcon: $backIcon, closeIcon: $closeIcon, menuIcon: $menuIcon)';
}
