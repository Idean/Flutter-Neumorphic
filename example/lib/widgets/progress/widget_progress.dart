import 'package:example/lib/Code.dart';
import 'package:example/lib/color_selector.dart';
import 'package:example/lib/top_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class ProgressWidgetPage extends StatefulWidget {
  ProgressWidgetPage({Key key}) : super(key: key);

  @override
  createState() => _WidgetPageState();
}

class _WidgetPageState extends State<ProgressWidgetPage> {
  @override
  Widget build(BuildContext context) {
    return NeumorphicTheme(
      usedTheme: UsedTheme.LIGHT,
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

Color _textColor(BuildContext context){
  if(NeumorphicTheme.isUsingDark(context))
    return Colors.white70;
  else {
    return Colors.black;
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
          title: "Progress",
        ),
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              _DefaultWidget(),
              _ColorWidget(),
              _SizedWidget(),
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

  double percent = 0.2;

  Widget _buildCode(BuildContext context){
    return Code("""
double percent = 0.2;  

Expanded(
  child: NeumorphicProgress(
      percent: percent,
  ),
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
            style: TextStyle(color: _textColor(context)),
          ),
          SizedBox(width: 12),
          Expanded(
            child: NeumorphicProgress(
              percent: percent,
            ),
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

  double percent = 0.5;

  Widget _buildCode(BuildContext context){
    return Code("""
double percent = 0.5;  

Expanded(
  child: NeumorphicProgress(
      style: ProgressStyle(
           accent: Colors.green,
           variant: Colors.purple,
      ),
      percent: percent,
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
                onColorChanged: (color){
                  setState(() {
                    accent = color;
                  });
                },
                color: accent,
              ),
              SizedBox(width: 12),
              Text("Variant : "),
              ColorSelector(
                onColorChanged: (color){
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
                "Default",
                style: TextStyle(color: _textColor(context)),
              ),
              SizedBox(width: 12),
              Expanded(
                child: NeumorphicProgress(
                  style: ProgressStyle(
                    accent: accent,
                    variant: variant,
                  ),
                  percent: percent,
                ),
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

class _SizedWidget extends StatefulWidget {
  @override
  createState() => _SizedWidgetState();
}

class _SizedWidgetState extends State<_SizedWidget> {

  double percent = 0.5;

  Widget _buildCode(BuildContext context){
    return Code("""
double percent = 0.5;  

Expanded(
  child: NeumorphicProgress(
      height: 30,
      percent: percent,
  ),
),
""");
  }

  Widget _buildWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12),
      child: Column(
        children: <Widget>[
          SizedBox(height: 12),
          Row(
            children: <Widget>[
              Text(
                "Sized",
                style: TextStyle(color: _textColor(context)),
              ),
              SizedBox(width: 12),
              Expanded(
                child: NeumorphicProgress(
                  height: 30,
                  percent: percent,
                ),
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