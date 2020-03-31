import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import '../NeumorphicBoxShape.dart';
import '../theme/neumorphic_theme.dart';
import 'container.dart';

class NeumorphicToggleStyle {
  final double depth;
  final bool disableDepth;
  final BorderRadius borderRadius;

  const NeumorphicToggleStyle({
    this.depth,
    this.borderRadius = const BorderRadius.all(Radius.circular(12)),
    this.disableDepth,
  });

  @override
  bool operator ==(Object other) => identical(this, other) || other is NeumorphicToggleStyle && runtimeType == other.runtimeType && depth == other.depth && disableDepth == other.disableDepth;

  @override
  int get hashCode => depth.hashCode ^ disableDepth.hashCode;
}

class ToggleElement {
  final Widget background;
  final Widget foreground;

  ToggleElement({
    this.background = const SizedBox(),
    this.foreground = const SizedBox(),
  });
}

@immutable
class NeumorphicToggle extends StatelessWidget {
  static const MIN_EMBOSS_DEPTH = -1.0;

  final EdgeInsets padding;

  final ToggleElement first;
  final ToggleElement second;
  final Widget thumb;

  final bool firstSelected;
  final ValueChanged<bool> onChanged;

  final NeumorphicToggleStyle style;
  final double height;
  final Duration duration;
  final bool isEnabled;

  final bool displayForegroundOnlyIfSelected;

  const NeumorphicToggle({
    this.style = const NeumorphicToggleStyle(),
    Key key,
    @required this.first,
    @required this.second,
    @required this.thumb,
    this.padding = const EdgeInsets.all(2),
    this.duration = const Duration(milliseconds: 200),
    this.firstSelected = true,
    this.onChanged,
    this.height = 40,
    this.isEnabled = true,
    this.displayForegroundOnlyIfSelected = true,
  }) : super(key: key);


  Widget _buildStack(BuildContext context) {
    return Stack(
      children: [
        _background(context),
        Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(flex: 1, child: this.first.background),
            Expanded(flex: 1, child: this.second.background),
          ],
        ),
        AnimatedAlign(
          alignment: this.firstSelected ? Alignment.centerLeft : Alignment.centerRight,
          duration: this.duration,
          child: FractionallySizedBox(
            widthFactor: 0.5,
            heightFactor: 1,
            child: Neumorphic(
              margin: this.padding,
              boxShape: NeumorphicBoxShape.roundRect(borderRadius: this.style.borderRadius),
              child: this.thumb,
            ),
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(flex: 1, child: (!this.displayForegroundOnlyIfSelected) || (this.displayForegroundOnlyIfSelected && this.firstSelected) ? this.first.foreground : SizedBox()),
            Expanded(flex: 1, child: (!this.displayForegroundOnlyIfSelected) || (this.displayForegroundOnlyIfSelected && !this.firstSelected)? this.second.foreground : SizedBox()),
          ],
        ),
      ],
    );
  }



  Widget _background(BuildContext context) {
    return Neumorphic(
        boxShape: NeumorphicBoxShape.roundRect(borderRadius: this.style.borderRadius),
        style: NeumorphicStyle(disableDepth: this.style.disableDepth, depth: _getTrackDepth(context), shape: NeumorphicShape.flat),
        child: SizedBox.expand()
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: this.height,
      child: GestureDetector(
        onTap: () {
          _notifyOnChange(!this.firstSelected);
        },
        child: _buildStack(context),
      ),
    );
  }

  double _getTrackDepth(BuildContext context) {
    final NeumorphicThemeData theme = NeumorphicTheme.currentTheme(context);

    //force negative to have emboss
    final double depth = -1 * (this.style.depth ?? theme.depth).abs();
    return depth.clamp(Neumorphic.MIN_DEPTH, NeumorphicToggle.MIN_EMBOSS_DEPTH);
  }

  void _notifyOnChange(bool newValue) {
    if (this.onChanged != null) {
      this.onChanged(newValue);
    }
  }
}