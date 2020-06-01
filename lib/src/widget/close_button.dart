import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class NeumorphicCloseButton extends StatelessWidget {
  final VoidCallback onPressed;
  final NeumorphicStyle style;
  final EdgeInsets padding;

  const NeumorphicCloseButton({
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
      tooltip: MaterialLocalizations.of(context).closeButtonTooltip,
      child: Icon(
        Icons.close,
      ),
      onPressed: onPressed ?? () => Navigator.maybePop(context),
    );
  }
}
