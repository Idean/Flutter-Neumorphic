import 'package:flutter/widgets.dart';

import '../NeumorphicBoxShape.dart';
import '../theme_provider.dart';
import 'button.dart';

typedef void NeumorphicRadioListener<T>(T value);

/// A Style used to customize a NeumorphicRadio
///
/// selectedDepth : the depth when checked
/// unselectedDepth : the depth when unchecked (default : theme.depth)
///
/// intensity : a customizable neumorphic intensity for this widget
///
/// boxShape : a customizable neumorphic boxShape for this widget
///   @see NeumorphicBoxShape
///
/// shape : a customizable neumorphic shape for this widget
///   @see NeumorphicShape (concave, convex, flat)
///
class NeumorphicRadioStyle {
  final double selectedDepth;
  final double unselectedDepth;

  final double intensity;
  final NeumorphicBoxShape boxShape;
  final NeumorphicShape shape;

  const NeumorphicRadioStyle(
      {this.selectedDepth,
      this.unselectedDepth,
      this.intensity,
      this.boxShape,
      this.shape});
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
class NeumorphicRadio<T> extends StatefulWidget {
  final Widget child;
  final T value;
  final T groupValue;
  final NeumorphicRadioStyle style;
  final NeumorphicRadioListener<T> onChanged;

  NeumorphicRadio({
    this.child,
    this.style = const NeumorphicRadioStyle(),
    this.value,
    this.groupValue,
    this.onChanged,
  });

  @override
  _NeumorphicRadioState createState() => _NeumorphicRadioState();
}

class _NeumorphicRadioState<T> extends State<NeumorphicRadio<T>> {
  bool get isSelected =>
      widget.value != null && widget.value == widget.groupValue;

  void _onClick() {
    if (widget.value == widget.groupValue) {
      //unselect
      widget.onChanged(null);
    } else {
      widget.onChanged(widget.value);
    }
  }

  @override
  Widget build(BuildContext context) {
    final NeumorphicThemeData theme = NeumorphicTheme.getCurrentTheme(context);

    final double selectedDepth =
        -1 * (widget.style.selectedDepth ?? theme.depth).abs();
    final double unselectedDepth =
        (widget.style.unselectedDepth ?? theme.depth).abs();

    return NeumorphicButton(
      onClick: () {
        _onClick();
      },
      pressed: isSelected,
      minDistance: selectedDepth,
      boxShape: widget.style.boxShape ??
          NeumorphicBoxShape.roundRect(borderRadius: BorderRadius.circular(5)),
      child: widget.child,
      style: NeumorphicStyle(
        intensity: widget.style.intensity,
        depth: isSelected ? selectedDepth : unselectedDepth,
        shape: widget.style.shape ?? NeumorphicShape.flat,
      ),
    );
  }
}
