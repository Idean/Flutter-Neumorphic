import 'dart:ui';

import 'package:flutter/widgets.dart';

import 'container.dart';

/// A style to customize the [NeumorphicProgress]
///
/// the gradient will use [accent] and [variant]
///
/// the gradient shape will be a roundrect, using [borderRadius]
///
/// you can define a custom [depth] for the roundrect
///
/// you can update the gradient orientation using [progressGradientStart] & [progressGradientEnd]
///
class ProgressStyle {
  final double depth;
  final BorderRadius borderRadius;
  final BorderRadius gradientBorderRadius;
  final Color accent;
  final Color variant;
  final LightSource lightSource;

  final AlignmentGeometry progressGradientStart;
  final AlignmentGeometry progressGradientEnd;
  final bool disableDepth;

  final NeumorphicBorder border;

  const ProgressStyle({
    this.depth,
    this.disableDepth,
    this.borderRadius = const BorderRadius.all(Radius.circular(10.0)),
    this.gradientBorderRadius,
    this.accent,
    this.lightSource,
    this.progressGradientStart,
    this.progressGradientEnd,
    this.variant,
    this.border = const NeumorphicBorder.none(),
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProgressStyle &&
          runtimeType == other.runtimeType &&
          depth == other.depth &&
          border == other.border &&
          disableDepth == other.disableDepth &&
          lightSource == other.lightSource &&
          borderRadius == other.borderRadius &&
          gradientBorderRadius == other.gradientBorderRadius &&
          accent == other.accent &&
          variant == other.variant &&
          progressGradientStart == other.progressGradientStart &&
          progressGradientEnd == other.progressGradientEnd;

  @override
  int get hashCode =>
      depth.hashCode ^
      disableDepth.hashCode ^
      borderRadius.hashCode ^
      lightSource.hashCode ^
      gradientBorderRadius.hashCode ^
      border.hashCode ^
      accent.hashCode ^
      variant.hashCode ^
      progressGradientStart.hashCode ^
      progressGradientEnd.hashCode;
}

/// A widget that shows progress along a line.
///
/// NeumorphicProgress is determinate.
///
/// Determinate progress indicators have a specific value at each point in time,
/// and the value should increase monotonically from 0.0 to 1.0, at which time the indicator is complete.
/// To create a determinate progress indicator, use a non-null value between 0.0 and 1.0.
///
///  ```
///  NeumorphicProgress(
///      height: 15,
///      percent: 0.55,
///  );
///  ```
///
class NeumorphicProgress extends StatefulWidget {
  final double _percent;
  final double height;
  final Duration duration;
  final ProgressStyle style;
  final Curve curve;

  const NeumorphicProgress(
      {Key key,
      double percent,
      this.height = 10,
      this.duration = const Duration(milliseconds: 300),
      this.style = const ProgressStyle(),
      this.curve = Curves.easeOutCubic})
      : this._percent = percent,
        super(key: key);

  @override
  _NeumorphicProgressState createState() => _NeumorphicProgressState();

  double get percent => _percent.clamp(0, 1);

  @override
  // ignore: invalid_override_of_non_virtual_member
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NeumorphicProgress &&
          runtimeType == other.runtimeType &&
          percent == other.percent &&
          height == other.height &&
          style == other.style &&
          curve == other.curve;

  @override
  // ignore: invalid_override_of_non_virtual_member
  int get hashCode =>
      percent.hashCode ^ height.hashCode ^ style.hashCode ^ curve.hashCode;
}

class _NeumorphicProgressState extends State<NeumorphicProgress>
    with TickerProviderStateMixin {
  double oldPercent = 0;

  AnimationController _controller;
  Animation _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _animation = Tween<double>(begin: widget.percent, end: oldPercent)
        .animate(_controller);
  }

  @override
  void didUpdateWidget(NeumorphicProgress oldWidget) {
    if (oldWidget.percent != widget.percent) {
      _controller.reset();
      oldPercent = oldWidget.percent;
      _animation = Tween<double>(begin: oldPercent, end: widget.percent)
          .animate(CurvedAnimation(parent: _controller, curve: widget.curve));
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
    //print("widget.style.depth: ${widget.style.depth}");

    final NeumorphicThemeData theme = NeumorphicTheme.currentTheme(context);
    return SizedBox(
      height: widget.height,
      child: FractionallySizedBox(
        widthFactor: 1,
        //width: constraints.maxWidth,
        child: Neumorphic(
          padding: EdgeInsets.zero,
          style: NeumorphicStyle(
            boxShape: NeumorphicBoxShape.roundRect(widget.style.borderRadius),
            disableDepth: widget.style.disableDepth,
            border: widget.style.border,
            depth: widget.style.depth,
            shape: NeumorphicShape.flat,
          ),
          child: AnimatedBuilder(
              animation: _controller,
              builder: (_, __) {
                return FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: _animation.value,
                  child: _GradientProgress(
                    borderRadius: widget.style.gradientBorderRadius ??
                        widget.style.borderRadius,
                    begin: widget.style.progressGradientStart ??
                        Alignment.centerLeft,
                    end: widget.style.progressGradientEnd ??
                        Alignment.centerRight,
                    colors: [
                      widget.style.variant ?? theme.variantColor,
                      widget.style.accent ?? theme.accentColor,
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }
}

/// A widget that shows progress along a line.
///
/// NeumorphicProgressIndeterminate is indeterminate.
///
/// You can provide a custom animation [duration]
///
/// Indeterminate progress indicators do not have a specific value at each point in time and instead indicate that progress is being made
/// without indicating how much progress remains. To create an indeterminate progress indicator, use a null value.
///
///  ```
///  NeumorphicProgressIndeterminate(
///      height: 15,
///  );
///
///  ```
///
class NeumorphicProgressIndeterminate extends StatefulWidget {
  final double height;
  final ProgressStyle style;
  final Duration duration;
  final bool reverse;
  final Curve curve;

  const NeumorphicProgressIndeterminate({
    Key key,
    this.height = 10,
    this.style = const ProgressStyle(),
    this.duration = const Duration(seconds: 3),
    this.reverse = false,
    this.curve = Curves.easeInOut,
  }) : super(key: key);

  @override
  createState() => _NeumorphicProgressIndeterminateState();

  @override
  // ignore: invalid_override_of_non_virtual_member
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NeumorphicProgressIndeterminate &&
          runtimeType == other.runtimeType &&
          height == other.height &&
          style == other.style &&
          duration == other.duration &&
          reverse == other.reverse &&
          curve == other.curve;

  @override
  // ignore: invalid_override_of_non_virtual_member
  int get hashCode =>
      height.hashCode ^
      style.hashCode ^
      duration.hashCode ^
      reverse.hashCode ^
      curve.hashCode;
}

class _NeumorphicProgressIndeterminateState
    extends State<NeumorphicProgressIndeterminate>
    with TickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _animation = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: _controller, curve: widget.curve));
    _loop();
  }

  void _loop() async {
    try {
      await _controller
          .repeat(min: 0, max: 1, reverse: widget.reverse)
          .orCancel;
    } on TickerCanceled {}
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final NeumorphicThemeData theme = NeumorphicTheme.currentTheme(context);

    return FractionallySizedBox(
      widthFactor: 1,
      child: SizedBox(
        height: widget.height,
        child: Neumorphic(
          padding: EdgeInsets.zero,
          style: NeumorphicStyle(
            boxShape: NeumorphicBoxShape.roundRect(widget.style.borderRadius),
            lightSource: widget.style.lightSource ?? theme.lightSource,
            border: widget.style.border,
            disableDepth: widget.style.disableDepth,
            depth: widget.style.depth,
            shape: NeumorphicShape.flat,
          ),
          child: LayoutBuilder(builder: (context, constraints) {
            return AnimatedBuilder(
                animation: _animation,
                builder: (_, __) {
                  return Padding(
                    padding: EdgeInsets.only(
                        left: constraints.maxWidth * _animation.value),
                    child: FractionallySizedBox(
                      heightFactor: 1,
                      alignment: Alignment.centerLeft,
                      widthFactor: _animation.value,
                      child: _GradientProgress(
                        borderRadius: widget.style.gradientBorderRadius ??
                            widget.style.borderRadius,
                        begin: widget.style.progressGradientStart ??
                            Alignment.centerLeft,
                        end: widget.style.progressGradientEnd ??
                            Alignment.centerRight,
                        colors: [
                          widget.style.accent ?? theme.accentColor,
                          widget.style.variant ?? theme.variantColor
                        ],
                      ),
                    ),
                  );
                });
          }),
        ),
      ),
    );
  }
}

class _GradientProgress extends StatelessWidget {
  final AlignmentGeometry begin;
  final AlignmentGeometry end;
  final List<Color> colors;
  final BorderRadius borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: this.borderRadius,
        gradient: LinearGradient(
            begin: this.begin, end: this.end, colors: this.colors),
      ),
    );
  }

  const _GradientProgress({
    @required this.begin,
    @required this.end,
    @required this.colors,
    @required this.borderRadius,
  });
}
