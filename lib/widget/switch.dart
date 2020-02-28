import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic/NeumorphicBoxShape.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

// Constants below are for easy scaling tests.
// Can be removed later.
const double SCALE = 1.0;
const double TRACK_WIDTH = 90 * SCALE;
const double TRACK_HEIGHT = 52 * SCALE;
const double THUMB_WIDTH = 30 * SCALE;
const double THUMB_HEIGHT = 30 * SCALE;
const double THUMB_CONTAINER_WIDTH = 90 * SCALE;
const double THUMB_CONTAINER_HEIGHT = 37 * SCALE;

class NeumorphicSwitchStyle {
  final double trackDepth;
  final Color activeTrackColor;
  final Color inactiveTrackColor;
  final Color activeThumbColor;
  final Color inactiveThumbColor;
  final NeumorphicShape thumbShape;

  const NeumorphicSwitchStyle({
    this.trackDepth,
    this.thumbShape,
    this.activeTrackColor,
    this.inactiveTrackColor,
    this.activeThumbColor,
    this.inactiveThumbColor,
  });
}

class NeumorphicSwitch extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final NeumorphicSwitchStyle style;

  const NeumorphicSwitch({
    this.style,
    Key key,
    this.value = false,
    this.onChanged,
  }) : super(key: key);

  @override
  _NeumorphicSwitchState createState() => _NeumorphicSwitchState();
}

class _NeumorphicSwitchState extends State<NeumorphicSwitch>
    with SingleTickerProviderStateMixin {
  Animation<Alignment> animation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 200), vsync: this);
    animation = Tween<Alignment>(
            begin: Alignment.centerLeft, end: Alignment.centerRight)
        .animate(controller);
  }

  @override
  Widget build(BuildContext context) {
    final NeumorphicTheme theme =
        NeumorphicThemeProvider.findNeumorphicTheme(context);
    return SizedBox(
      height: TRACK_HEIGHT,
      width: TRACK_WIDTH,
      child: GestureDetector(
        onTap: () {
          // animation breaking prevention
          if (controller.isAnimating) {
            return;
          }
          if (widget.value == false) {
            controller.forward();
            _notifyOnChange(true);
          } else {
            controller.reverse();
            _notifyOnChange(false);
          }
        },
        child: Neumorphic(
          shape: NeumorphicBoxShape.stadium(),
          style: NeumorphicStyle(
              depth: (widget.style.trackDepth ?? theme.depth) * SCALE,
              shape: NeumorphicShape.emboss,
              baseColor: _getTrackColor(theme)),
          child: AnimatedThumb(
            animation: animation,
            shape: _getThumbShape(),
            thumbColor: _getThumbColor(theme),
          ),
        ),
      ),
    );
  }

  NeumorphicShape _getThumbShape() {
    if (widget.style.thumbShape == null) {
      return NeumorphicShape.flat;
    }
    return widget.style.thumbShape;
  }

  Color _getTrackColor(NeumorphicTheme theme) {
    return widget.value == true
        ? widget.style.activeTrackColor ?? theme.accentColor
        : widget.style.inactiveTrackColor ?? theme.baseColor;
  }

  Color _getThumbColor(NeumorphicTheme theme) {
    Color color = widget.value == true
        ? widget.style.activeThumbColor
        : widget.style.inactiveThumbColor;
    return color ?? theme.baseColor;
  }

  void _notifyOnChange(bool newValue) {
    if (widget.onChanged != null) {
      widget.onChanged(newValue);
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class AnimatedThumb extends AnimatedWidget {
  final Color thumbColor;
  final NeumorphicShape shape;
  AnimatedThumb(
      {Key key, Animation<Alignment> animation, this.thumbColor, this.shape})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<Alignment>;
    final NeumorphicTheme theme =
        NeumorphicThemeProvider.findNeumorphicTheme(context);
    // This Container is actually the inner track containing the thumb
    return Container(
      height: THUMB_CONTAINER_HEIGHT,
      width: THUMB_CONTAINER_WIDTH,
      child: Align(
        alignment: animation.value,
        child: Neumorphic(
          shape: NeumorphicBoxShape.circle(),
          style: NeumorphicStyle(
            shape: shape,
            curveFactor: _getThumbCurveFactor(theme),
            intensity: _getThumbIntensity(theme),
            depth: _getThumbDepth(theme),
            baseColor: thumbColor,
          ),
          child: SizedBox(
            height: THUMB_HEIGHT,
            width: THUMB_WIDTH,
          ),
        ),
      ),
    );
  }

  /// Returns the proper curveFactor according to the given shape.
  double _getThumbCurveFactor(NeumorphicTheme theme) {
    if (shape == null) {
      return theme.curveFactor;
    }
    switch (shape) {
      case NeumorphicShape.concave:
        return 3.0;
      default:
        return theme.curveFactor;
    }
  }

  /// Returns the proper depth according to the given shape.
  double _getThumbDepth(NeumorphicTheme theme) {
    if (shape == null) {
      return theme.depth;
    }
    switch (shape) {
      case NeumorphicShape.concave:
      case NeumorphicShape.convex:
      case NeumorphicShape.flat:
        return 4.0;
      case NeumorphicShape.emboss:
        return -2.0;
      default:
        return theme.depth;
    }
  }

  /// Returns the proper intensity according to the given shape.
  double _getThumbIntensity(NeumorphicTheme theme) {
    if (shape == null) {
      return theme.intensity;
    }
    switch (shape) {
      case NeumorphicShape.concave:
      case NeumorphicShape.convex:
      case NeumorphicShape.flat:
        return 4.0;
      case NeumorphicShape.emboss:
      default:
        return theme.intensity;
    }
  }
}
