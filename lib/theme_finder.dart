/* nullable */
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'flutter_neumorphic.dart';

NeumorphicTheme findNeumorphicTheme(BuildContext context) {
  //TODO remove provider.of
  try {
    return  Provider.of<NeumorphicTheme>(context);
  } catch (t) {
    return null;
  }
}