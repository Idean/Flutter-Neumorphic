import 'package:flutter/material.dart' as material;
import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic/NeumorphicBoxShape.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'button.dart';

typedef void NeumorphicCheckboxListener<T>(T value);

class NeumorphicCheckboxStyle {
  final double selectedDepth;
  final double unselectedDepth;
  final Color accent;

  const NeumorphicCheckboxStyle({
    this.selectedDepth,
    this.accent,
    this.unselectedDepth,
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
    final NeumorphicThemeData theme = NeumorphicTheme.getCurrentTheme(context);
    final accent = widget.style.accent ?? theme.accentColor;

    final double selectedDepth = -1 * (widget.style.selectedDepth ?? theme.depth).abs();
    final double unselectedDepth = (widget.style.unselectedDepth ?? theme.depth).abs();

    return NeumorphicButton(
      accent: isSelected ? accent : null,
      pressed: isSelected,
      onClick: () {
        _onClick();
      },
      minDistance: -1 * selectedDepth.abs(),
      shape: NeumorphicBoxShape.roundRect(
        borderRadius: BorderRadius.circular(5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(
          material.Icons.check,
          color: isSelected ? theme.baseColor : accent,
          size: 20.0,
        ),
      ),
      style: NeumorphicStyle(
        depth: isSelected ?
          selectedDepth :
          unselectedDepth,
        shape: NeumorphicShape.flat,
      ),
    );
  }

}
