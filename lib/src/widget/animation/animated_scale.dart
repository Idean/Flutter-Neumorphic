import 'package:flutter/widgets.dart';

class AnimatedScale extends StatefulWidget {
  final Widget child;
  final double scale;
  final Duration duration;

  const AnimatedScale({
    this.child,
    this.scale = 1,
    this.duration = const Duration(milliseconds: 150),
  });

  @override
  _AnimatedScaleState createState() => _AnimatedScaleState();
}

class _AnimatedScaleState extends State<AnimatedScale>
    with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;
  double scale = 1;

  void _onScaleChanged(double newScale) {
    //print("_onScaleChanged $newScale");
    _controller.reset();
    _animation =
        Tween<double>(begin: this.scale, end: newScale).animate(_controller)
          ..addListener(() {
            setState(() {
              scale = _animation.value;
              //print("scale $scale");
            });
          });
    _controller.forward();
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: widget.duration, vsync: this);
    _onScaleChanged(widget.scale);
  }

  @override
  void didUpdateWidget(AnimatedScale oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.scale != this.scale) {
      _onScaleChanged(widget.scale);
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: scale,
      alignment: Alignment.center,
      child: widget.child,
    );
  }
}
