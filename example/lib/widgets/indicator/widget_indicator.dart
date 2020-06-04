import 'package:example/lib/Code.dart';
import 'package:example/lib/ThemeConfigurator.dart';
import 'package:example/lib/color_selector.dart';
import 'package:example/lib/top_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'dart:math' show Random;

class IndicatorWidgetPage extends StatefulWidget {
  IndicatorWidgetPage({Key key}) : super(key: key);

  @override
  createState() => _WidgetPageState();
}

class _WidgetPageState extends State<IndicatorWidgetPage> {
  @override
  Widget build(BuildContext context) {
    return NeumorphicTheme(
      themeMode: ThemeMode.light,
      theme: NeumorphicThemeData(
        lightSource: LightSource.topLeft,
        accentColor: NeumorphicColors.accent,
        depth: 4,
        intensity: 0.5,
      ),
      child: _Page(),
    );
  }
}

class _Page extends StatefulWidget {
  @override
  createState() => _PageState();
}

class _PageState extends State<_Page> {
  @override
  Widget build(BuildContext context) {
    return NeumorphicBackground(
      padding: EdgeInsets.all(8),
      child: Scaffold(
        appBar: TopBar(
          title: "Indicator",
          actions: <Widget>[
            ThemeConfigurator(),
          ],
        ),
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              _DefaultWidget(),
              _DefaultOrientationWidget(),
              _DurationWidget(),
              _ColorWidget(),
              _CurveWidget(),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}

class _DefaultWidget extends StatefulWidget {
  @override
  createState() => _DefaultWidgetState();
}

class _DefaultWidgetState extends State<_DefaultWidget> {
  double percent = 0.6;

  Widget _buildCode(BuildContext context) {
    return Code("""
NeumorphicIndicator(
    height: 100,
    width: 20,
    percent: 0.6,
),
""");
  }

  Widget _buildWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12),
      child: Row(
        children: <Widget>[
          Text(
            "Default",
            style: TextStyle(color: NeumorphicTheme.defaultTextColor(context)),
          ),
          SizedBox(width: 12),
          NeumorphicIndicator(
            height: 100,
            width: 20,
            percent: percent,
          ),
          SizedBox(width: 12),
          FlatButton(
              child: Text('Update'),
              onPressed: () {
                setState(() {
                  percent = Random().nextDouble();
                });
              }),
        ],
      ),
    );
  }

  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _buildWidget(context),
        _buildCode(context),
      ],
    );
  }
}

class _DefaultOrientationWidget extends StatefulWidget {
  @override
  createState() => _DefaultOrientationWidgetState();
}

class _DefaultOrientationWidgetState extends State<_DefaultOrientationWidget> {
  Widget _buildCode(BuildContext context) {
    return Code("""
NeumorphicIndicator(
     width: 150,
     height: 15,
     orientation: NeumorphicIndicatorOrientation.horizontal,
     percent: 0.7,
),
""");
  }

  Widget _buildWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12),
      child: Row(
        children: <Widget>[
          Text(
            "Orientation\nHorizontal",
            style: TextStyle(color: NeumorphicTheme.defaultTextColor(context)),
          ),
          SizedBox(width: 12),
          NeumorphicIndicator(
            width: 150,
            height: 15,
            orientation: NeumorphicIndicatorOrientation.horizontal,
            percent: 0.7,
          ),
          SizedBox(width: 12),
        ],
      ),
    );
  }

  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _buildWidget(context),
        _buildCode(context),
      ],
    );
  }
}

class _ColorWidget extends StatefulWidget {
  @override
  createState() => _ColorWidgetState();
}

class _ColorWidgetState extends State<_ColorWidget> {
  Widget _buildCode(BuildContext context) {
    return Code("""
NeumorphicIndicator(
      width: 150,
      height: 15,
      orientation: NeumorphicIndicatorOrientation.horizontal,
      percent: 0.7,
      style: IndicatorStyle(
        variant: variant,
        accent: accent
      ),
),
""");
  }

  Color accent = Colors.green;
  Color variant = Colors.purple;

  Widget _buildWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Text("Accent : "),
              ColorSelector(
                onColorChanged: (color) {
                  setState(() {
                    accent = color;
                  });
                },
                color: accent,
              ),
              SizedBox(width: 12),
              Text("Variant : "),
              ColorSelector(
                onColorChanged: (color) {
                  setState(() {
                    variant = color;
                  });
                },
                color: variant,
              ),
            ],
          ),
          SizedBox(height: 12),
          Row(
            children: <Widget>[
              Text(
                "Colorized",
                style:
                    TextStyle(color: NeumorphicTheme.defaultTextColor(context)),
              ),
              SizedBox(width: 12),
              NeumorphicIndicator(
                width: 150,
                height: 15,
                orientation: NeumorphicIndicatorOrientation.horizontal,
                percent: 0.7,
                style: IndicatorStyle(variant: variant, accent: accent),
              ),
              SizedBox(width: 12),
            ],
          ),
        ],
      ),
    );
  }

  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _buildWidget(context),
        _buildCode(context),
      ],
    );
  }
}

class _DurationWidget extends StatefulWidget {
  @override
  createState() => _DurationWidgetState();
}

class _DurationWidgetState extends State<_DurationWidget> {
  double percent = 0.3;

  Widget _buildCode(BuildContext context) {
    return Code("""
NeumorphicIndicator(
    height: 100,
    width: 20,
    percent: 0.3,
    duration: Duration(seconds: 1),
),
""");
  }

  Widget _buildWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12),
      child: Row(
        children: <Widget>[
          Text(
            "Duration",
            style: TextStyle(color: NeumorphicTheme.defaultTextColor(context)),
          ),
          SizedBox(width: 12),
          NeumorphicIndicator(
            height: 100,
            width: 20,
            percent: percent,
            duration: Duration(seconds: 1),
          ),
          SizedBox(width: 12),
          FlatButton(
              child: Text('Update'),
              onPressed: () {
                setState(() {
                  percent = Random().nextDouble();
                });
              }),
        ],
      ),
    );
  }

  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _buildWidget(context),
        _buildCode(context),
      ],
    );
  }
}

class _CurveWidget extends StatefulWidget {
  @override
  createState() => _CurveWidgetState();
}

class _CurveWidgetState extends State<_CurveWidget> {
  double percent = 0.3;

  Widget _buildCode(BuildContext context) {
    return Code("""
NeumorphicIndicator(
    height: 100,
    width: 20,
    percent: 0.3,
    curve: Curves.bounceOut,
),
""");
  }

  Widget _buildWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12),
      child: Row(
        children: <Widget>[
          Text(
            "Curve",
            style: TextStyle(color: NeumorphicTheme.defaultTextColor(context)),
          ),
          SizedBox(width: 12),
          NeumorphicIndicator(
            height: 100,
            width: 20,
            percent: percent,
            curve: Curves.bounceOut
          ),
          SizedBox(width: 12),
          FlatButton(
              child: Text('Update'),
              onPressed: () {
                setState(() {
                  percent = Random().nextDouble();
                });
              }),
        ],
      ),
    );
  }

  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _buildWidget(context),
        _buildCode(context),
      ],
    );
  }
}