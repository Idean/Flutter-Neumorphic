import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class NeumorphicBackButton extends StatelessWidget {
  final VoidCallback onPressed;
  final NeumorphicStyle style;
  final EdgeInsets padding;

  const NeumorphicBackButton({
    Key key,
    this.onPressed,
    this.style = const NeumorphicStyle(),
    this.padding = const EdgeInsets.all(0),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final nTheme = NeumorphicTheme.of(context);
    return NeumorphicButton(
      style: style,
      padding: padding,
      tooltip: MaterialLocalizations.of(context).backButtonTooltip,
      child: Icon(
        [TargetPlatform.iOS, TargetPlatform.macOS].contains(theme.platform) ? Icons.arrow_back_ios : Icons.arrow_back,
        color: nTheme.current.accentColor,
      ),
      onPressed: onPressed ?? () => Navigator.maybePop(context),
    );
  }
}
