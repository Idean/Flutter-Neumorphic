import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic/NeumorphicBoxShape.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'button.dart';

typedef void NeumorphicRadioListener<T>(T value);

class NeumorphicRadioStyle {
  final double selectedDepth;
  final double unselectedDepth;

  final double intensity;
  final NeumorphicBoxShape boxShape;
  final NeumorphicShape shape;

  const NeumorphicRadioStyle({
    this.selectedDepth,
    this.unselectedDepth,
    this.intensity,
    this.boxShape,
    this.shape
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

  void _onClick(){
    if(widget.value == widget.groupValue){
      //unselect
      widget.onChanged(null);
    } else {
      widget.onChanged(widget.value);
    }
  }

  @override
  Widget build(BuildContext context) {
    final NeumorphicTheme theme = NeumorphicThemeProvider.findNeumorphicTheme(context);

    final double selectedDepth = -1 * (widget.style.selectedDepth ?? theme.depth).abs();
    final double unselectedDepth = (widget.style.unselectedDepth ?? theme.depth).abs();

    return NeumorphicButton(
      onClick: () {
        _onClick();
      },
      pressed: isSelected,
      minDistance: selectedDepth,
      shape: widget.style.boxShape ?? NeumorphicBoxShape.roundRect(borderRadius: BorderRadius.circular(5)),
      child: widget.child,
      style: NeumorphicStyle(
        intensity: widget.style.intensity,
        depth: isSelected ? selectedDepth : unselectedDepth ,
        shape: widget.style.shape ?? NeumorphicShape.flat,
      ),
    );
  }
}
