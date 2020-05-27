import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class NeumorphicBackButton extends StatelessWidget {
  final VoidCallback onPressed;

  const NeumorphicBackButton({Key key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return NeumorphicButton(
      tooltip: MaterialLocalizations.of(context).backButtonTooltip,
      child: Icon([TargetPlatform.iOS, TargetPlatform.macOS].contains(theme.platform) ? Icons.arrow_back_ios : Icons.arrow_back),
      onPressed: onPressed ?? () => Navigator.maybePop(context),
    );
  }
}
