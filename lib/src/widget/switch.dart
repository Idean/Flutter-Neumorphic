import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic/src/widget/animation/animated_scale.dart';

import '../NeumorphicBoxShape.dart';
import '../theme/neumorphic_theme.dart';
import 'container.dart';

/// A style to customize the [NeumorphicSwitch]
///
/// you can define the track : [activeTrackColor], [inactiveTrackColor], [trackDepth]
///
/// you can define the thumb : [activeTrackColor], [inactiveTrackColor], [thumbDepth]
/// and [thumbShape] @see [NeumorphicShape]
///
class NeumorphicSwitchStyle {
  final double trackDepth;
  final Color activeTrackColor;
  final Color inactiveTrackColor;
  final Color activeThumbColor;
  final Color inactiveThumbColor;
  final NeumorphicShape thumbShape;
  final double thumbDepth;
  final bool disableDepth;

  const NeumorphicSwitchStyle({
    this.trackDepth,
    this.thumbShape = NeumorphicShape.concave,
    this.activeTrackColor,
    this.inactiveTrackColor,
    this.activeThumbColor,
    this.inactiveThumbColor,
    this.thumbDepth,
    this.disableDepth,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is NeumorphicSwitchStyle &&
              runtimeType == other.runtimeType &&
              trackDepth == other.trackDepth &&
              activeTrackColor == other.activeTrackColor &&
              inactiveTrackColor == other.inactiveTrackColor &&
              activeThumbColor == other.activeThumbColor &&
              inactiveThumbColor == other.inactiveThumbColor &&
              thumbShape == other.thumbShape &&
              thumbDepth == other.thumbDepth &&
              disableDepth == other.disableDepth;

  @override
  int get hashCode =>
      trackDepth.hashCode ^
      activeTrackColor.hashCode ^
      inactiveTrackColor.hashCode ^
      activeThumbColor.hashCode ^
      inactiveThumbColor.hashCode ^
      thumbShape.hashCode ^
      thumbDepth.hashCode ^
      disableDepth.hashCode;



}

/// Used to toggle the on/off state of a single setting.
///
/// The switch itself does not maintain any state. Instead, when the state of the switch changes, the widget calls the onChanged callback.
/// Most widgets that use a switch will listen for the onChanged callback and rebuild the switch with a new value to update the visual appearance of the switch.
///
/// ```
///  bool _switch1Value = false;
///  bool _switch2Value = false;
///
///  Widget _buildSwitches() {
///    return Row(children: <Widget>[
///
///      NeumorphicSwitch(
///        value: _switch1Value,
///        style: NeumorphicSwitchStyle(
///          thumbShape: NeumorphicShape.concave,
///        ),
///        onChanged: (value) {
///          setState(() {
///            _switch1Value = value;
///          });
///        },
///      ),
///
///      NeumorphicSwitch(
///        value: _switch2Value,
///        style: NeumorphicSwitchStyle(
///          thumbShape: NeumorphicShape.flat,
///        ),
///        onChanged: (value) {
///          setState(() {
///            _switch2Value = value;
///          });
///        },
///      ),
///
///    ]);
///  }
///  ```
///
@immutable
class NeumorphicSwitch extends StatefulWidget {
  static const MIN_EMBOSS_DEPTH = -1.0;

  final bool value;
  final ValueChanged<bool> onChanged;
  final NeumorphicSwitchStyle style;
  final double height;
  final Duration duration;
  final bool isEnabled;

  const NeumorphicSwitch({
    this.style = const NeumorphicSwitchStyle(),
    Key key,
    this.duration = const Duration(milliseconds: 200),
    this.value = false,
    this.onChanged,
    this.height = 40,
    this.isEnabled = true,
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
    final defaultValue = widget.value ? 1.0 : 0.0;
    controller = AnimationController(
        duration: widget.duration, value: defaultValue, vsync: this);
    animation = Tween<Alignment>(
            begin: Alignment.centerLeft, end: Alignment.centerRight)
        .animate(controller);
  }

  @override
  void didUpdateWidget(NeumorphicSwitch oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      if (widget.value) {
        controller.forward();
      } else {
        controller.reverse();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final NeumorphicThemeData theme = NeumorphicTheme.currentTheme(context);
    return SizedBox(
      height: widget.height,
      child: AspectRatio(
        aspectRatio: 2 / 1,
        child: GestureDetector(
          onTap: () {
            // animation breaking prevention
            if (controller.isAnimating || !widget.isEnabled) {
              return;
            }
            _notifyOnChange(!widget.value);
          },
          child: Neumorphic(
            drawSurfaceAboveChild: false,
            boxShape: NeumorphicBoxShape.stadium(),
            style: NeumorphicStyle(
                disableDepth: widget.style.disableDepth,
                depth: _getTrackDepth(theme.depth),
                shape: NeumorphicShape.flat,
                color: _getTrackColor(theme)),
            child: AnimatedScale(
              scale: widget.isEnabled ? 1 : 0,
              child: AnimatedThumb(
                disableDepth: this.widget.style.disableDepth,
                depth: _thumbDepth(),
                animation: animation,
                shape: _getThumbShape(),
                thumbColor: _getThumbColor(theme),
              ),
            ),
          ),
        ),
      ),
    );
  }

  double _thumbDepth() {
    if (!widget.isEnabled) {
      return 0;
    } else
      return widget.style.thumbDepth;
  }

  NeumorphicShape _getThumbShape() {
    return widget.style.thumbShape ?? NeumorphicShape.flat;
  }

  double _getTrackDepth(double themeDepth) {
    //force negative to have emboss
    final double depth = -1 * (widget.style.trackDepth ?? themeDepth).abs();
    return depth.clamp(Neumorphic.MIN_DEPTH, NeumorphicSwitch.MIN_EMBOSS_DEPTH);
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
  final bool disableDepth;

  AnimatedThumb({
    Key key,
    Animation<Alignment> animation,
    this.thumbColor,
    this.shape,
    this.disableDepth,
    this.depth
  }) : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<Alignment>;
    // This Container is actually the inner track containing the thumb
    return Align(
      alignment: animation.value,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Neumorphic(
          boxShape: NeumorphicBoxShape.circle(),
          style: NeumorphicStyle(
            disableDepth: this.disableDepth,
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
