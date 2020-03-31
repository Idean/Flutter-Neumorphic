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

  final List<ToggleElement> children;
  final Widget thumb;

  final int selectedIndex;
  final ValueChanged<int> onChanged;

  final NeumorphicToggleStyle style;
  final double height;
  final Duration duration;
  final bool isEnabled;

  final bool displayForegroundOnlyIfSelected;

  const NeumorphicToggle({
    this.style = const NeumorphicToggleStyle(),
    Key key,
    @required this.children,
    @required this.thumb,
    this.padding = const EdgeInsets.all(2),
    this.duration = const Duration(milliseconds: 200),
    this.selectedIndex = 0,
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
            _backgroundAtIndex(0),
            _backgroundAtIndex(1),
          ],
        ),
        AnimatedAlign(
          alignment: _alignment(),
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
            _foregroundAtIndex(0),
            _foregroundAtIndex(1),
          ],
        ),
      ],
    );
  }

  Alignment _alignment() {
    double percentX = selectedIndex / (this.children.length - 1);
    double aligmentX = -1.0 + (2.0 * percentX);
    print("aligmentX: $aligmentX");
    return Alignment(aligmentX, 0.0);
  }

  Widget _backgroundAtIndex(int index) {
    return Expanded(flex: 1, child: this.children[index].background);
  }

  Widget _foregroundAtIndex(int index) {
    Widget child = (!this.displayForegroundOnlyIfSelected) || (this.displayForegroundOnlyIfSelected && this.selectedIndex == index) ? this.children[index].foreground : SizedBox.expand();
    return Expanded(
        flex: 1,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            _notifyOnChange(index);
          },
          child: child,
        ));
  }

  Widget _background(BuildContext context) {
    return Neumorphic(
        boxShape: NeumorphicBoxShape.roundRect(borderRadius: this.style.borderRadius),
        style: NeumorphicStyle(disableDepth: this.style.disableDepth, depth: _getTrackDepth(context), shape: NeumorphicShape.flat),
        child: SizedBox.expand());
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: this.height,
      child: _buildStack(context),
    );
  }

  double _getTrackDepth(BuildContext context) {
    final NeumorphicThemeData theme = NeumorphicTheme.currentTheme(context);

    //force negative to have emboss
    final double depth = -1 * (this.style.depth ?? theme.depth).abs();
    return depth.clamp(Neumorphic.MIN_DEPTH, NeumorphicToggle.MIN_EMBOSS_DEPTH);
  }

  void _notifyOnChange(int newValue) {
    if (this.onChanged != null) {
      this.onChanged(newValue);
    }
  }
}
