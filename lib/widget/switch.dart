import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic/NeumorphicBoxShape.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

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
  final double height;

  const NeumorphicSwitch({
    this.style,
    Key key,
    this.value = false,
    this.onChanged,
    this.height = 40,
  }) : super(key: key);

  @override
  _NeumorphicSwitchState createState() => _NeumorphicSwitchState();
}

class _NeumorphicSwitchState extends State<NeumorphicSwitch> with SingleTickerProviderStateMixin {
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
    final NeumorphicTheme theme = NeumorphicThemeProvider.findNeumorphicTheme(context);
    return SizedBox(
      height: widget.height,
      child: AspectRatio(
        aspectRatio: 2 / 1,
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
                depth: (widget.style.trackDepth ?? theme.depth),
                shape: NeumorphicShape.flat,
                baseColor: _getTrackColor(theme)),
            child: AnimatedThumb(
              animation: animation,
              shape: _getThumbShape(),
              thumbColor: _getThumbColor(theme),
            ),
          ),
        ),
      ),
    );
  }

  NeumorphicShape _getThumbShape() {
    return widget.style.thumbShape ?? NeumorphicShape.flat;
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
    return Align(
      alignment: animation.value,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Neumorphic(
          shape: NeumorphicBoxShape.circle(),
          style: NeumorphicStyle(
            shape: shape,
            curveFactor: _getThumbCurveFactor(theme),
            intensity: _getThumbIntensity(theme),
            depth: _getThumbDepth(theme),
            baseColor: thumbColor,
          ),
          child: AspectRatio(
            aspectRatio: 1,
            child: FractionallySizedBox(
              heightFactor: 1,
              child: Container(),
              //width: THUMB_WIDTH,
            ),
          ),
        ),
      ),
    );
  }

  /// Returns the proper curveFactor according to the given shape.
  double _getThumbCurveFactor(NeumorphicTheme theme) {
    if (shape != null) {
      switch (shape) {
        case NeumorphicShape.concave:
          return 3.0;
        default:
          return theme.curveFactor;
      }
    }
    return theme.curveFactor;
  }

  /// Returns the proper depth according to the given shape.
  double _getThumbDepth(NeumorphicTheme theme) {
    if (shape != null) {
      switch (shape) {
        case NeumorphicShape.concave:
        case NeumorphicShape.convex:
        case NeumorphicShape.flat:
          return 4.0;
      }

      return theme.depth;
    }
  }

  /// Returns the proper intensity according to the given shape.
  double _getThumbIntensity(NeumorphicTheme theme) {
    if (shape != null) {
      switch (shape) {
        case NeumorphicShape.concave:
        case NeumorphicShape.convex:
        case NeumorphicShape.flat:
          return 4.0;
      }

      return theme.intensity;
    }
  }
}
