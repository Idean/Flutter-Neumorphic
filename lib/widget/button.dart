import 'package:flutter/widgets.dart';

import '../theme.dart';
import 'animation/animated_scale.dart';
import 'container.dart';

class NeumorphicButton extends StatefulWidget {
  final Widget child;
  final NeumorphicStyle style;
  final double minDistance;

  const NeumorphicButton({
    Key key,
    this.child,
    this.minDistance = 0,
    this.style = const NeumorphicStyle(),
  }) : super(key: key);

  @override
  _NeumorphicButtonState createState() => _NeumorphicButtonState();
}

class _NeumorphicButtonState extends State<NeumorphicButton> {
  NeumorphicStyle initialStyle;

  double distance;
  double scale = 1;

  void updateInitialStyle() {
    if (widget.style != initialStyle) {
      setState(() {
        this.initialStyle = widget.style;
        distance = widget.style.distance;
      });
    }
  }

  @override
  void initState() {
    updateInitialStyle();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    updateInitialStyle();
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(NeumorphicButton oldWidget) {
    updateInitialStyle();
    super.didUpdateWidget(oldWidget);
  }

  void _changeDistance() {
    setState(() {
      scale = 0.95;
      distance = widget.minDistance;
    });
  }

  void _resetDistance() {
    setState(() {
      scale = 1;
      distance = initialStyle.distance;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (detail) {
        _changeDistance();
      },
      onTapUp: (detail) {
        _resetDistance();
      },
      onTapCancel: () {
        _resetDistance();
      },
      child: AnimatedScale(
        scale: this.scale,
        child: NeumorphicContainer(
          style: initialStyle.copyWith(distance: distance),
          child: widget.child,
        ),
      ),
    );
  }
}