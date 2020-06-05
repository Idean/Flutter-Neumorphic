import 'dart:math' as math show pi;

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class NeumorphicCloseButton extends StatelessWidget {
  final VoidCallback onPressed;
  final NeumorphicStyle style;
  final EdgeInsets padding;
  final bool reversedIcon;

  const NeumorphicCloseButton({
    Key key,
    this.onPressed,
    this.style,
    this.padding,
    this.reversedIcon = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final nThemeIcons = NeumorphicTheme.of(context).current.appBarTheme.icons;
    return NeumorphicButton(
      style: style,
      padding: padding,
      tooltip: MaterialLocalizations.of(context).closeButtonTooltip,
      child: reversedIcon
          ? Transform.rotate(
              angle: 180 * math.pi / 180, child: nThemeIcons.closeIcon)
          : nThemeIcons.closeIcon,
      onPressed: onPressed ?? () => Navigator.maybePop(context),
    );
  }
}
