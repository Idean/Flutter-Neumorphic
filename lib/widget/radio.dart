import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic/NeumorphicBoxShape.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'button.dart';

typedef void NeumorphicRadioListener<T>(T value);

class NeumorphicRadioStyle {
  final double selectedDepth;
  final double unselectedDepth;

  //TODO add some stylable elements here

  const NeumorphicRadioStyle({
    this.selectedDepth: 3,
    this.unselectedDepth: -5,
  });
}

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
  bool get isSelected => widget.value != null && widget.value == widget.groupValue;

  @override
  Widget build(BuildContext context) {
    return NeumorphicButton(
      onClick: () {
        widget.onChanged(widget.value);
      },
      minDistance: widget.style.selectedDepth,
      shape: NeumorphicBoxShape.roundRect(borderRadius: BorderRadius.circular(5)),
      child: widget.child,
      style: NeumorphicStyle(depth: isSelected ? widget.style.unselectedDepth : widget.style.selectedDepth),
    );
  }
}
