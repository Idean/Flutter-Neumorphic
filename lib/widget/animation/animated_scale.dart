import 'package:flutter/material.dart';

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
    super.initState();
    _onScaleChanged(widget.scale);
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
