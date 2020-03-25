import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic/src/decoration/foreground/neumorphic_foreground_decorations.dart';

import '../NeumorphicBoxShape.dart';
import '../decoration/box/neumorphic_box_decorations.dart';
import '../theme/neumorphic_theme.dart';
import 'clipper/NeumorphicBoxShapeClipper.dart';

export '../NeumorphicBoxShape.dart';
export '../decoration/box/neumorphic_box_decorations.dart';
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
/// [drawSurfaceAboveChild] enable to draw emboss, concave, convex effect above this widget child
///
/// drawSurfaceAboveChild - UseCase 1 :
///
///   put an image inside a neumorphic(concave) :
///   drawSurfaceAboveChild=false -> the concave effect is below the image
///   drawSurfaceAboveChild=true -> the concave effect is above the image, the image seems concave
///
/// drawSurfaceAboveChild - UseCase 2 :
///   put an image inside a neumorphic(emboss) :
///   drawSurfaceAboveChild=false -> the emboss effect is below the image -> not visible
///   drawSurfaceAboveChild=true -> the emboss effeect effect is above the image -> visible
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
  final bool
      drawSurfaceAboveChild; //if true => boxDecoration & foreground decoration, else => boxDecoration does all the work

  Neumorphic({
    Key key,
    this.child,
    this.duration = Neumorphic.DEFAULT_DURATION,
    this.style,
    this.boxShape,
    this.margin = const EdgeInsets.all(0),
    this.padding = const EdgeInsets.all(0),
    this.drawSurfaceAboveChild = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final boxShape = this.boxShape ?? NeumorphicBoxShape.roundRect();
    final theme =
        NeumorphicTheme.currentTheme(context) ?? neumorphicDefaultTheme;
    final NeumorphicStyle style =
        (this.style ?? NeumorphicStyle()).copyWithThemeIfNull(theme);

    return _NeumorphicContainer(
      padding: this.padding,
      boxShape: boxShape,
      drawSurfaceAboveChild: this.drawSurfaceAboveChild,
      duration: this.duration,
      style: style,
      margin: this.margin,
      child: this.child,
    );
  }
}

class _NeumorphicContainer extends StatelessWidget {
  final NeumorphicStyle style;
  final NeumorphicBoxShape boxShape;
  final Widget child;
  final EdgeInsets margin;
  final Duration duration;
  final bool drawSurfaceAboveChild;
  final EdgeInsets padding;

  _NeumorphicContainer({
    Key key,
    @required this.child,
    @required this.padding,
    @required this.margin,
    @required this.duration,
    @required this.style,
    @required this.drawSurfaceAboveChild,
    @required this.boxShape,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    //print("widget.padding : ${widget.padding}");
    return AnimatedContainer(
        margin: this.margin,
        duration: this.duration,
        child: NeumorphicBoxShapeClipper(
          shape: this.boxShape,
          child: Padding(
            padding: this.padding,
            child: this.child,
          ),
        ),
        foregroundDecoration: NeumorphicForegroundDecoration(
          splitBackgroundForeground: this.drawSurfaceAboveChild,
          style: this.style,
          shape: this.boxShape,
        ),
        decoration: NeumorphicBoxDecoration(
          splitBackgroundForeground: this.drawSurfaceAboveChild,
          style: this.style,
          shape: this.boxShape,
        ));
  }
}
