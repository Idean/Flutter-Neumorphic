import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic/container.dart';

class NeumorphicButton extends StatefulWidget {

  final Widget child;
  final NeumorphicStyle style;

  const NeumorphicButton({
    Key key,
    this.child,
    this.style = const NeumorphicStyle()
  }) : super(key: key);

  @override
  _NeumorphicButtonState createState() => _NeumorphicButtonState();
}

class _NeumorphicButtonState extends State<NeumorphicButton> {

  NeumorphicStyle initialStyle;
  double distance;

  void updateInitialStyle(){
    if(widget.style != initialStyle) {
      setState(() {
        this.initialStyle = widget.style;
        distance = widget.style.distance;
      });
    }
  }

  @override
  void initState() {
    updateInitialStyle();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    updateInitialStyle();
    super.didChangeDependencies();
  }

  void _changeDistance(){
    setState(() {
      distance = 1;
    });
  }
  void _resetDistance(){
    setState(() {
      distance =  initialStyle.distance;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (detail) {
        _changeDistance();
      },
      onTapUp: (detail) {
        _resetDistance();
      },
      onTapCancel: () {
        _resetDistance();
      },
      child: NeumorphicContainer(
          child: widget.child,
          style: initialStyle.copyWith(
            distance: this.distance
          ),
      ),
    );
  }
}
