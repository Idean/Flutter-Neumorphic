import 'package:flutter/widgets.dart';

import '../NeumorphicBoxShape.dart';
import '../theme/neumorphic_theme.dart';
import 'button.dart';

typedef void NeumorphicRadioListener<T>(T value);

/// A Style used to customize a [NeumorphicRadio]
///
/// [selectedDepth] : the depth when checked
/// [unselectedDepth] : the depth when unchecked (default : theme.depth)
///
/// [intensity] : a customizable neumorphic intensity for this widget
///
/// [boxShape] : a customizable neumorphic boxShape for this widget
///   @see [NeumorphicBoxShape]
///
/// [shape] : a customizable neumorphic shape for this widget
///   @see [NeumorphicShape] (concave, convex, flat)
///
class NeumorphicRadioStyle {
  final double selectedDepth;
  final double unselectedDepth;
  final bool disableDepth;

  final double intensity;
  final NeumorphicShape shape;

  const NeumorphicRadioStyle({
    this.selectedDepth,
    this.unselectedDepth,
    this.disableDepth,
    this.intensity,
    this.shape,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NeumorphicRadioStyle &&
          runtimeType == other.runtimeType &&
          disableDepth == other.disableDepth &&
          selectedDepth == other.selectedDepth &&
          unselectedDepth == other.unselectedDepth &&
          intensity == other.intensity &&
          shape == other.shape;

  @override
  int get hashCode =>
      disableDepth.hashCode ^
      selectedDepth.hashCode ^
      unselectedDepth.hashCode ^
      intensity.hashCode ^
      shape.hashCode;
}

/// A Neumorphic Radio
///
/// It takes a `value` and a `groupValue`
/// if (value == groupValue) => checked
///
/// takes a NeumorphicRadioStyle as `style`
///
/// notifies the parent when user interact with this widget with `onChanged`
///
/// ```
/// int _groupValue;
///
/// Widget _buildRadios() {
///    return Row(
///      children: <Widget>[
///
///        NeumorphicRadio(
///          child: SizedBox(
///            height: 50,
///            width: 50,
///            child: Center(
///              child: Text("1"),
///            ),
///          ),
///          value: 1,
///          groupValue: _groupValue,
///          onChanged: (value) {
///            setState(() {
///              _groupValue = value;
///            });
///          },
///        ),
///
///        NeumorphicRadio(
///          child: SizedBox(
///            height: 50,
///            width: 50,
///            child: Center(
///              child: Text("2"),
///            ),
///          ),
///          value: 2,
///          groupValue: _groupValue,
///          onChanged: (value) {
///            setState(() {
///              _groupValue = value;
///            });
///          },
///        ),
///
///        NeumorphicRadio(
///          child: SizedBox(
///            height: 50,
///            width: 50,
///            child: Center(
///              child: Text("3"),
///            ),
///          ),
///          value: 3,
///          groupValue: _groupValue,
///          onChanged: (value) {
///            setState(() {
///              _groupValue = value;
///            });
///          },
///        ),
///
///      ],
///    );
///  }
/// ```
///
@immutable
class NeumorphicRadio<T> extends StatelessWidget {
  final Widget child;
  final T value;
  final T groupValue;
  final NeumorphicBoxShape boxShape;
  final EdgeInsets padding;
  final NeumorphicRadioStyle style;
  final NeumorphicRadioListener<T> onChanged;
  final bool isEnabled;

  NeumorphicRadio({
    this.child,
    this.style = const NeumorphicRadioStyle(),
    this.value,
    this.boxShape,
    this.padding = EdgeInsets.zero,
    this.groupValue,
    this.onChanged,
    this.isEnabled = true,
  });

  bool get isSelected => this.value != null && this.value == this.groupValue;

  void _onClick() {
    if (this.onChanged != null) {
      if (this.value == this.groupValue) {
        //unselect
        this.onChanged(null);
      } else {
        this.onChanged(this.value);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final NeumorphicThemeData theme = NeumorphicTheme.currentTheme(context);

    final double selectedDepth =
        -1 * (this.style.selectedDepth ?? theme.depth).abs();
    final double unselectedDepth =
        (this.style.unselectedDepth ?? theme.depth).abs();

    double depth = isSelected ? selectedDepth : unselectedDepth;
    if (!this.isEnabled) {
      depth = 0;
    }

    return NeumorphicButton(
      onClick: () {
        _onClick();
      },
      padding: this.padding,
      pressed: isSelected,
      minDistance: selectedDepth,
      boxShape: this.boxShape ??
          NeumorphicBoxShape.roundRect(borderRadius: BorderRadius.circular(5)),
      child: this.child,
      style: NeumorphicStyle(
        disableDepth: this.style.disableDepth,
        intensity: this.style.intensity,
        depth: depth,
        shape: this.style.shape ?? NeumorphicShape.flat,
      ),
    );
  }
}
