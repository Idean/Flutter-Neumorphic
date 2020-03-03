import 'package:flutter/material.dart' as material;
import 'package:flutter/widgets.dart';

import '../NeumorphicBoxShape.dart';

import '../theme.dart';
import '../theme_provider.dart';
import 'button.dart';

typedef void NeumorphicCheckboxListener<T>(T value);

class NeumorphicCheckboxStyle {
  final double selectedDepth;
  final double unselectedDepth;
  final Color selectedColor;

  const NeumorphicCheckboxStyle({
    this.selectedDepth,
    this.selectedColor,
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
    final selectedColor = widget.style.selectedColor ?? theme.accentColor;

    final double selectedDepth =
        -1 * (widget.style.selectedDepth ?? theme.depth).abs();
    final double unselectedDepth =
        (widget.style.unselectedDepth ?? theme.depth).abs();

    return NeumorphicButton(
      pressed: isSelected,
      onClick: () {
        _onClick();
      },
      minDistance: -1 * selectedDepth.abs(),
      boxShape: NeumorphicBoxShape.roundRect(
        borderRadius: BorderRadius.circular(5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(
          material.Icons.check,
          color: isSelected ? theme.baseColor : selectedColor,
          size: 20.0,
        ),
      ),
      style: NeumorphicStyle(
        color: isSelected ? selectedColor : null,
        depth: isSelected ? selectedDepth : unselectedDepth,
        shape: NeumorphicShape.flat,
      ),
    );
  }
}
