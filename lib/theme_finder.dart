/* nullable */
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'flutter_neumorphic.dart';
import 'package:flutter/material.dart';

NeumorphicTheme findNeumorphicTheme(BuildContext context) {
  try {
    return  Provider.of<NeumorphicTheme>(context);
  } catch (t) {
    return null;
  }
}

class NeumorphicThemeProvider extends StatelessWidget {

  final NeumorphicTheme theme;
  final Widget child;

  NeumorphicThemeProvider({@required this.child, @required this.theme});

  @override
  Widget build(BuildContext context) {
    return Provider.value(
      value: this.theme,
      child: this.child
    );
  }
}
