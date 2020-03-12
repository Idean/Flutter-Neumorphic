import 'package:flutter/widgets.dart';

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

class _NeumorphicSwitchState extends State<NeumorphicSwitch>
    with SingleTickerProviderStateMixin {
  Animation<Alignment> animation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(duration: widget.duration, vsync: this);
    animation = Tween<Alignment>(
            begin: Alignment.centerLeft, end: Alignment.centerRight)
        .animate(controller);
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
            splitBackgroundForeground: false,
            boxShape: NeumorphicBoxShape.stadium(),
            style: NeumorphicStyle(
                depth: _getTrackDepth(theme.depth),
                shape: NeumorphicShape.flat,
                color: _getTrackColor(theme)),
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

  double _getTrackDepth(double themeDepth) {
    //force negative to have emboss
    double depth = -1 * (widget.style.trackDepth ?? themeDepth).abs();
    depth =
        depth.clamp(Neumorphic.MIN_DEPTH, NeumorphicSwitch.MIN_EMBOSS_DEPTH);
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
      {Key key,
      Animation<Alignment> animation,
      this.thumbColor,
      this.shape,
      this.depth})
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
          boxShape: NeumorphicBoxShape.circle(),
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
