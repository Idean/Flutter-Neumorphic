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
  final double thumbDepth;

  const NeumorphicSwitchStyle({
    this.trackDepth,
    this.thumbShape,
    this.activeTrackColor,
    this.inactiveTrackColor,
    this.activeThumbColor,
    this.inactiveThumbColor,
    this.thumbDepth,
  });
}

class NeumorphicSwitch extends StatefulWidget {

  static const MIN_EMBOSS_DEPTH = -1.0;

  final bool value;
  final ValueChanged<bool> onChanged;
  final NeumorphicSwitchStyle style;
  final double height;
  final Duration duration;

  const NeumorphicSwitch({
    this.style,
    Key key,
    this.duration = const Duration(milliseconds: 200),
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
        duration: widget.duration, vsync: this);
    animation = Tween<Alignment>(begin: Alignment.centerLeft, end: Alignment.centerRight)
        .animate(controller);
  }

  @override
  Widget build(BuildContext context) {
    final NeumorphicThemeData theme = NeumorphicTheme.getCurrentTheme(context);
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
            accent: _getTrackColor(theme),
            shape: NeumorphicBoxShape.stadium(),
            style: NeumorphicStyle(
                depth: _getTrackDepth(theme.depth),
                shape: NeumorphicShape.flat,
            ),
            child: AnimatedThumb(
              depth: widget.style.thumbDepth,
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

  double _getTrackDepth(double themeDepth){
    //force negative to have emboss
    double depth =  -1 * (widget.style.trackDepth ?? themeDepth).abs();
    depth = depth.clamp(Neumorphic.MIN_DEPTH, NeumorphicSwitch.MIN_EMBOSS_DEPTH);
    return depth;
  }

  Color _getTrackColor(NeumorphicThemeData theme) {
    return widget.value == true
        ? widget.style.activeTrackColor ?? theme.accentColor
        : widget.style.inactiveTrackColor ?? theme.baseColor;
  }

  Color _getThumbColor(NeumorphicThemeData theme) {
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
  final double depth;
  AnimatedThumb(
      {Key key, Animation<Alignment> animation, this.thumbColor, this.shape, this.depth})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<Alignment>;
    // This Container is actually the inner track containing the thumb
    return Align(
      alignment: animation.value,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Neumorphic(
          shape: NeumorphicBoxShape.circle(),
          style: NeumorphicStyle(
            shape: shape,
            depth: this.depth,
            color: thumbColor,
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

}
