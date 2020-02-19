import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/theme_finder.dart';
import 'package:provider/provider.dart';

import 'flutter_neumorphic.dart';

export 'flutter_neumorphic.dart';

class NeumorphicContainer extends StatelessWidget {
  final Widget child;
  final Color accent;
  final NeumorphicStyle style;

  NeumorphicContainer({this.child, this.style, this.accent});

  @override
  Widget build(BuildContext context) {
    final decorator = generateNeumorphicDecorator(
      base: NeumorphicColors.background,
      accent: this.accent,
      style: this.style,
      theme: findNeumorphicTheme(context),
    );

    return Container(
      child: child,
      decoration: decorator,
    );
  }
}
