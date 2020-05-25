import 'package:flutter/material.dart' as material;
import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic/src/decoration/neumorphic_text_decorations.dart';

import '../../flutter_neumorphic.dart';
import '../theme/neumorphic_theme.dart';

export '../decoration/neumorphic_decorations.dart';
export '../neumorphic_box_shape.dart';
export '../theme/neumorphic_theme.dart';

@immutable
class NeumorphicText extends StatelessWidget {
  final String text;
  final NeumorphicStyle style;
  final TextAlign textAlign;
  final TextStyle textStyle;
  final Curve curve;
  final Duration duration;

  NeumorphicText(
    this.text, {
    Key key,
    this.duration = Neumorphic.DEFAULT_DURATION,
    this.curve = Neumorphic.DEFAULT_CURVE,
    this.style,
    this.textAlign = TextAlign.center,
    this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = NeumorphicTheme.currentTheme(context);
    final NeumorphicStyle style = (this.style ?? NeumorphicStyle())
        .copyWithThemeIfNull(theme)
        .applyDisableDepth();

    return _NeumorphicText(
      textStyle: this.textStyle,
      textAlign: this.textAlign,
      text: this.text,
      duration: this.duration,
      style: style,
      curve: this.curve,
    );
  }
}

class _NeumorphicText extends material.StatefulWidget {
  final String text;

  final NeumorphicStyle style;
  final TextStyle textStyle;
  final Duration duration;
  final Curve curve;

  final TextAlign textAlign;

  _NeumorphicText({
    Key key,
    @required this.duration,
    @required this.curve,
    @required this.textAlign,
    @required this.style,
    @required this.textStyle,
    @required this.text,
  }) : super(key: key);

  @override
  __NeumorphicTextState createState() => __NeumorphicTextState();
}

class __NeumorphicTextState extends material.State<_NeumorphicText> {
  @override
  Widget build(BuildContext context) {
    final TextPainter _textPainter = TextPainter(
        textDirection: TextDirection.ltr, textAlign: this.widget.textAlign);
    final textStyle =
        this.widget.textStyle ?? material.Theme.of(context).textTheme.bodyText2;
    _textPainter.text = TextSpan(
      text: this.widget.text,
      style: this.widget.textStyle,
    );

    return LayoutBuilder(builder: (context, constraints) {
      _textPainter.layout(minWidth: 0, maxWidth: constraints.maxWidth);
      final double width = _textPainter.width;
      final double height = _textPainter.height;

      return DefaultTextStyle(
        style: textStyle,
        child: AnimatedContainer(
          duration: this.widget.duration,
          curve: this.widget.curve,
          foregroundDecoration: NeumorphicTextDecoration(
            isForeground: true,
            textStyle: textStyle,
            textAlign: widget.textAlign,
            renderingByPath: true,
            style: this.widget.style,
            text: this.widget.text,
          ),
          child: SizedBox(
            width: width,
            height: height,
          ),
        ),
      );
    });
  }
}
