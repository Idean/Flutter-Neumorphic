import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../NeumorphicBoxShape.dart';
import '../theme/neumorphic_theme.dart';
import 'animation/animated_scale.dart';
import 'container.dart';

typedef void NeumorphicButtonClickListener();

/// A Neumorphic Button
///
/// When pressed, it will fire a call to its [NeumorphicButtonClickListener] click parameter
/// The animation starts from style.depth (or theme.depth is not defined in the style)
/// @see [NeumorphicStyle]
///
/// And finished to `minDistance`, in [duration] (time)
///
/// You can force the pressed state using [pressed]
/// - true : forced as pressed
/// - false : forced as unpressed
/// - null : can be pressed by user
///
/// It takes a [padding], default EdgeInsets.symmetric(horizontal: 8, vertical: 4)`
///
/// It takes a [NeumorphicStyle] @see [Neumorphi]
///
/// ```
///  NeumorphicButton(
///          onClick: () {
///            setState(() {
///               ...
///            });
///          },
///          boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
///          style: NeumorphicStyle(
///            shape: NeumorphicShape.flat,
///          ),
///          child: ...
///  )
/// ```
///
@immutable
class NeumorphicButton extends StatefulWidget {
  static const double PRESSED_SCALE = 0.98;
  static const double UNPRESSED_SCALE = 1.0;

  final Widget child;
  final NeumorphicStyle style;
  //inal Color accent;
  final double minDistance;
  final NeumorphicBoxShape boxShape;
  final EdgeInsets padding;
  final bool pressed; //null, true, false
  final Duration duration;
  final NeumorphicButtonClickListener onClick;
  final bool splitBackgroundForeground;

  const NeumorphicButton({
    Key key,
    this.padding = const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    this.child,
    this.splitBackgroundForeground = true,
    this.pressed, //true/false if you want to change the state of the button
    this.boxShape,
    this.duration = Neumorphic.DEFAULT_DURATION,
    //this.accent,
    this.onClick,
    this.minDistance = 0,
    this.style = const NeumorphicStyle(),
  }) : super(key: key);

  @override
  _NeumorphicButtonState createState() => _NeumorphicButtonState();
}

class _NeumorphicButtonState extends State<NeumorphicButton> {
  NeumorphicStyle initialStyle;

  double depth;
  bool pressed = false; //overwrite widget.pressed when click for animation

  void updateInitialStyle() {
    if (widget.style != initialStyle) {
      setState(() {
        this.initialStyle = widget.style;
        depth = widget.style.depth;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    updateInitialStyle();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    updateInitialStyle();
  }

  @override
  void didUpdateWidget(NeumorphicButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    updateInitialStyle();
  }

  Future<void> _handlePress() async {
    hasFinishedAnimationDown = false;
    setState(() {
      pressed = true;
      depth = widget.minDistance;
    });

    await Future.delayed(widget.duration); //wait until animation finished
    hasFinishedAnimationDown = true;

    //haptic vibration
    HapticFeedback.lightImpact();

    if (widget.onClick != null) {
      widget.onClick();
    }

    _resetIfTapUp();
  }

  //used to stay pressed if no tap up
  void _resetIfTapUp() {
    if (hasFinishedAnimationDown == true && hasTapUp == true) {
      setState(() {
        pressed = false;
        depth = initialStyle.depth;

        hasFinishedAnimationDown = false;
        hasTapUp = false;
      });
    }
  }

  bool get clickable {
    return widget.onClick != null;
  }

  bool hasFinishedAnimationDown = false;
  bool hasTapUp = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (detail) {
        if (clickable && !pressed) {
          _handlePress();
        }
      },
      onTapUp: (details) {
        hasTapUp = true;
        _resetIfTapUp();
      },
      onTapCancel: () {
        hasTapUp = true;
        _resetIfTapUp();
      },
      child: AnimatedScale(
        scale: _getScale(),
        child: Neumorphic(
          splitBackgroundForeground: widget.splitBackgroundForeground,
          duration: widget.duration,
          padding: widget.padding,
          boxShape: widget.boxShape,
          style: initialStyle.copyWith(depth: depth),
          child: widget.child,
        ),
      ),
    );
  }

  double _getScale() {
    if (widget.pressed != null) {
      //defined by the widget that use it
      return widget.pressed
          ? NeumorphicButton.PRESSED_SCALE
          : NeumorphicButton.UNPRESSED_SCALE;
    } else {
      return this.pressed
          ? NeumorphicButton.PRESSED_SCALE
          : NeumorphicButton.UNPRESSED_SCALE;
    }
  }
}
