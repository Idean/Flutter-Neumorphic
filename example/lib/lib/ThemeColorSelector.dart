import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'color_selector.dart';

class ThemeColorSelector extends StatefulWidget {

  final BuildContext customContext;

  ThemeColorSelector({this.customContext});

  @override
  _ThemeColorSelectorState createState() => _ThemeColorSelectorState();
}

class _ThemeColorSelectorState extends State<ThemeColorSelector> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4),
      color: Colors.black,
      child: ColorSelector(
        color: NeumorphicTheme.baseColor(widget.customContext ?? context),
        onColorChanged: (color){
          setState(() {
            NeumorphicTheme.update(widget.customContext ?? context, (current) =>
                current.copyWith(
                    baseColor: color
                )
            );
          });
        },
      ),
    );
  }
}
