import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic/src/widget/clipper/CircleClipper.dart';

import '../NeumorphicBoxShape.dart';
import '../decoration/neumorphic_box_decorations.dart';
import '../theme/neumorphic_theme.dart';
import 'border/neumorphic_border.dart';

export '../NeumorphicBoxShape.dart';
export '../decoration/neumorphic_box_decorations.dart';
export '../theme/neumorphic_theme.dart';
export 'border/neumorphic_border.dart';

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

  //final Color accent;
  final NeumorphicStyle style;
  final EdgeInsets padding;
  final NeumorphicBoxShape boxShape;
  final Duration duration;

  final NeumorphicBorder border;

  //forces have 2 different widgets if the shape changes
  final Key _circleKey = Key("circle");
  final Key _rectangleKey = Key("rectangle");

  Neumorphic({
    Key key,
    this.child,
    this.duration = Neumorphic.DEFAULT_DURATION,
    this.style,
    this.border,
    //this.accent,
    this.boxShape,
    this.padding = const EdgeInsets.all(0),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final shape = this.boxShape ?? NeumorphicBoxShape.roundRect();
    final theme = NeumorphicTheme.currentTheme(context) ?? neumorphicDefaultTheme;
    NeumorphicStyle style = (this.style ?? NeumorphicStyle()).copyWithThemeIfNull(theme);

    Widget widgetChild = this.child;
    if (border != null) {
      //if have a border, add a neumorphic with same boxshape
      //and opposite lightsource
      widgetChild = Padding(
        padding: EdgeInsets.all(border.width ?? 0),
        child: Neumorphic(
          padding: this.padding,
          boxShape: this.boxShape,
          style: style.copyWith(
            depth: border.depth ?? style.depth,
            lightSource: border.oppositeLightSource ? style.lightSource.invert() : style.lightSource,
          ),
          child: this.child,
        ),
      );

      //and used style have border color
      style = style.copyWith(color: border.color);
    } else {
      widgetChild = Padding(
        padding: this.padding,
        child: widgetChild,
      );
    }

    return AnimatedContainer(
        key: shape.isCircle ? _circleKey : _rectangleKey,
        duration: this.duration,
        child: shape.isCircle ? ClipPath(clipper: CircleClipper(), child: widgetChild) : ClipRRect(borderRadius: shape.borderRadius, child: widgetChild),
        decoration: NeumorphicBoxDecoration(
          style: style,
          shape: shape,
        ));
  }
}
