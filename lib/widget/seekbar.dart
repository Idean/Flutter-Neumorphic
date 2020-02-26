import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

typedef void NeumorphicSeekBarListener(double percent);

@immutable
class NeumorphicSeekBar extends StatefulWidget {
  final double min;
  final double value;
  final double max;
  final double height;
  final NeumorphicSeekBarListener onChanged;
  final NeumorphicSeekBarListener onChangeStart;
  final NeumorphicSeekBarListener onChangeEnd;

  NeumorphicSeekBar({
    Key key,
    this.min = 0,
    this.value = 0,
    this.max = 10,
    this.height = 10,
    this.onChanged,
    this.onChangeStart,
    this.onChangeEnd,
  });

  @override
  createState() => _NeumorphicSeekBarState();
}

class _NeumorphicSeekBarState extends State<NeumorphicSeekBar> {

  @override
  Widget build(BuildContext context) {
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

            if(widget.onChanged != null) {
            //  print("onChanged : $newValue");
              widget.onChanged(newValue);
            }

          });
        },
        onTapUp: (details) {
          print("onTapUp");
          if(widget.onChangeEnd != null) {
            widget.onChangeEnd(widget.value);
          }
        },
        onPanCancel: (){
          print("onPanCancel");
        },
        child: NeumorphicProgress(
          percent: 1,
          height: widget.height,
        ),
      );
    });
  }
}
