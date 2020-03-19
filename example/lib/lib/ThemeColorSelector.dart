import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'color_selector.dart';

class ThemeColorSelector extends StatelessWidget {

  final BuildContext customContext;

  ThemeColorSelector({this.customContext});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4),
      color: Colors.black,
      child: ColorSelector(
        color: NeumorphicTheme.baseColor(customContext ?? context),
        onColorChanged: (color){
          NeumorphicTheme.update(customContext ?? context, (current) =>
              current.copyWith(
                  baseColor: color
              )
          );
        },
      ),
    );
  }
}
