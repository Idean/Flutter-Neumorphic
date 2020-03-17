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
              ColorizableSwitch(),
              ColorizableThumbSwitch(),
              FlatConcaveConvexSwitch(),
              EnabledDisabledSwitch(),
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
         //or convex, concave
    ),
    onChanged: (value) {
        setState(() {
          isChecked = value;
        });
    },
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
          SizedBox(height: 12),
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
          SizedBox(height: 12),
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

class ColorizableSwitch extends StatefulWidget {
  @override
  createState() => _ColorizableSwitchState();
}

class _ColorizableSwitchState extends State<ColorizableSwitch> {

  bool isChecked = false;
  Color currentColor = Colors.green;

  Widget _buildCode(BuildContext context){
    return Code("""
bool isChecked;

NeumorphicSwitch(
    value: isChecked,
    style: NeumorphicSwitchStyle(
        activeTrackColor: Colors.green
    ),
    onChanged: (value) {
        setState(() {
          isChecked = value;
        });
    },
),
""");
  }

  Widget _buildWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12),
      child: Row(
        children: <Widget>[
          Text(
            "Color",
            style: TextStyle(color: _textColor(context)),
          ),
          SizedBox(width: 12),
          ColorSelector(
            color: currentColor,
            onColorChanged: (color){
              setState(() {
                currentColor = color;
              });
            },
          ),
          SizedBox(width: 12),
          NeumorphicSwitch(
            value: isChecked,
            style: NeumorphicSwitchStyle(
              activeTrackColor: currentColor
            ),
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

class ColorizableThumbSwitch extends StatefulWidget {
  @override
  createState() => _ColorizableThumbSwitchState();
}

class _ColorizableThumbSwitchState extends State<ColorizableThumbSwitch> {

  bool isChecked = false;
  Color thumbColor = Colors.purple;
  Color trackColor = Colors.lightGreen;

  Widget _buildCode(BuildContext context){
    return Code("""
bool isChecked;

NeumorphicSwitch(
    value: isChecked,
    style: NeumorphicSwitchStyle(
          activeTrackColor: Colors.lightGreen,
          activeThumbColor: Colors.purple
    ),
    onChanged: (value) {
        setState(() {
          isChecked = value;
        });
    },
),
""");
  }

  Widget _buildWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12),
      child: Row(
        children: <Widget>[
          Text(
            "Track",
            style: TextStyle(color: _textColor(context)),
          ),
          SizedBox(width: 12),
          ColorSelector(
            color: trackColor,
            onColorChanged: (color){
              setState(() {
                trackColor = color;
              });
            },
          ),
          SizedBox(width: 12),
          Text(
            "Thumb",
            style: TextStyle(color: _textColor(context)),
          ),
          SizedBox(width: 12),
          ColorSelector(
            color: thumbColor,
            onColorChanged: (color){
              setState(() {
                thumbColor = color;
              });
            },
          ),
          SizedBox(width: 12),
          NeumorphicSwitch(
            value: isChecked,
            style: NeumorphicSwitchStyle(
                activeTrackColor: trackColor,
                activeThumbColor: thumbColor
            ),
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

class EnabledDisabledSwitch extends StatefulWidget {
  @override
  _EnabledDisabledSwitchState createState() => _EnabledDisabledSwitchState();
}

class _EnabledDisabledSwitchState extends State<EnabledDisabledSwitch> {

  bool isChecked1 = false;
  bool isChecked2 = false;

  Widget _buildCode(BuildContext context){
    return Code("""
bool isChecked;

NeumorphicSwitch(
    value: isChecked,
    isEnabled: false,
    onChanged: (value) {
        setState(() {
          isChecked = value;
        });
    },
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
              Container(
                width: 100,
                child: Text(
                  "Enabled",
                  style: TextStyle(color: _textColor(context)),
                ),
              ),
              SizedBox(width: 12),
              NeumorphicSwitch(
                style: NeumorphicSwitchStyle(
                    thumbShape: NeumorphicShape.concave
                ),
                value: isChecked1,
                onChanged: (value) {
                  setState(() {
                    isChecked1 = value;
                  });
                },
              ),
            ],
          ),
          SizedBox(height: 12),
          Row(
            children: <Widget>[
              Container(
                width: 100,
                child: Text(
                  "Disabled",
                  style: TextStyle(color: _textColor(context)),
                ),
              ),
              SizedBox(width: 12),
              NeumorphicSwitch(
                isEnabled: false,
                style: NeumorphicSwitchStyle(
                    thumbShape: NeumorphicShape.convex
                ),
                value: isChecked2,
                onChanged: (value) {
                  setState(() {
                    isChecked2 = value;
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
