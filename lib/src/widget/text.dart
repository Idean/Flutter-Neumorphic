import 'dart:ui' as ui show FontFeature;

import 'package:flutter/material.dart' as material;
import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic/src/decoration/neumorphic_text_decorations.dart';

import '../../flutter_neumorphic.dart';
import '../theme/neumorphic_theme.dart';

export '../decoration/neumorphic_decorations.dart';
export '../neumorphic_box_shape.dart';
export '../theme/neumorphic_theme.dart';

class NeumorphicTextStyle {
  final bool inherit;
  final double fontSize;
  final FontWeight fontWeight;
  final FontStyle fontStyle;
  final double letterSpacing;
  final double wordSpacing;
  final TextBaseline textBaseline;
  final double height;
  final Locale locale;
  final List<ui.FontFeature> fontFeatures;
  final TextDecoration decoration;
  final String debugLabel;
  final String fontFamily;
  final List<String> fontFamilyFallback;
  final String package;
  //final Color color;
  //final Color backgroundColor;
  //final Paint foreground,
  //final Paint background,
  //final TextDecoration decoration,
  //final Color decorationColor;
  //final TextDecorationStyle decorationStyle;
  //final double decorationThickness;

  TextStyle get textStyle => TextStyle(
        inherit: inherit,
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontStyle: fontStyle,
        letterSpacing: letterSpacing,
        wordSpacing: wordSpacing,
        textBaseline: textBaseline,
        height: height,
        locale: locale,
        fontFeatures: fontFeatures,
        decoration: decoration,
        debugLabel: debugLabel,
        fontFamily: fontFamily,
        fontFamilyFallback: fontFamilyFallback,
        package: package,
        //color: color,
        //backgroundColor: backgroundColor,
        //foreground: foreground,
        //background: background,
        //decoration: decoration,
        //decorationColor: decorationColor,
        //decorationStyle: decorationStyle,
        //decorationThickness: decorationThickness,
      );

  /// Creates a text style.
  ///
  /// The `package` argument must be non-null if the font family is defined in a
  /// package. It is combined with the `fontFamily` argument to set the
  /// [fontFamily] property.
  NeumorphicTextStyle({
    this.inherit = true,
    this.fontSize,
    this.fontWeight,
    this.fontStyle,
    this.letterSpacing,
    this.wordSpacing,
    this.textBaseline,
    this.height,
    this.locale,
    this.fontFeatures,
    this.decoration,
    this.debugLabel,
    this.fontFamily,
    //this.color,
    //this.backgroundColor,
    //this.foreground,
    //this.background,
    //this.decoration,
    //this.decorationColor,
    //this.decorationStyle,
    //this.decorationThickness,
    this.fontFamilyFallback,
    this.package,
  });

  NeumorphicTextStyle copyWith({
    bool inherit,
    String fontFamily,
    List<String> fontFamilyFallback,
    double fontSize,
    FontWeight fontWeight,
    FontStyle fontStyle,
    double letterSpacing,
    double wordSpacing,
    TextBaseline textBaseline,
    double height,
    Locale locale,
    List<ui.FontFeature> fontFeatures,
    String debugLabel,
    //Color color,
    //Color backgroundColor,
    //Paint foreground,
    //Paint background,
    //TextDecoration decoration,
    //Color decorationColor,
    //TextDecorationStyle decorationStyle,
    //double decorationThickness,
  }) {
    return NeumorphicTextStyle(
      inherit: inherit ?? this.inherit,
      fontFamily: fontFamily ?? this.fontFamily,
      fontFamilyFallback: fontFamilyFallback ?? this.fontFamilyFallback,
      fontSize: fontSize ?? this.fontSize,
      fontWeight: fontWeight ?? this.fontWeight,
      fontStyle: fontStyle ?? this.fontStyle,
      letterSpacing: letterSpacing ?? this.letterSpacing,
      wordSpacing: wordSpacing ?? this.wordSpacing,
      textBaseline: textBaseline ?? this.textBaseline,
      height: height ?? this.height,
      locale: locale ?? this.locale,
      fontFeatures: fontFeatures ?? this.fontFeatures,
      debugLabel: debugLabel ?? this.debugLabel,
      //color: this.foreground == null && foreground == null ? color ?? this.color : null,
      //backgroundColor: this.background == null && background == null ? backgroundColor ?? this.backgroundColor : null,
      //foreground: foreground ?? this.foreground,
      //background: background ?? this.background,
      //shadows: shadows ?? this.shadows,
      //decoration: decoration ?? this.decoration,
      //decorationColor: decorationColor ?? this.decorationColor,
      //decorationStyle: decorationStyle ?? this.decorationStyle,
      //decorationThickness: decorationThickness ?? this.decorationThickness,
    );
  }
}

@immutable
class NeumorphicText extends StatelessWidget {
  final String text;
  final NeumorphicStyle style;
  final TextAlign textAlign;
  final NeumorphicTextStyle textStyle;
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
      textStyle: (this.textStyle ?? NeumorphicTextStyle()).textStyle,
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
