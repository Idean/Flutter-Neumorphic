import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class NeumorphicBackButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final NeumorphicStyle? style;
  final EdgeInsets? padding;
  final bool forward;

  const NeumorphicBackButton({
    Key? key,
    this.onPressed,
    this.style,
    this.padding,
    this.forward = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final nThemeIcons = NeumorphicTheme.of(context)!.current!.appBarTheme.icons;
    return NeumorphicButton(
      style: style,
      padding: padding,
      tooltip: MaterialLocalizations.of(context).backButtonTooltip,
      child: forward ? nThemeIcons.forwardIcon : nThemeIcons.backIcon,
      onPressed: onPressed ?? () => Navigator.maybePop(context),
    );
  }
}
