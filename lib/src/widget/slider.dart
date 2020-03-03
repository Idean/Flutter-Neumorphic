import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

typedef void NeumorphicSliderListener(double percent);

class SliderStyle {
  final double depth;
  final double borderRadius;
  final Color accent;
  final Color variant;

  const SliderStyle({
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
class NeumorphicSlider extends StatefulWidget {
  final SliderStyle style;
  final double min;
  final double value;
  final double max;
  final double height;
  final NeumorphicSliderListener onChanged;
  final NeumorphicSliderListener onChangeStart;
  final NeumorphicSliderListener onChangeEnd;

  final Widget thumb;

  NeumorphicSlider({
    Key key,
    this.style = const SliderStyle(),
    this.min = 0,
    this.value = 0,
    this.max = 10,
    this.height = 15,
    this.onChanged,
    this.onChangeStart,
    this.onChangeEnd,
    this.thumb,
  });

  double get percent => value / (max - min);

  @override
  createState() => _NeumorphicSliderState();
}

class _NeumorphicSliderState extends State<NeumorphicSlider> {
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
        onPanStart: (DragStartDetails details) {
          //print("onPanStart");
          if (widget.onChangeStart != null) {
            widget.onChangeStart(widget.value);
          }
        },
        onTapUp: (details) {
          //print("onTapUp");
          if (widget.onChangeEnd != null) {
            widget.onChangeEnd(widget.value);
          }
        },
        onPanCancel: () {

          //print("onPanCancel");
        },
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            _generateSlider(),
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


  Widget _generateSlider(){
    final theme = NeumorphicTheme.getCurrentTheme(context);
    return NeumorphicProgress(
      duration: Duration.zero,
      percent: widget.percent,
      height: widget.height,
      style: ProgressStyle(
        depth: widget.style.depth,
        borderRadius: widget.style.borderRadius,
        accent: widget.style.accent ?? theme.accentColor,
        variant: widget.style.variant ?? theme.variantColor,
      ),
    );
  }

  Widget _generateThumb(BuildContext context){
   final theme = NeumorphicTheme.getCurrentTheme(context);
   return Neumorphic(
     style: NeumorphicStyle(
       shape: NeumorphicShape.concave,
       color: widget.style.accent ?? theme.accentColor,
     ),
      boxShape: NeumorphicBoxShape.circle(),
      child: SizedBox(
        height: widget.height * 1.5,
        width: widget.height * 1.5,
      ),
    );
  }
}
