import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic/NeumorphicBoxShape.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'button.dart';

typedef void NeumorphicCheckboxListener<T>(T value);

class NeumorphicCheckboxStyle {
  final double selectedDepth;
  final double unselectedDepth;
  final Color accent;

  //TODO add some stylable elements here

  const NeumorphicCheckboxStyle({
    this.selectedDepth: -5,
    this.accent,
    this.unselectedDepth: 8,
  });
}

class NeumorphicCheckbox extends StatefulWidget {
  final bool value;
  final NeumorphicCheckboxStyle style;
  final NeumorphicCheckboxListener onChanged;

  NeumorphicCheckbox({
    this.style = const NeumorphicCheckboxStyle(),
    this.value,
    this.onChanged,
  });

  @override
  createState() => _NeumorphicCheckboxState();
}

class _NeumorphicCheckboxState extends State<NeumorphicCheckbox> {
  bool get isSelected => widget.value;

  void _onClick() {
    widget.onChanged(!widget.value);
  }

  @override
  Widget build(BuildContext context) {
    final NeumorphicTheme theme = NeumorphicThemeProvider.findNeumorphicTheme(context);
    final accent = widget.style.accent ?? theme.accentColor;

    return NeumorphicButton(
      accent: isSelected ? accent : null,
      onClick: () {
        _onClick();
      },
      minDistance: widget.style.selectedDepth,
      shape: NeumorphicBoxShape.roundRect(
        borderRadius: BorderRadius.circular(5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(
          Icons.check,
          color: isSelected ? theme.baseColor : accent,
          size: 20.0,
        ),
      ),
      style: NeumorphicStyle(
        depth: isSelected ? widget.style.selectedDepth : widget.style.unselectedDepth,
        shape: NeumorphicShape.flat,
      ),
    );
  }
}
