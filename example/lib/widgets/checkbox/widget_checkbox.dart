import 'package:example/lib/Code.dart';
import 'package:example/lib/color_selector.dart';
import 'package:example/lib/top_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class CheckboxWidgetPage extends StatefulWidget {
  CheckboxWidgetPage({Key key}) : super(key: key);

  @override
  createState() => _WidgetPageState();
}

class _WidgetPageState extends State<CheckboxWidgetPage> {
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
          title: "Checkbox",
        ),
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              DefaultCheckboxes(),
              ColorCheckboxes(),
              EnabledDisabledCheckboxes(),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}

class DefaultCheckboxes extends StatefulWidget {
  @override
  createState() => _DefaultCheckboxesState();
}

class _DefaultCheckboxesState extends State<DefaultCheckboxes> {

  bool check1 = false;
  bool check2 = false;
  bool check3 = false;

  Widget _buildCode(BuildContext context){
    return Code("""
    
bool isChecked = false;  

NeumorphicCheckbox(
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
          NeumorphicCheckbox(
            value: check1,
            onChanged: (value) {
              setState(() {
                check1 = value;
              });
            },
          ),
          SizedBox(width: 12),
          NeumorphicCheckbox(
            value: check2,
            onChanged: (value) {
              setState(() {
                check2 = value;
              });
            },
          ),
          SizedBox(width: 12),
          NeumorphicCheckbox(
            value: check3,
            onChanged: (value) {
              setState(() {
                check3 = value;
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


class ColorCheckboxes extends StatefulWidget {
  @override
  createState() => _ColorCheckboxesState();
}

class _ColorCheckboxesState extends State<ColorCheckboxes> {

  Color customColor = Colors.green;

  bool checkColor1 = false;
  bool checkColor2 = false;
  bool checkColor3 = false;

  Widget _buildWidget(BuildContext context){
    return Padding(
      padding: EdgeInsets.all(12),
      child: Row(
        children: <Widget>[
          Text(
            "Colorizable",
            style: TextStyle(color: _textColor(context)),
          ),
          SizedBox(width: 12),
          ColorSelector(
            color: customColor,
            onColorChanged: (color){
              setState(() {
                customColor = color;
              });
            },
          ),
          SizedBox(width: 12),
          NeumorphicCheckbox(
            style: NeumorphicCheckboxStyle(
                selectedColor: customColor
            ),
            value: checkColor1,
            onChanged: (value) {
              setState(() {
                checkColor1 = value;
              });
            },
          ),
          SizedBox(width: 12),
          NeumorphicCheckbox(
            style: NeumorphicCheckboxStyle(
                selectedColor: customColor
            ),
            value: checkColor2,
            onChanged: (value) {
              setState(() {
                checkColor2 = value;
              });
            },
          ),
          SizedBox(width: 12),
          NeumorphicCheckbox(
            value: checkColor3,
            style: NeumorphicCheckboxStyle(
                selectedColor: customColor
            ),
            onChanged: (value) {
              setState(() {
                checkColor3 = value;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCode(BuildContext context){
    return Code("""
    
bool isChecked = false;  

NeumorphicCheckbox(
    value: isChecked,
    style: NeumorphicCheckboxStyle(
        selectedColor: Colors.green,
    ),
    onChanged: (value) {
        setState(() {
          isChecked = value;
        });
    },
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


class EnabledDisabledCheckboxes extends StatefulWidget {
  @override
  createState() => _EnabledDisabledCheckboxesState();
}

class _EnabledDisabledCheckboxesState extends State<EnabledDisabledCheckboxes> {

  bool check1 = false;
  bool check2 = false;

  Widget _buildWidget(BuildContext context){
    return Padding(
      padding: EdgeInsets.all(12),
      child: Row(
        children: <Widget>[
          Text(
            "Enabled",
            style: TextStyle(color: _textColor(context)),
          ),
          SizedBox(width: 12),
          NeumorphicCheckbox(
            value: check1,
            onChanged: (value) {
              setState(() {
                check1 = value;
              });
            },
          ),
          SizedBox(width: 24),
          Text(
            "Disabled",
            style: TextStyle(color: _textColor(context)),
          ),
          SizedBox(width: 12),
          NeumorphicCheckbox(
            isEnabled: false,
            value: check2,
            onChanged: (value) {
              setState(() {
                check2 = value;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCode(BuildContext context){
    return Code("""
    
bool isChecked = false;  

NeumorphicCheckbox(
     isEnabled: false,
     value: isChecked,
     onChanged: (value) {
       setState(() {
         isChecked = value;
       });
     },
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
