import 'package:example/lib/Code.dart';
import 'package:example/lib/color_selector.dart';
import 'package:example/lib/top_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class RadioButtonWidgetPage extends StatefulWidget {
  RadioButtonWidgetPage({Key key}) : super(key: key);

  @override
  createState() => _WidgetPageState();
}

class _WidgetPageState extends State<RadioButtonWidgetPage> {
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
          title: "Radios",
        ),
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              DefaultRadios(),
              CircleRadios(),
              EnabledDisabledRadios(),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}

class DefaultRadios extends StatefulWidget {
  @override
  createState() => _DefaultRadiosState();
}

class _DefaultRadiosState extends State<DefaultRadios> {

  int groupValue;

  Widget _buildCode(BuildContext context){
    return Code("""
int groupValue;

NeumorphicRadio(
    groupValue: groupValue
    value: 1991,
    onChanged: (value) {
        setState(() {
          groupValue = value;
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
          NeumorphicRadio(
            groupValue: groupValue,
            value: 1991,
            onChanged: (value) {
              setState(() {
                groupValue = value;
              });
            },
            padding: EdgeInsets.all(8.0),
            child: Text("1991"),
          ),
          SizedBox(width: 12),
          NeumorphicRadio(
            value: 2000,
            groupValue: groupValue,
            onChanged: (value) {
              setState(() {
                groupValue = value;
              });
            },
            padding: EdgeInsets.all(8.0),
            child: Text("2000"),
          ),
          SizedBox(width: 12),
          NeumorphicRadio(
            groupValue: groupValue,
            value: 2012,
            onChanged: (value) {
              setState(() {
                groupValue = value;
              });
            },
            padding: EdgeInsets.all(8.0),
            child: Text("2012"),
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

class CircleRadios extends StatefulWidget {
  @override
  createState() => _CircleRadiosState();
}

class _CircleRadiosState extends State<CircleRadios> {

  String groupValue;

  Widget _buildCode(BuildContext context){
    return Code("""
String groupValue;

NeumorphicRadio(
    groupValue: groupValue
    style: NeumorphicRadioStyle(boxShape: NeumorphicBoxShape.circle()),
    value: "A",
    onChanged: (value) {
        setState(() {
          groupValue = value;
        });
    },
    child: Text("A"),
),
""");
  }

  Widget _buildWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12),
      child: Row(
        children: <Widget>[
          Text(
            "Circle",
            style: TextStyle(color: _textColor(context)),
          ),
          SizedBox(width: 12),
          NeumorphicRadio(
            boxShape: NeumorphicBoxShape.circle(),
            groupValue: groupValue,
            value: "A",
            onChanged: (value) {
              setState(() {
                groupValue = value;
              });
            },
            padding: EdgeInsets.all(18.0),
            child: Text("A"),
          ),
          SizedBox(width: 12),
          NeumorphicRadio(
            value: "B",
            boxShape: NeumorphicBoxShape.circle(),
            groupValue: groupValue,
            onChanged: (value) {
              setState(() {
                groupValue = value;
              });
            },
            padding: EdgeInsets.all(18.0),
            child: Text("B"),
          ),
          SizedBox(width: 12),
          NeumorphicRadio(
            boxShape: NeumorphicBoxShape.circle(),
            groupValue: groupValue,
            value: "C",
            onChanged: (value) {
              setState(() {
                groupValue = value;
              });
            },
            padding: EdgeInsets.all(18.0),
            child: Text("C"),
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



class EnabledDisabledRadios extends StatefulWidget {
  @override
  createState() => _EnabledDisabledRadiosState();
}

class _EnabledDisabledRadiosState extends State<EnabledDisabledRadios> {

  int groupValue;

  Widget _buildWidget(BuildContext context){
    return Padding(
      padding: EdgeInsets.all(12),
      child: Row(
        children: <Widget>[
          Text(
            "Enabled :",
            style: TextStyle(color: _textColor(context)),
          ),
          SizedBox(width: 12),
          NeumorphicRadio(
            groupValue: groupValue,
            value: 1,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 18),
            child: Text("First"),
            onChanged: (value) {
              setState(() {
                groupValue = value;
              });
            },
          ),
          SizedBox(width: 24),
          Text(
            "Disabled :",
            style: TextStyle(color: _textColor(context)),
          ),
          SizedBox(width: 12),
          NeumorphicRadio(
            isEnabled: false,
            groupValue: groupValue,
            value: 2,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 18),
            child: Text("Second"),
            onChanged: (value) {
              setState(() {
                groupValue = value;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCode(BuildContext context){
    return Code("""    
int groupValue;

NeumorphicRadio(
     isEnabled: false,
     groupValue: groupValue,
     value: 2,
     onChanged: (value) {
       setState(() {
         isChecked = value;
       });
     },
     child: Text("Second"),
),
""");
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
