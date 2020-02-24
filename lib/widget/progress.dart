import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class ProgressStyle {
  final double depth;
  final double borderRadius;
  final Color startColor;
  final Color endColor;

  const ProgressStyle(
      {this.depth,
      this.borderRadius = 10.0,
      this.startColor = Colors.blue, //TODO use accent
      this.endColor = Colors.cyan //TODO use accent
      });
}

class NeumorphicProgress extends StatefulWidget {
  final double percent;
  final double height;
  final ProgressStyle style;

  const NeumorphicProgress({
    this.percent = 1,
    this.height = 10,
    this.style = const ProgressStyle(),
  });

  @override
  _NeumorphicProgressState createState() => _NeumorphicProgressState();
}

class _NeumorphicProgressState extends State<NeumorphicProgress> with SingleTickerProviderStateMixin {
  double percent = 0;
  AnimationController _controller;
  Animation _animation;

  @override
  void initState() {
    percent = widget.percent ?? 0;
    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 150));
    super.initState();
  }

  @override
  void didUpdateWidget(NeumorphicProgress oldWidget) {
    if (oldWidget.percent != widget.percent) {
      _controller.reset();
      _animation = Tween<double>(begin: oldWidget.percent, end: widget.percent).animate(_controller)
        ..addListener(() {
          setState(() {
            this.percent = _animation.value;
          });
        });

      _controller.forward();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      width: double.maxFinite,
      child: Neumorphic(
        padding: EdgeInsets.zero,
        style: NeumorphicStyle(depth: widget.style.depth, shape: NeumorphicShape.flat, borderRadius: widget.style.borderRadius),
        child: FractionallySizedBox(
          heightFactor: 1,
          alignment: Alignment.centerLeft,
          widthFactor: this.percent,
          child: ClipRRect(
            clipBehavior: Clip.antiAlias,
            borderRadius: BorderRadius.circular(widget.style.borderRadius),
            child: Container(decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.centerLeft, end: Alignment.centerRight, colors: [widget.style.startColor, widget.style.endColor]))),
          ),
        ),
      ),
    );
  }
}

class IndeterminateNeumorphicProgress extends StatefulWidget {
  final double height;
  final ProgressStyle style;
  final Duration duration;

  const IndeterminateNeumorphicProgress({
    this.height = 10,
    this.style = const ProgressStyle(),
    this.duration = const Duration(seconds: 3)
  });

  @override
  createState() => _IndeterminateNeumorphicProgressState();
}

class _IndeterminateNeumorphicProgressState extends State<IndeterminateNeumorphicProgress> with SingleTickerProviderStateMixin {
  double percent = 0;

  AnimationController _controller;
  Animation _animation;
  bool disposed = false;
  Alignment alignment = Alignment.centerLeft;

  @override
  void initState() {
    super.initState();
    _createAnimation();
  }

  @override
  void didUpdateWidget(IndeterminateNeumorphicProgress oldWidget) {
    _createAnimation();
    super.didUpdateWidget(oldWidget);
  }

  void _createAnimation(){
    _controller?.dispose();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller)
      ..addListener(() {
        setState(() {
          this.percent = _animation.value;
        });
      });

    loop();

    super.initState();
  }

  void loop() async {
    try {
      await _controller
          .repeat(min: 0, max: 1, reverse: false)
          .orCancel;
    } on TickerCanceled {}
  }

  @override
  void dispose() {
    _controller.dispose();
    disposed = true;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      width: double.maxFinite,
      child: Neumorphic(
        padding: EdgeInsets.zero,
        style: NeumorphicStyle(depth: widget.style.depth, shape: NeumorphicShape.flat, borderRadius: widget.style.borderRadius),
        child: LayoutBuilder(builder: (context, constraints) {
          return Padding(
            padding: EdgeInsets.only(left: constraints.maxWidth * percent),
            child: FractionallySizedBox(
              heightFactor: 1,
              alignment: Alignment.centerLeft,
              widthFactor: this.percent,
              child: ClipRRect(
                clipBehavior: Clip.antiAlias,
                borderRadius: BorderRadius.circular(widget.style.borderRadius),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [widget.style.startColor, widget.style.endColor],
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
