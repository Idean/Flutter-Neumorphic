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
class NeumorphicSwitch extends StatelessWidget {
  static const MIN_EMBOSS_DEPTH = -1.0;

  final bool value;
  final ValueChanged<bool> onChanged;
  final NeumorphicSwitchStyle style;
  final double height;
  final Duration duration;
  final Curve curve;
  final bool isEnabled;

  const NeumorphicSwitch({
    this.style = const NeumorphicSwitchStyle(),
    Key key,
    this.curve = Neumorphic.DEFAULT_CURVE,
    this.duration = const Duration(milliseconds: 200),
    this.value = false,
    this.onChanged,
    this.height = 40,
    this.isEnabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final NeumorphicThemeData theme = NeumorphicTheme.currentTheme(context);
    return SizedBox(
      height: this.height,
      child: AspectRatio(
        aspectRatio: 2 / 1,
        child: GestureDetector(
          onTap: () {
            // animation breaking prevention
            if (!this.isEnabled) {
              return;
            }
            if (this.onChanged != null) {
              this.onChanged(!this.value);
            }
          },
          child: Neumorphic(
            drawSurfaceAboveChild: false,
            boxShape: NeumorphicBoxShape.stadium(),
            style: NeumorphicStyle(
              disableDepth: this.style.disableDepth,
              depth: _getTrackDepth(theme.depth),
              shape: NeumorphicShape.flat,
              color: _getTrackColor(theme),
            ),
            child: AnimatedScale(
              scale: this.isEnabled ? 1 : 0,
              child: AnimatedThumb(
                curve: this.curve,
                disableDepth: this.style.disableDepth,
                depth: this._thumbDepth,
                duration: this.duration,
                alignment: this._alignment,
                shape: _getThumbShape,
                thumbColor: _getThumbColor(theme),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Alignment get _alignment {
    if (this.value) {
      return Alignment.centerRight;
    } else {
      return Alignment.centerLeft;
    }
  }

  double get _thumbDepth {
    if (!this.isEnabled) {
      return 0;
    } else
      return this.style.thumbDepth;
  }

  NeumorphicShape get _getThumbShape {
    return this.style.thumbShape ?? NeumorphicShape.flat;
  }

  double _getTrackDepth(double themeDepth) {
    //force negative to have emboss
    final double depth = -1 * (this.style.trackDepth ?? themeDepth).abs();
    return depth.clamp(Neumorphic.MIN_DEPTH, NeumorphicSwitch.MIN_EMBOSS_DEPTH);
  }

  Color _getTrackColor(NeumorphicThemeData theme) {
    return this.value == true
        ? this.style.activeTrackColor ?? theme.accentColor
        : this.style.inactiveTrackColor ?? theme.baseColor;
  }

  Color _getThumbColor(NeumorphicThemeData theme) {
    Color color = this.value == true
        ? this.style.activeThumbColor
        : this.style.inactiveThumbColor;
    return color ?? theme.baseColor;
  }
}

class AnimatedThumb extends StatelessWidget {
  final Color thumbColor;
  final Alignment alignment;
  final Duration duration;
  final NeumorphicShape shape;
  final double depth;
  final Curve curve;
  final bool disableDepth;

  AnimatedThumb({
    Key key,
    this.thumbColor,
    this.alignment,
    this.duration,
    this.shape,
    this.disableDepth,
    this.depth,
    this.curve,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // This Container is actually the inner track containing the thumb
    return AnimatedAlign(
      curve: this.curve,
      alignment: this.alignment,
      duration: this.duration,
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
