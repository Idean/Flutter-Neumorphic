import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class ProgressStyle {
  final double depth;
  final double borderRadius;
  final Color accent;
  final Color variant;

  const ProgressStyle({
    this.depth,
    this.borderRadius = 10.0,
    this.accent,
    this.variant,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProgressStyle && runtimeType == other.runtimeType && depth == other.depth && borderRadius == other.borderRadius && accent == other.accent && variant == other.variant;

  @override
  int get hashCode => depth.hashCode ^ borderRadius.hashCode ^ accent.hashCode ^ variant.hashCode;
}

class NeumorphicProgress extends StatefulWidget {
  final double _percent;
  final double height;
  final Duration duration;
  final ProgressStyle style;

  const NeumorphicProgress({
    Key key,
    double percent,
    this.height = 10,
    this.duration = const Duration(milliseconds: 150),
    this.style = const ProgressStyle(),
  }) : this._percent = percent, super(key: key) ;

  @override
  _NeumorphicProgressState createState() => _NeumorphicProgressState();

  double get percent => _percent.clamp(0, 1);

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is NeumorphicProgress && runtimeType == other.runtimeType && percent == other.percent && height == other.height && style == other.style;

  @override
  int get hashCode => percent.hashCode ^ height.hashCode ^ style.hashCode;
}

class _NeumorphicProgressState extends State<NeumorphicProgress> with TickerProviderStateMixin {
  double percent = 0;
  AnimationController _controller;
  Animation _animation;

  @override
  void initState() {
    super.initState();
    percent = widget.percent ?? 0;
    _controller = AnimationController(vsync: this, duration: widget.duration);
  }

  @override
  void didUpdateWidget(NeumorphicProgress oldWidget) {
    if (oldWidget.percent != widget.percent) {
      _controller.reset();
      if(widget.duration.inMilliseconds == 0){
        setState(() {
          this.percent = widget.percent;
        });
      } else {
        _animation = Tween<double>(begin: oldWidget.percent, end: widget.percent).animate(_controller)
          ..addListener(() {
            setState(() {
              this.percent = _animation.value;
            });
          });

        _controller.forward();
      }
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
    //print("widget.style.depth: ${widget.style.depth}");

    final NeumorphicTheme theme = NeumorphicThemeProvider.of(context);
    return SizedBox(
      height: widget.height,
      child: FractionallySizedBox(
        widthFactor: 1,
        heightFactor: 1,
        //width: constraints.maxWidth,
        child: Neumorphic(
          shape: NeumorphicBoxShape.roundRect(
              borderRadius: BorderRadius.circular(
            widget.style.borderRadius,
          )),
          padding: EdgeInsets.zero,
          style: NeumorphicStyle(depth: widget.style.depth, shape: NeumorphicShape.flat),
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
                  colors: [widget.style.accent ?? theme.accentColor, widget.style.variant ?? theme.variantColor],
                ),
              )),
            ),
          ),
        ),
      ),
    );
  }
}

class NeumorphicProgressIndeterminate extends StatefulWidget {
  final double height;
  final ProgressStyle style;
  final Duration duration;

  const NeumorphicProgressIndeterminate({Key key, this.height = 10, this.style = const ProgressStyle(), this.duration = const Duration(seconds: 3)}) : super(key: key);

  @override
  createState() => _NeumorphicProgressIndeterminateState();

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is NeumorphicProgressIndeterminate && runtimeType == other.runtimeType && height == other.height && style == other.style && duration == other.duration;

  @override
  int get hashCode => height.hashCode ^ style.hashCode ^ duration.hashCode;
}

class _NeumorphicProgressIndeterminateState extends State<NeumorphicProgressIndeterminate> with TickerProviderStateMixin {
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
  void didUpdateWidget(NeumorphicProgressIndeterminate oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget != widget) {
      _createAnimation();
    }
  }

  void _createAnimation() {
    _controller?.dispose();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller)
      ..addListener(() {
        setState(() {
          this.percent = _animation.value;
        });
      });

    loop();
  }

  void loop() async {
    try {
      await _controller.repeat(min: 0, max: 1, reverse: false).orCancel;
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
    final NeumorphicTheme theme = NeumorphicThemeProvider.of(context);

    return FractionallySizedBox(
      widthFactor: 1,
      child: SizedBox(
        height: widget.height,
        child: Neumorphic(
          shape: NeumorphicBoxShape.roundRect(borderRadius: BorderRadius.circular(widget.style.borderRadius)),
          padding: EdgeInsets.zero,
          style: NeumorphicStyle(depth: widget.style.depth, shape: NeumorphicShape.flat),
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
                        colors: [widget.style.accent ?? theme.accentColor, widget.style.variant ?? theme.variantColor],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
