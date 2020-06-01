import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class NeumorphicBackButton extends StatelessWidget {
  final VoidCallback onPressed;
  final NeumorphicStyle style;
  final EdgeInsets padding;
  final bool reversedArrow;

  const NeumorphicBackButton({
    Key key,
    this.onPressed,
    this.style,
    this.padding,
    this.reversedArrow = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return NeumorphicButton(
      style: style,
      padding: padding,
      tooltip: MaterialLocalizations.of(context).backButtonTooltip,
      child: Icon(_getIcon(theme)),
      onPressed: onPressed ?? () => Navigator.maybePop(context),
    );
  }

  IconData _getIcon(ThemeData theme) {
    if (reversedArrow) {
      return [TargetPlatform.iOS, TargetPlatform.macOS].contains(theme.platform) ? Icons.arrow_forward_ios : Icons.arrow_forward;
    }
    return [TargetPlatform.iOS, TargetPlatform.macOS].contains(theme.platform) ? Icons.arrow_back_ios : Icons.arrow_back;
  }
}
