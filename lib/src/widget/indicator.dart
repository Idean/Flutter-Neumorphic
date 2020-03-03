import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class IndicatorStyle {
  //final double borderRadius;
  final double depth;
  final Color accent;
  final Color variant;

  final AlignmentGeometry gradientStart;
  final AlignmentGeometry gradientEnd;

  const IndicatorStyle({
    this.depth = -4,
    this.accent,
    this.variant,
    this.gradientStart,
    this.gradientEnd,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is IndicatorStyle &&
              runtimeType == other.runtimeType &&
              depth == other.depth &&
              accent == other.accent &&
              variant == other.variant &&
              gradientStart == other.gradientStart &&
              gradientEnd == other.gradientEnd;

  @override
  int get hashCode =>
      depth.hashCode ^
      accent.hashCode ^
      variant.hashCode ^
      gradientStart.hashCode ^
      gradientEnd.hashCode;



}

enum NeumorphicIndicatorOrientation { vertical, horizontal }

class NeumorphicIndicator extends StatefulWidget {
  final double percent;
  final double width;
  final double height;
  final EdgeInsets padding;
  final NeumorphicIndicatorOrientation orientation;
  final IndicatorStyle style;

  const NeumorphicIndicator({
    Key key,
    this.percent = 0.5,
    this.orientation = NeumorphicIndicatorOrientation.vertical,
    this.height = double.maxFinite,
    this.padding = EdgeInsets.zero,
    this.width = double.maxFinite,
    this.style = const IndicatorStyle(),
  }) : super(key: key);

  @override
  createState() => _NeumorphicIndicatorState();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NeumorphicIndicator &&
          runtimeType == other.runtimeType &&
          percent == other.percent &&
          width == other.width &&
          height == other.height &&
          orientation == other.orientation &&
          style == other.style;

  @override
  int get hashCode => percent.hashCode ^ width.hashCode ^ height.hashCode ^ orientation.hashCode ^ style.hashCode;
}

class _NeumorphicIndicatorState extends State<NeumorphicIndicator> with TickerProviderStateMixin {
  double percent = 0;
  AnimationController _controller;
  Animation _animation;

  @override
  void initState() {
    super.initState();
    percent = widget.percent ?? 0;
    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 150));
  }

  @override
  void didUpdateWidget(NeumorphicIndicator oldWidget) {
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
    final NeumorphicThemeData theme = NeumorphicTheme.getCurrentTheme(context);
    return SizedBox(
      height: widget.height,
      width: widget.width,
      child: Neumorphic(
        boxShape: NeumorphicBoxShape.stadium(),
        padding: EdgeInsets.zero,
        style: NeumorphicStyle(depth: widget.style.depth, shape: NeumorphicShape.flat),
        child: FractionallySizedBox(
          heightFactor: widget.orientation == NeumorphicIndicatorOrientation.vertical ? widget.percent : 1,
          widthFactor: widget.orientation == NeumorphicIndicatorOrientation.horizontal ? widget.percent : 1,
          alignment: widget.orientation == NeumorphicIndicatorOrientation.horizontal ? Alignment.centerLeft : Alignment.bottomCenter,
          child: Padding(
            padding: widget.padding,
            child: Neumorphic(
              boxShape: NeumorphicBoxShape.stadium(),
              child: Container(
                  decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: widget.style.gradientStart ?? Alignment.topCenter,
                  end: widget.style.gradientEnd ?? Alignment.bottomCenter,
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
