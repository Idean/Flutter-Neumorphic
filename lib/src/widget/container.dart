import 'package:flutter/widgets.dart';

import '../NeumorphicBoxShape.dart';
import '../decoration/neumorphic_box_decorations.dart';
import '../theme/neumorphic_theme.dart';
import 'clipper/NeumorphicBoxShapeClipper.dart';

export '../NeumorphicBoxShape.dart';
export '../decoration/neumorphic_box_decorations.dart';
export '../theme/neumorphic_theme.dart';

/// The main container of the Neumorphic UI KIT
/// it takes a Neumorphic style @see [NeumorphicStyle]
///
/// it's clipped using a [NeumorphicBoxShape] (circle, roundrect, stadium)
///
/// It can be, depending on its [NeumorphicStyle.shape] : [NeumorphicShape.concave],  [NeumorphicShape.convex],  [NeumorphicShape.flat]
///
/// if [NeumorphicStyle.depth] < 0 ----> use the emboss shape
///
/// The container animates any change for you, with [duration] ! (including style / theme / size / etc.)
///
@immutable
class Neumorphic extends StatelessWidget {
  static const DEFAULT_DURATION = const Duration(milliseconds: 100);

  static const double MIN_DEPTH = -20.0;
  static const double MAX_DEPTH = 20.0;

  static const double MIN_INTENSITY = 0.0;
  static const double MAX_INTENSITY = 1.0;

  static const double MIN_CURVE = 0.0;
  static const double MAX_CURVE = 1.0;

  final Widget child;

  final NeumorphicStyle style;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final NeumorphicBoxShape boxShape;
  final Duration duration;

  Neumorphic({
    Key key,
    this.child,
    this.duration = Neumorphic.DEFAULT_DURATION,
    this.style,
    this.boxShape,
    this.margin = const EdgeInsets.all(0),
    this.padding = const EdgeInsets.all(0),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final boxShape = this.boxShape ?? NeumorphicBoxShape.roundRect();
    final theme = NeumorphicTheme.currentTheme(context) ?? neumorphicDefaultTheme;
    final NeumorphicStyle style = (this.style ?? NeumorphicStyle()).copyWithThemeIfNull(theme);

    return _NeumorphicContainer(
      padding: this.padding,
      gradientLightSource: style.lightSource,
      boxShape: boxShape,
      duration: this.duration,
      style: style,
      margin: this.margin,
      child: this.child,
    );
  }
}

class _NeumorphicContainer extends StatefulWidget {
  final NeumorphicStyle style;
  final NeumorphicBoxShape boxShape;
  final Widget child;
  final EdgeInsets margin;
  final LightSource gradientLightSource; //the lightsource used to display concave/convex
  final Duration duration;
  final EdgeInsets padding;

  _NeumorphicContainer({
    Key key,
    @required this.child,
    @required this.padding,
    @required this.margin,
    @required this.duration,
    @required this.style,
    @required this.boxShape,
    @required this.gradientLightSource,
  }) : super(key: key);

  @override
  createState() => _NeumorphicContainerState();
}

class _NeumorphicContainerState extends State<_NeumorphicContainer> {
  @override
  Widget build(BuildContext context) {
    //print("widget.padding : ${widget.padding}");
    return AnimatedContainer(
        margin: widget.margin,
        duration: widget.duration,
        child: NeumorphicBoxShapeClipper(
          shape: widget.boxShape,
          child: Padding(
            padding: widget.padding,
            child: widget.child,
          ),
        ),
        decoration: NeumorphicBoxDecoration(
          gradientLightSource: widget.gradientLightSource,
          style: widget.style,
          shape: widget.boxShape,
        ));
  }
}
