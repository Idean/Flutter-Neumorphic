import 'package:flutter/widgets.dart';

import '../NeumorphicBoxShape.dart';
import '../decoration/neumorphic_box_decorations.dart';
import '../theme/neumorphic_theme.dart';
import 'border/neumorphic_border.dart';
import 'clipper/NeumorphicBoxShapeClipper.dart';

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

  Widget _generateBorder({NeumorphicStyle style, Widget child}) {
    return _NeumorphicContainer(
      style: style.copyWith(color: border.color),
      padding: EdgeInsets.all(border?.width ?? 0),
      boxShape: boxShape,
      duration: this.duration,
      child: child,
    );
  }

  bool get haveBorder => border != null && border.width > 0;

  @override
  Widget build(BuildContext context) {
    final boxShape = this.boxShape ?? NeumorphicBoxShape.roundRect();
    final theme = NeumorphicTheme.currentTheme(context) ?? neumorphicDefaultTheme;
    final NeumorphicStyle style = (this.style ?? NeumorphicStyle()).copyWithThemeIfNull(theme);

    if (haveBorder) {
      return _generateBorder(
        style: style.copyWith(
          shape: NeumorphicShape.flat,
        ),
        child: _NeumorphicContainer(
          padding: padding,
          boxShape: boxShape,
          duration: this.duration,
          style: style.copyWith(
            lightSource: ((border?.oppositeLightSource ?? false) && style.depth >= 0) ? style.lightSource.invert() : style.lightSource,
            depth: haveBorder ? (border?.depth ?? style.depth) : style.depth ,
          ),
          child: child,
        ),
      );
    } else {
      return _NeumorphicContainer(
        padding: EdgeInsets.zero,
        boxShape: boxShape,
        duration: this.duration,
        style: style,
        child: AnimatedContainer(
          padding: padding,
          duration: this.duration,
          child: child,
        ),
      );
    }
  }
}

class _NeumorphicContainer extends StatefulWidget {
  final NeumorphicStyle style;
  final NeumorphicBoxShape boxShape;
  final Widget child;
  final Duration duration;
  final EdgeInsets padding;

  _NeumorphicContainer({
    Key key,
    @required this.child,
    @required this.padding,
    @required this.duration,
    @required this.style,
    @required this.boxShape,
  }) : super(key: key);

  @override
  createState() => _NeumorphicContainerState();
}

class _NeumorphicContainerState extends State<_NeumorphicContainer> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        duration: widget.duration,
        padding: widget.padding,
        child: NeumorphicBoxShapeClipper(
          shape: widget.boxShape,
          child: widget.child,
        ),
        decoration: NeumorphicBoxDecoration(
          style: widget.style,
          shape: widget.boxShape,
        ));
  }
}
