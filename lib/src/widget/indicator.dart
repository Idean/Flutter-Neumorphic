import 'dart:ui';

import 'package:flutter/widgets.dart';

import 'container.dart';

/// A Style to customize the [NeumorphicIndicator]
///
/// the gradient will use [accent] and [variant]
///
/// the gradient shape will be a roundrect, using [borderRadius]
///
/// you can define a custom [depth] for the roundrect
///
/// you can update the gradient orientation using [gradientStart] & [gradientEnd]
///
class IndicatorStyle {
  //final double borderRadius;
  final double depth;
  final bool? disableDepth;
  final Color? accent;
  final Color? variant;
  final LightSource? lightSource;

  final AlignmentGeometry? gradientStart;
  final AlignmentGeometry? gradientEnd;

  const IndicatorStyle({
    this.depth = -4,
    this.accent,
    this.lightSource,
    this.variant,
    this.disableDepth,
    this.gradientStart,
    this.gradientEnd,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IndicatorStyle &&
          runtimeType == other.runtimeType &&
          depth == other.depth &&
          disableDepth == other.disableDepth &&
          accent == other.accent &&
          lightSource == other.lightSource &&
          variant == other.variant &&
          gradientStart == other.gradientStart &&
          gradientEnd == other.gradientEnd;

  @override
  int get hashCode =>
      depth.hashCode ^
      disableDepth.hashCode ^
      accent.hashCode ^
      variant.hashCode ^
      lightSource.hashCode ^
      gradientStart.hashCode ^
      gradientEnd.hashCode;
}

enum NeumorphicIndicatorOrientation { vertical, horizontal }

/// An indicator is a horizontal / vertical bar that display a percentage
///
/// Like a ProgressBar, but with an [orientation] @see [NeumorphicIndicatorOrientation]
///
/// it takes a [padding], a [width] and [height]
///
/// the current accented roundrect use the [percent] field
///
/// Widget _buildIndicators() {
///
///    final width = 14.0;
///
///    return SizedBox(
///      height: 130,
///      child: Row(
///        mainAxisAlignment: MainAxisAlignment.center,
///        children: <Widget>[
///          NeumorphicIndicator(
///            width: width,
///            percent: 0.4,
///          ),
///          SizedBox(width: 10),
///          NeumorphicIndicator(
///            width: width,
///            percent: 0.2,
///          ),
///          SizedBox(width: 10),
///          NeumorphicIndicator(
///            width: width,
///            percent: 0.5,
///          ),
///          SizedBox(width: 10),
///          NeumorphicIndicator(
///            width: width,
///            percent: 1,
///          ),
///        ],
///      ),
///    );
///  }
///
@immutable
class NeumorphicIndicator extends StatefulWidget {
  final double percent;
  final double width;
  final double height;
  final EdgeInsets padding;
  final NeumorphicIndicatorOrientation orientation;
  final IndicatorStyle style;
  final Duration duration;
  final Curve curve;

  const NeumorphicIndicator({
    Key? key,
    this.percent = 0.5,
    this.orientation = NeumorphicIndicatorOrientation.vertical,
    this.height = double.maxFinite,
    this.padding = EdgeInsets.zero,
    this.width = double.maxFinite,
    this.style = const IndicatorStyle(),
    this.duration = const Duration(milliseconds: 300),
    this.curve = Curves.easeOutCubic,
  }) : super(key: key);

  @override
  createState() => _NeumorphicIndicatorState();

  @override
  // ignore: invalid_override_of_non_virtual_member
  bool operator ==(Object other) =>
      identical(this, other) ||
      super == other &&
          other is NeumorphicIndicator &&
          runtimeType == other.runtimeType &&
          percent == other.percent &&
          width == other.width &&
          height == other.height &&
          padding == other.padding &&
          orientation == other.orientation &&
          style == other.style &&
          duration == other.duration &&
          curve == other.curve;

  @override
  // ignore: invalid_override_of_non_virtual_member
  int get hashCode =>
      super.hashCode ^
      percent.hashCode ^
      width.hashCode ^
      height.hashCode ^
      padding.hashCode ^
      orientation.hashCode ^
      style.hashCode ^
      duration.hashCode ^
      curve.hashCode;
}

class _NeumorphicIndicatorState extends State<NeumorphicIndicator>
    with TickerProviderStateMixin {
  double oldPercent = 0;
  late AnimationController _controller;
  late Animation _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _animation = Tween<double>(begin: widget.percent, end: oldPercent)
        .animate(_controller);
  }

  @override
  void didUpdateWidget(NeumorphicIndicator oldWidget) {
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
    final NeumorphicThemeData theme = NeumorphicTheme.currentTheme(context);
    return SizedBox(
      height: widget.height,
      width: widget.width,
      child: Neumorphic(
        padding: EdgeInsets.zero,
        style: NeumorphicStyle(
          boxShape: NeumorphicBoxShape.stadium(),
          lightSource: widget.style.lightSource ?? theme.lightSource,
          disableDepth: widget.style.disableDepth,
          depth: widget.style.depth,
          shape: NeumorphicShape.flat,
        ),
        child: AnimatedBuilder(
            animation: _animation,
            builder: (_, __) {
              return FractionallySizedBox(
                heightFactor: widget.orientation ==
                        NeumorphicIndicatorOrientation.vertical
                    ? _animation.value
                    : 1,
                widthFactor: widget.orientation ==
                        NeumorphicIndicatorOrientation.horizontal
                    ? _animation.value
                    : 1,
                alignment: widget.orientation ==
                        NeumorphicIndicatorOrientation.horizontal
                    ? Alignment.centerLeft
                    : Alignment.bottomCenter,
                child: Padding(
                  padding: widget.padding,
                  child: Neumorphic(
                    style: NeumorphicStyle(
                      boxShape: NeumorphicBoxShape.stadium(),
                      lightSource:
                          widget.style.lightSource ?? theme.lightSource,
                    ),
                    child: Container(
                        decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin:
                            widget.style.gradientStart ?? Alignment.topCenter,
                        end: widget.style.gradientEnd ?? Alignment.bottomCenter,
                        colors: [
                          widget.style.accent ?? theme.accentColor,
                          widget.style.variant ?? theme.variantColor
                        ],
                      ),
                    )),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
