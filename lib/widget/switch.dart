import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic/NeumorphicBoxShape.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

// Constants below are for easy scaling tests.
// Can be removed later.
const double SCALE = 1.0;
const double TRACK_WIDTH = 90 * SCALE;
const double TRACK_HEIGHT = 45 * SCALE;
const double THUMB_WIDTH = 31.5 * SCALE;
const double THUMB_HEIGHT = 31.5 * SCALE;
const double THUMB_CONTAINER_WIDTH = 90 * SCALE;
const double THUMB_CONTAINER_HEIGHT = 36 * SCALE;

class NeumorphicSwitchStyle {
  final double depth;
  final Color activeTrackColor;
  final Color inactiveTrackColor;
  final Color activeThumbColor;
  final Color inactiveThumbColor;

  const NeumorphicSwitchStyle(
      {this.depth = -3,
      this.activeTrackColor = NeumorphicColors.accent,
      this.inactiveTrackColor = NeumorphicColors.background,
      this.activeThumbColor = NeumorphicColors.background,
      this.inactiveThumbColor = NeumorphicColors.background});
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
    final trackColor = widget.value == false
        ? widget.style.inactiveTrackColor
        : widget.style.activeTrackColor;
    return SizedBox(
      height: TRACK_HEIGHT,
      width: TRACK_WIDTH,
      child: Neumorphic(
        shape: NeumorphicBoxShape.stadium(),
        style: NeumorphicStyle(
            depth: widget.style.depth * SCALE,
            shape: NeumorphicShape.emboss,
            baseColor: trackColor),
        child: ClipRRect(
          clipBehavior: Clip.antiAlias,
          borderRadius: NeumorphicBoxShape.stadium().borderRadius,
          child: GestureDetector(
            onTap: () {
              // animation breaking prevention
              if (controller.isAnimating) {
                return;
              }
              if (widget.value == false) {
                controller.forward();
                widget.onChanged(true);
              } else {
                controller.reverse();
                widget.onChanged(false);
              }
            },
            child: AnimatedThumb(
              animation: animation,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class AnimatedThumb extends AnimatedWidget {
  AnimatedThumb({Key key, Animation<Alignment> animation})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<Alignment>;
    return Container(
      height: THUMB_CONTAINER_HEIGHT,
      width: THUMB_CONTAINER_WIDTH,
      child: Align(
        alignment: animation.value,
        child: ClipRRect(
          clipBehavior: Clip.antiAlias,
          borderRadius: NeumorphicBoxShape.stadium().borderRadius,
          child: Neumorphic(
            shape: NeumorphicBoxShape.circle(),
            style: NeumorphicStyle(
                shape: NeumorphicShape.emboss,
                depth: -2 * SCALE,
                baseColor: NeumorphicColors.background),
            child: SizedBox(
              height: THUMB_HEIGHT,
              width: THUMB_WIDTH,
            ),
          ),
        ),
      ),
    );
  }
}
