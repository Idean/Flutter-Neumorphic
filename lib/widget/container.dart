import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/theme_finder.dart';

import '../flutter_neumorphic.dart';

class Neumorphic extends StatelessWidget {
  final Widget child;
  final Color accent;
  final NeumorphicStyle style;
  final EdgeInsets padding;
  final BoxShape shape;

  Neumorphic({
    this.child,
    this.style,
    this.accent,
    this.shape,
    this.padding = const EdgeInsets.all(4),
  });

  @override
  Widget build(BuildContext context) {
    final decorator = generateNeumorphicDecorator(
      accent: this.accent,
      style: this.style,
      theme: findNeumorphicTheme(context),
      shape: shape
    );

    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      child: child,
      decoration: decorator,
      padding: this.padding,
    );
  }
}
