import 'package:flutter/widgets.dart';

import '../../flutter_neumorphic.dart';
import '../theme/neumorphic_theme.dart';

export '../decoration/neumorphic_decorations.dart';
export '../neumorphic_box_shape.dart';
export '../theme/neumorphic_theme.dart';

@immutable
class NeumorphicIcon extends StatelessWidget {
  final IconData icon;
  final NeumorphicStyle style;
  final Curve curve;
  final double size;
  final Duration duration;

  NeumorphicIcon(
    this.icon, {
    Key key,
    this.duration = Neumorphic.DEFAULT_DURATION,
    this.curve = Neumorphic.DEFAULT_CURVE,
    this.style,
    this.size = 20,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NeumorphicText(
      String.fromCharCode(icon.codePoint),
      textStyle: NeumorphicTextStyle(
        fontSize: size,
        fontFamily: icon.fontFamily,
        package: icon.fontPackage,
      ),
      duration: this.duration,
      style: style,
      curve: this.curve,
    );
  }
}
