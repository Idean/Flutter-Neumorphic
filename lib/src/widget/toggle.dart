import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import '../neumorphic_box_shape.dart';
import '../theme/neumorphic_theme.dart';
import 'container.dart';

class NeumorphicToggleStyle {
  final double? depth;
  final bool? disableDepth;
  final BorderRadius borderRadius;
  final bool animateOpacity;
  final Color? backgroundColor;
  final NeumorphicBorder border;
  final LightSource? lightSource;

  const NeumorphicToggleStyle({
    this.depth,
    this.animateOpacity = true,
    this.backgroundColor,
    this.lightSource,
    this.borderRadius = const BorderRadius.all(Radius.circular(12)),
    this.disableDepth,
    this.border = const NeumorphicBorder.none(),
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NeumorphicToggleStyle &&
          runtimeType == other.runtimeType &&
          depth == other.depth &&
          border == other.border &&
          backgroundColor == other.backgroundColor &&
          lightSource == other.lightSource &&
          disableDepth == other.disableDepth &&
          borderRadius == other.borderRadius &&
          animateOpacity == other.animateOpacity;

  @override
  int get hashCode =>
      depth.hashCode ^
      backgroundColor.hashCode ^
      lightSource.hashCode ^
      border.hashCode ^
      disableDepth.hashCode ^
      borderRadius.hashCode ^
      animateOpacity.hashCode;
}

/// Direct child of NeumorphicToggle
/// Contains two widgets : background & foreground
///
/// The thumb is displayed between background & foreground
///
/// Expanded(
///  child: NeumorphicToggle(
///    height: 50,
///    selectedIndex: _selectedIndex,
///    displayForegroundOnlyIfSelected: true,
///    children: [
///      ToggleElement(
///        background: Center(child: Text("This week", style: TextStyle(fontWeight: FontWeight.w500),)),
///        foreground: Center(child: Text("This week", style: TextStyle(fontWeight: FontWeight.w700),)),
///      ),
///      ToggleElement(
///        background: Center(child: Text("This month", style: TextStyle(fontWeight: FontWeight.w500),)),
///        foreground: Center(child: Text("This month", style: TextStyle(fontWeight: FontWeight.w700),)),
///      ),
///      ToggleElement(
///        background: Center(child: Text("This year", style: TextStyle(fontWeight: FontWeight.w500),)),
///        foreground: Center(child: Text("This year", style: TextStyle(fontWeight: FontWeight.w700),)),
///      )
///    ],
///    thumb: Neumorphic(
///      boxShape: NeumorphicBoxShape.roundRect(borderRadius: BorderRadius.all(Radius.circular(12))),
///    ),
///    onChanged: (value) {
///      setState(() {
///        _selectedIndex = value;
///        print("_firstSelected: $_selectedIndex");
///      });
///    },
///  ),
///),
class ToggleElement {
  final Widget? background;
  final Widget? foreground;

  ToggleElement({
    this.background,
    this.foreground,
  });
}

///
/// Switch with custom thumb (defined with list of ToggleElements)
///
/// does not save the state
///   - notifies a `ValueChanged<int>` : onChanged
///   - need a `selectedIndex` parameter
///oggle
/// Expanded(
///  child: NeumorphicToggle(
///    height: 50,
///    selectedIndex: _selectedIndex,
///    displayForegroundOnlyIfSelected: true,
///    children: [
///      ToggleElement(
///        background: Center(child: Text("This week", style: TextStyle(fontWeight: FontWeight.w500),)),
///        foreground: Center(child: Text("This week", style: TextStyle(fontWeight: FontWeight.w700),)),
///      ),
///      ToggleElement(
///        background: Center(child: Text("This month", style: TextStyle(fontWeight: FontWeight.w500),)),
///        foreground: Center(child: Text("This month", style: TextStyle(fontWeight: FontWeight.w700),)),
///      ),
///      ToggleElement(
///        background: Center(child: Text("This year", style: TextStyle(fontWeight: FontWeight.w500),)),
///        foreground: Center(child: Text("This year", style: TextStyle(fontWeight: FontWeight.w700),)),
///      )
///    ],
///    thumb: Neumorphic(
///      boxShape: NeumorphicBoxShape.roundRect(borderRadius: BorderRadius.all(Radius.circular(12))),
///    ),
///    onChanged: (value) {
///      setState(() {
///        _selectedIndex = value;
///        print("_firstSelected: $_selectedIndex");
///      });
///    },
///  ),
///),
@immutable
class NeumorphicToggle extends StatelessWidget {
  static const MIN_EMBOSS_DEPTH = -1.0;

  final EdgeInsets padding;

  final List<ToggleElement> children;
  final Widget thumb;

  final int selectedIndex;
  final ValueChanged<int>? onChanged;
  final Function(int)? onAnimationChangedFinished;

  final NeumorphicToggleStyle? style;
  final double height;
  final double? width;
  final Duration duration;
  final bool isEnabled;

  final Curve movingCurve;

  final Curve alphaAnimationCurve;
  final bool displayForegroundOnlyIfSelected;

  const NeumorphicToggle({
    this.style = const NeumorphicToggleStyle(),
    Key? key,
    required this.children,
    required this.thumb,
    this.padding = const EdgeInsets.all(2),
    this.duration = const Duration(milliseconds: 200),
    this.selectedIndex = 0,
    this.alphaAnimationCurve = Curves.linear,
    this.movingCurve = Curves.linear,
    this.onAnimationChangedFinished,
    this.onChanged,
    this.height = 40,
    this.width,
    this.isEnabled = true,
    this.displayForegroundOnlyIfSelected = true,
  }) : super(key: key);

  Widget _buildStack(BuildContext context) {
    return Stack(
      children: [
        _background(context),
        Row(
          mainAxisSize: MainAxisSize.max,
          children: _generateBackgrounds(),
        ),
        AnimatedAlign(
          curve: this.movingCurve,
          onEnd: () {
            if (onAnimationChangedFinished != null) {
              onAnimationChangedFinished!(this.selectedIndex);
            }
          },
          alignment: _alignment(),
          duration: this.duration,
          child: FractionallySizedBox(
            widthFactor: 1 / this.children.length,
            heightFactor: 1,
            child: Neumorphic(
              style: NeumorphicStyle(
                boxShape: NeumorphicBoxShape.roundRect(
                    this.style?.borderRadius ??
                        BorderRadius.all(Radius.circular(12))),
              ),
              margin: this.padding,
              child: this.thumb,
            ),
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          children: _generateForegrounds(),
        ),
      ],
    );
  }

  List<Widget> _generateBackgrounds() {
    final List<Widget> widgets = [];
    for (int i = 0; i < this.children.length; ++i) {
      widgets.add(_backgroundAtIndex(i));
    }
    return widgets;
  }

  List<Widget> _generateForegrounds() {
    final List<Widget> widgets = [];
    for (int i = 0; i < this.children.length; ++i) {
      widgets.add(_foregroundAtIndex(i));
    }
    return widgets;
  }

  Alignment _alignment() {
    double percentX = selectedIndex / (this.children.length - 1);
    double aligmentX = -1.0 + (2.0 * percentX);
    return Alignment(aligmentX, 0.0);
  }

  Widget _backgroundAtIndex(int index) {
    return Expanded(
        flex: 1, child: this.children[index].background ?? SizedBox.expand());
  }

  Widget _foregroundAtIndex(int index) {
    Widget? child = (!this.displayForegroundOnlyIfSelected) ||
            (this.displayForegroundOnlyIfSelected &&
                this.selectedIndex == index)
        ? this.children[index].foreground
        : SizedBox.expand();
    //wrap with opacity animation
    if (style != null && style!.animateOpacity) {
      child = AnimatedOpacity(
        curve: this.alphaAnimationCurve,
        opacity: this.selectedIndex == index ? 1 : 0,
        duration: this.duration,
        child: child,
      );
    }
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
      style: NeumorphicStyle(
          boxShape: NeumorphicBoxShape.roundRect(this.style?.borderRadius ??
              BorderRadius.all(Radius.circular(12))),
          color: this.style?.backgroundColor,
          disableDepth: this.style?.disableDepth,
          depth: _getTrackDepth(context),
          shape: NeumorphicShape.flat,
          border: this.style?.border ?? NeumorphicBorder.none(),
          lightSource: this.style?.lightSource ??
              NeumorphicTheme.currentTheme(context).lightSource),
      child: SizedBox.expand(),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (this.width != null) {
      return SizedBox(
        height: this.height,
        width: this.width,
        child: _buildStack(context),
      );
    } else {
      return FractionallySizedBox(
        widthFactor: 1.0,
        child: SizedBox(
          height: this.height,
          child: _buildStack(context),
        ),
      );
    }
  }

  double _getTrackDepth(BuildContext context) {
    final NeumorphicThemeData theme = NeumorphicTheme.currentTheme(context);

    //force negative to have emboss
    final double depth = -1 * (this.style?.depth ?? theme.depth).abs();
    return depth.clamp(Neumorphic.MIN_DEPTH, NeumorphicToggle.MIN_EMBOSS_DEPTH);
  }

  void _notifyOnChange(int newValue) {
    if (this.onChanged != null) {
      this.onChanged!(newValue);
    }
  }
}
