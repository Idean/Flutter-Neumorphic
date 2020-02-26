import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

typedef void NeumorphicSeekBarListener(double percent);

class SeekBarStyle {
  final double depth;
  final double borderRadius;
  final Color accent;
  final Color variant;

  const SeekBarStyle({
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

@immutable
class NeumorphicSeekBar extends StatefulWidget {
  final SeekBarStyle style;
  final double min;
  final double value;
  final double max;
  final double height;
  final NeumorphicSeekBarListener onChanged;
  final NeumorphicSeekBarListener onChangeStart;
  final NeumorphicSeekBarListener onChangeEnd;

  final Widget thumb;

  NeumorphicSeekBar({
    Key key,
    this.style = const SeekBarStyle(),
    this.min = 0,
    this.value = 0,
    this.max = 10,
    this.height = 10,
    this.onChanged,
    this.onChangeStart,
    this.onChangeEnd,
    this.thumb,
  });

  double get percent => value / (max - min);

  @override
  createState() => _NeumorphicSeekBarState();
}

class _NeumorphicSeekBarState extends State<NeumorphicSeekBar> {
  @override
  Widget build(BuildContext context) {
    //print("percent : ${widget.percent}");
    return LayoutBuilder(builder: (context, constraints) {
      return GestureDetector(
        //onPanDown: (details) => setState(() => _initialTapPosition = details.globalPosition),
        onPanUpdate: (DragUpdateDetails details) {
          setState(() {
            final RenderBox box = context.findRenderObject();
            final tapPos = box.globalToLocal(details.globalPosition);
            final newPercent = tapPos.dx / constraints.maxWidth;
            // print("tapPos : $tapPos");
            // print("newPercent : $newPercent");

            final newValue = ((widget.max - widget.min) * newPercent).clamp(widget.min, widget.max);

            if (widget.onChanged != null) {
              //  print("onChanged : $newValue");
              widget.onChanged(newValue);
            }
          });
        },
        onTapUp: (details) {
          print("onTapUp");
          if (widget.onChangeEnd != null) {
            widget.onChangeEnd(widget.value);
          }
        },
        onPanCancel: () {
          print("onPanCancel");
        },
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            NeumorphicProgress(
              duration: Duration.zero,
              percent: widget.percent,
              height: widget.height,
              style: ProgressStyle(
                depth: widget.style.depth,
                borderRadius: widget.style.borderRadius,
                accent: widget.style.accent,
                variant: widget.style.variant,
              ),
            ),
            Align(
                alignment: Alignment(
                    (widget.percent * 2) - 1, //because left = -1 & right = 1, so the "width" = 2, and minValue = 1
                    0),
                child: _generateThumb(context)
            )
          ],
        ),
      );
    });
  }

  Widget _generateThumb(BuildContext context){
   final theme = NeumorphicThemeProvider.findNeumorphicTheme(context);
   return Neumorphic(
     accent: widget.style.accent ?? theme.accentColor,
      shape: NeumorphicBoxShape.circle(),
      child: SizedBox(
        height: 15,
        width: 15,
      ),
    );
  }
}
