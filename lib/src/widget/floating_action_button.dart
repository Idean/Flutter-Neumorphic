import '../../flutter_neumorphic.dart';

const BoxConstraints _kSizeConstraints = BoxConstraints.tightFor(
  width: 56.0,
  height: 56.0,
);

const BoxConstraints _kMiniSizeConstraints = BoxConstraints.tightFor(
  width: 40.0,
  height: 40.0,
);

class NeumorphicFloatingActionButton extends StatelessWidget {
  final Widget child;
  final NeumorphicButtonClickListener onPressed;
  final bool mini;
  final String tooltip;
  final NeumorphicStyle style;

  const NeumorphicFloatingActionButton({
    Key key,
    this.mini = false,
    this.style,
    this.tooltip,
    @required this.child,
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: this.mini ? _kMiniSizeConstraints : _kSizeConstraints,
      child: NeumorphicButton(
        padding: EdgeInsets.all(0),
        onPressed: this.onPressed,
        tooltip: this.tooltip,
        style: this.style ??
            NeumorphicTheme.currentTheme(context).appBarTheme.buttonStyle,
        child: this.child,
      ),
    );
  }
}
