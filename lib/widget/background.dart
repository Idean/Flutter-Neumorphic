import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class NeumorphicBackground extends StatelessWidget {

  final Widget child;

  const NeumorphicBackground({this.child});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 100),
      color: NeumorphicTheme.getCurrentTheme(context).baseColor,
      child: this.child,
    );
  }
}
