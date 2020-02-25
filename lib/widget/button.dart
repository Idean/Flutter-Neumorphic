import 'package:flutter/widgets.dart';

import '../NeumorphicBoxShape.dart';
import '../theme.dart';
import 'animation/animated_scale.dart';
import 'container.dart';

typedef void NeumorphicButtonClickListener();

class NeumorphicButton extends StatefulWidget {
  final Widget child;
  final NeumorphicStyle style;
  final double minDistance;
  final NeumorphicBoxShape shape;
  final EdgeInsets padding;
  final NeumorphicButtonClickListener onClick;

  const NeumorphicButton({
    Key key,
    this.padding = const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    this.child,
    this.shape,
    this.onClick,
    this.minDistance = 0,
    this.style = const NeumorphicStyle(),
  }) : super(key: key);

  @override
  _NeumorphicButtonState createState() => _NeumorphicButtonState();
}

class _NeumorphicButtonState extends State<NeumorphicButton> {
  NeumorphicStyle initialStyle;

  double depth;
  double scale = 1;

  void updateInitialStyle() {
    if (widget.style != initialStyle) {
      setState(() {
        this.initialStyle = widget.style;
        depth = widget.style.depth;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    updateInitialStyle();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    updateInitialStyle();
  }

  @override
  void didUpdateWidget(NeumorphicButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    updateInitialStyle();
  }

  void _changeDistance() {
    setState(() {
      scale = 0.95;
      depth = widget.minDistance;
    });
  }

  void _resetDistance() {
    setState(() {
      scale = 1;
      depth = initialStyle.depth;
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
          widget.onClick();
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
          style: initialStyle.copyWith(depth: depth),
          child: widget.child,
        ),
      ),
    );
  }
}
