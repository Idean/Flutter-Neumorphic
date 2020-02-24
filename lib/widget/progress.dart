import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class ProgressStyle {
  final double depth;
  final double borderRadius;
  final Color startColor;
  final Color endColor;

  const ProgressStyle({
    this.depth,
    this.borderRadius = 10.0,
    this.startColor = Colors.blue, //TODO use accent
    this.endColor = Colors.cyan  //TODO use accent
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
    if(oldWidget.percent != widget.percent) {
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
        style: NeumorphicStyle(
          depth: widget.style.depth,
          shape: NeumorphicShape.flat,
          borderRadius: widget.style.borderRadius
        ),
        child: FractionallySizedBox(
          heightFactor: 1,
          alignment: Alignment.centerLeft,
          widthFactor: this.percent,
          child: ClipRRect(
            clipBehavior: Clip.hardEdge,
            borderRadius: BorderRadius.circular(widget.style.borderRadius),
            child: Container(decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  widget.style.startColor,
                  widget.style.endColor
                ]
              )
            )),
          ),
        ),
      ),
    );
  }
}
