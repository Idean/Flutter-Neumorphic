import 'package:flutter/widgets.dart';

import '../theme.dart';
import 'animation/animated_scale.dart';
import 'container.dart';

class NeumorphicButton extends StatefulWidget {
  final Widget child;
  final NeumorphicStyle style;
  final double minDistance;
  final BoxShape shape;
  final EdgeInsets padding;

  const NeumorphicButton({
    Key key,
    this.padding = const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    this.child,
    this.shape,
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

  bool get clickable {
    return initialStyle.shape != NeumorphicShape.emboss;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (detail) {
        if (clickable) {
          _changeDistance();
        }
      },
      onTapUp: (detail) {
        if (clickable) {
          _resetDistance();
        }
      },
      onTapCancel: () {
        if (clickable) {
          _resetDistance();
        }
      },
      child: AnimatedScale(
        scale: this.scale,
        child: Neumorphic(
          padding: widget.padding,
          shape: widget.shape,
          style: initialStyle.copyWith(distance: distance),
          child: widget.child,
        ),
      ),
    );
  }
}
