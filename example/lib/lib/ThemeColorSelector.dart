import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'color_selector.dart';

class ThemeColorSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4),
      color: Colors.black,
      child: ColorSelector(
        color: NeumorphicTheme.baseColor(context),
        onColorChanged: (color){
          NeumorphicTheme.of(context).update((current) =>
              current.copyWith(
                  baseColor: color
              )
          );
        },
      ),
    );
  }
}
