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
    this.selectedDepth: -5,
    this.unselectedDepth: 8,
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
    return NeumorphicButton(
      onClick: () {
        _onClick();
      },
      minDistance: widget.style.selectedDepth,
      shape: NeumorphicBoxShape.roundRect(borderRadius: BorderRadius.circular(5)),
      child: widget.child,
      style: NeumorphicStyle(
        depth: isSelected ? widget.style.selectedDepth : widget.style.unselectedDepth ,
        shape: NeumorphicShape.flat,
      ),
    );
  }
}
