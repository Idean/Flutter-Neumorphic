import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_neumorphic/flutter_neumorphic.dart';

@immutable
class NeumorphicAppBarThemeData {
  final Color color;
  final IconThemeData? iconTheme;
  final NeumorphicStyle buttonStyle;
  final EdgeInsets buttonPadding;
  final bool? centerTitle;
  final TextStyle? textStyle;
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
  final Icon? _backIcon;
  final Icon? _forwardIcon;

  const NeumorphicAppBarIcons({
    this.menuIcon = const Icon(Icons.menu),
    this.closeIcon = const Icon(Icons.close),
    Icon? backIcon,
    Icon? forwardIcon,
  })  : _backIcon = backIcon,
        _forwardIcon = forwardIcon;

  //if back icon null then get platform oriented icon
  Icon get backIcon => _backIcon ?? _getBackIcon;
  Icon get _getBackIcon => Platform.isIOS || Platform.isMacOS
      ? const Icon(Icons.arrow_back_ios)
      : const Icon(Icons.arrow_back);

  Icon get forwardIcon => _forwardIcon ?? _getForwardIcon;
  Icon get _getForwardIcon => Platform.isIOS || Platform.isMacOS
      ? const Icon(Icons.arrow_forward_ios)
      : const Icon(Icons.arrow_forward);

  NeumorphicAppBarIcons copyWith({
    Icon? backIcon,
    Icon? closeIcon,
    Icon? menuIcon,
    Icon? forwardIcon,
  }) {
    return NeumorphicAppBarIcons(
      backIcon: backIcon ?? this.backIcon,
      closeIcon: closeIcon ?? this.closeIcon,
      menuIcon: menuIcon ?? this.menuIcon,
      forwardIcon: forwardIcon ?? this.forwardIcon,
    );
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is NeumorphicAppBarIcons &&
        o.backIcon == backIcon &&
        o.closeIcon == closeIcon &&
        o.menuIcon == menuIcon &&
        o.forwardIcon == forwardIcon;
  }

  @override
  int get hashCode =>
      backIcon.hashCode ^
      closeIcon.hashCode ^
      menuIcon.hashCode ^
      forwardIcon.hashCode;

  @override
  String toString() =>
      'NeumorphicAppBarIcons(backIcon: $backIcon, closeIcon: $closeIcon, menuIcon: $menuIcon, forwardIcon: $forwardIcon)';
}
