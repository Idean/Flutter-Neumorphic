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
  final Duration duration;

  //forces have 2 different widgets if the shape changes
  final Key _circleKey = Key("circle");
  final Key _rectangleKey = Key("rectangle");

  Neumorphic({
    Key key,
    this.child,
    this.duration = const Duration(milliseconds: 100),
    this.style,
    this.accent,
    this.shape,
    this.padding = const EdgeInsets.all(4),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final shape = this.shape ?? NeumorphicBoxShape.roundRect();

    return _NeumorphicStyleAnimator(
        duration: this.duration,
        style: this.style,
        builder: (context, style) {
          //print("$style");
          final decorator = generateNeumorphicDecorator(accent: this.accent, style: style, shape: shape);

          final child = generateNeumorphicChild(
            accent: this.accent,
            style: style,
            shape: this.shape,
            child: this.child,
          );

          return AnimatedContainer(
            key: shape.isCircle ? _circleKey : _rectangleKey,
            duration: this.duration,
            child: child,
            decoration: decorator,
            padding: this.padding,
          );
        });
  }
}

typedef Widget _NeumorphicStyleBuilder(BuildContext context, NeumorphicStyle style);

class _NeumorphicStyleAnimator extends StatefulWidget {
  //final Widget child;
  final NeumorphicStyle style;
  final Duration duration;
  final _NeumorphicStyleBuilder builder;

  _NeumorphicStyleAnimator({@required this.duration, @required this.builder, this.style});

  @override
  _NeumorphicStyleAnimatorState createState() => _NeumorphicStyleAnimatorState();
}

class _NeumorphicStyleAnimatorState extends State<_NeumorphicStyleAnimator> with TickerProviderStateMixin {
  NeumorphicTheme _theme;
  NeumorphicStyle _animatedStyle;

  AnimationController _controller;

  //animated style
  Animation<double> _depthAnim;
  Animation<double> _intensityAnim;
  Animation<double> _curveFactoryAnim;
  Animation<Offset> _lightSourceAnim;
  Animation<Color> _baseColorAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..addListener(() {
        setState(() {
          _animatedStyle = _animatedStyle.copyWith(
            depth: _depthAnim?.value ?? _animatedStyle.depth,
            intensity: _intensityAnim?.value ?? _animatedStyle.intensity,
            curveFactor: _curveFactoryAnim?.value ?? _animatedStyle.curveFactor,
            lightSource: _lightSourceAnim?.value != null ? LightSource(_lightSourceAnim.value.dx, _lightSourceAnim.value.dy) : _animatedStyle.lightSource,
            baseColor: _baseColorAnim?.value != null ? _baseColorAnim.value : _animatedStyle.baseColor,
          );
          //print("animatedStyle: ${_animatedStyle}");
        });
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(_NeumorphicStyleAnimator oldWidget) {
    super.didUpdateWidget(oldWidget);
    updateStyle(_animatedStyle, widget.style);
  }

  void _initStyle() {
    _theme = NeumorphicThemeProvider.of(context) ?? neumorphicDefaultTheme;
    _animatedStyle = (widget.style ?? NeumorphicStyle()).copyWithThemeIfNull(_theme);
  }

  void updateStyle(NeumorphicStyle oldStyle, NeumorphicStyle newStyle) {
    final newTheme = NeumorphicThemeProvider.of(context) ?? neumorphicDefaultTheme;
    if (newTheme != _theme) {
      _theme = newTheme;
    }
    final styleWithTheme = (newStyle ?? NeumorphicStyle()).copyWithThemeIfNull(_theme);
    if (_animatedStyle != styleWithTheme) {
      if (widget.duration == Duration.zero) {
        //don't need to animate

        _animatedStyle = styleWithTheme;
      } else {
        //region animate elements

        //not animated values
        _animatedStyle = _animatedStyle.copyWith(shape: styleWithTheme.shape);

        //animated values
        if (oldStyle.depth != styleWithTheme.depth) {
          _depthAnim = Tween(begin: oldStyle.depth, end: styleWithTheme.depth).animate(_controller);
        }
        if (oldStyle.intensity != styleWithTheme.intensity) {
          _intensityAnim = Tween(begin: oldStyle.intensity, end: styleWithTheme.intensity).animate(_controller);
        }
        if (oldStyle.curveFactor != styleWithTheme.curveFactor) {
          _curveFactoryAnim = Tween(begin: oldStyle.curveFactor, end: styleWithTheme.curveFactor).animate(_controller);
        }
        if (oldStyle.lightSource != styleWithTheme.lightSource) {
          //print("old: ${oldStyle.lightSource.offset}, new: ${styleWithTheme.lightSource.offset}");
          _lightSourceAnim = Tween(begin: oldStyle.lightSource.offset, end: styleWithTheme.lightSource.offset).animate(_controller);
        }
        if (oldStyle.baseColor != styleWithTheme.baseColor) {
          _baseColorAnim = ColorTween(begin: oldStyle.baseColor, end: styleWithTheme.baseColor).animate(_controller);
        }

        //endregion
      }

      //region launch
      _controller.reset();
      _controller.forward();
      //endregion
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_theme == null) {
      _initStyle();
    }
    //print("animatedStyle: ${_animatedStyle}");
    return widget.builder(context, _animatedStyle);
  }
}
