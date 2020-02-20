import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic/container.dart';

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

class AnimatedScale extends StatefulWidget {
  final Widget child;
  final double scale;

  const AnimatedScale({this.child, this.scale = 1});

  @override
  _AnimatedScaleState createState() => _AnimatedScaleState();
}

class _AnimatedScaleState extends State<AnimatedScale> with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;
  double scale = 1;

  void _onScaleChanged(double newScale) {
    _controller?.dispose();
    _controller = AnimationController(duration: const Duration(milliseconds: 150), vsync: this);
    _animation = Tween<double>(begin: this.scale, end: newScale).animate(_controller)
      ..addListener(() {
        setState(() {
          scale = _animation.value;
        });
      });
    _controller.forward();
  }

  @override
  void initState() {
    _onScaleChanged(widget.scale);
    super.initState();
  }

  @override
  void didUpdateWidget(AnimatedScale oldWidget) {
    if (widget.scale != this.scale) {
      _onScaleChanged(widget.scale);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Transform.scale(scale: scale, alignment: Alignment.center, child: widget.child);
  }
}
