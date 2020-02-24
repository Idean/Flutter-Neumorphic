import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/theme_finder.dart';

import '../NeumorphicBoxShape.dart';
import '../flutter_neumorphic.dart';

@immutable
class Neumorphic extends StatelessWidget {

  static const double MIN_DEPTH = -20.0;
  static const double MAX_DEPTH = 20.0;

  static const double MIN_CURVE = 0.0;
  static const double MAX_CURVE = 1.0;

  final Widget child;
  final Color accent;
  final NeumorphicStyle style;
  final EdgeInsets padding;
  final NeumorphicBoxShape shape;

  //forces have 2 different widgets if the shape changes
  final Key _circleKey = Key("circle");
  final Key _rectangleKey = Key("rectangle");

  Neumorphic({
    Key key,
    this.child,
    this.style,
    this.accent,
    this.shape,
    this.padding = const EdgeInsets.all(4),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final theme = findNeumorphicTheme(context) ?? neumorphicDefaultTheme;
    final style = (this.style ?? NeumorphicStyle()).copyWithThemeIfNull(theme);
    final shape = this.shape ?? NeumorphicBoxShape.roundRect();

    final decorator = generateNeumorphicDecorator(
      accent: this.accent,
      style:  style,
      shape: shape
    );

    final child = generateNeumorphicChild(
        accent: this.accent,
        style:  style,
        shape: this.shape,
        child: this.child,
    );

    return AnimatedContainer(
      key: shape.isCircle ? _circleKey : _rectangleKey,
      duration: const Duration(milliseconds: 150),
      child: child,
      decoration: decorator,
      padding: this.padding,
    );
  }

}
