import 'package:example/lib/Code.dart';
import 'package:example/lib/color_selector.dart';
import 'package:example/lib/top_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class SwitchWidgetPage extends StatefulWidget {
  SwitchWidgetPage({Key key}) : super(key: key);

  @override
  createState() => _WidgetPageState();
}

class _WidgetPageState extends State<SwitchWidgetPage> {
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
          title: "Switch",
        ),
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              DefaultSwitch(),
              FlatConcaveConvexSwitch(),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}

class DefaultSwitch extends StatefulWidget {
  @override
  createState() => _DefaultSwitchState();
}

class _DefaultSwitchState extends State<DefaultSwitch> {

  bool isChecked = false;

  Widget _buildCode(BuildContext context){
    return Code("""
bool isChecked;

NeumorphicSwitch(
    value: isChecked,
    onChanged: (value) {
        setState(() {
          isChecked = value;
        });
    },
    child: Text("2012"),
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
          NeumorphicSwitch(
            value: isChecked,
            onChanged: (value) {
              setState(() {
                isChecked = value;
              });
            },
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

class FlatConcaveConvexSwitch extends StatefulWidget {
  @override
  createState() => _FlatConcaveConvexSwitchState();
}

class _FlatConcaveConvexSwitchState extends State<FlatConcaveConvexSwitch> {

  bool isChecked = false;

  Widget _buildCode(BuildContext context){
    return Code("""
bool isChecked;

NeumorphicSwitch(
    value: isChecked,
    style: NeumorphicSwitchStyle(
         thumbShape: NeumorphicShape.flat
    ),
    onChanged: (value) {
        setState(() {
          isChecked = value;
        });
    },
    child: Text("2012"),
),
""");
  }

  Widget _buildWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 100,
                child: Text(
                  "Flat",
                  style: TextStyle(color: _textColor(context)),
                ),
              ),
              SizedBox(width: 12),
              NeumorphicSwitch(
                style: NeumorphicSwitchStyle(
                  thumbShape: NeumorphicShape.flat
                ),
                value: isChecked,
                onChanged: (value) {
                  setState(() {
                    isChecked = value;
                  });
                },
              )
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                width: 100,
                child: Text(
                  "Concave",
                  style: TextStyle(color: _textColor(context)),
                ),
              ),
              SizedBox(width: 12),
              NeumorphicSwitch(
                style: NeumorphicSwitchStyle(
                    thumbShape: NeumorphicShape.concave
                ),
                value: isChecked,
                onChanged: (value) {
                  setState(() {
                    isChecked = value;
                  });
                },
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                width: 100,
                child: Text(
                  "Convex",
                  style: TextStyle(color: _textColor(context)),
                ),
              ),
              SizedBox(width: 12),
              NeumorphicSwitch(
                style: NeumorphicSwitchStyle(
                    thumbShape: NeumorphicShape.convex
                ),
                value: isChecked,
                onChanged: (value) {
                  setState(() {
                    isChecked = value;
                  });
                },
              ),
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