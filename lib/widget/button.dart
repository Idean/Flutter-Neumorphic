import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../NeumorphicBoxShape.dart';
import '../theme.dart';
import 'animation/animated_scale.dart';
import 'container.dart';

typedef void NeumorphicButtonClickListener();

class NeumorphicButton extends StatefulWidget {

  static const double PRESSED_SCALE = 0.98;
  static const double UNPRESSED_SCALE = 1.0;

  final Widget child;
  final NeumorphicStyle style;
  final Color accent;
  final double minDistance;
  final NeumorphicBoxShape shape;
  final EdgeInsets padding;
  final bool pressed; //null, true, false
  final NeumorphicBorder border;
  final NeumorphicButtonClickListener onClick;

  const NeumorphicButton({
    Key key,
    this.padding = const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    this.child,
    this.border,
    this.pressed, //true/false if you want to change the state of the button
    this.shape,
    this.accent,
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
  bool pressed = false; //overwrite widget.pressed when click for animation

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
      pressed = true;
      depth = widget.minDistance;
    });
  }

  void _resetDistance() {
    setState(() {
      pressed = false;
      depth = initialStyle.depth;
    });
  }

  bool get clickable {
    return widget.onClick != null;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (detail) {
        if (clickable) {
          _changeDistance();
          //haptic vibration
          HapticFeedback.mediumImpact();
        }
      },
      onTapUp: (detail) {
        if (clickable) {
          _resetDistance();
          if(widget.onClick != null) {
            widget.onClick();
          }
        }
      },
      onTapCancel: () {
        if (clickable) {
          _resetDistance();
        }
      },
      child: AnimatedScale(
        scale: _getScale(),
        child: Neumorphic(
          border: widget.border,
          accent: widget.accent,
          padding: widget.padding,
          shape: widget.shape,
          style: initialStyle.copyWith(depth: depth),
          child: widget.child,
        ),
      ),
    );
  }

  double _getScale() {
    if(widget.pressed != null){ //defined by the widget that use it
      return widget.pressed ? NeumorphicButton.PRESSED_SCALE : NeumorphicButton.UNPRESSED_SCALE;
    } else {
      return this.pressed ? NeumorphicButton.PRESSED_SCALE : NeumorphicButton.UNPRESSED_SCALE;
    }
  }
}
