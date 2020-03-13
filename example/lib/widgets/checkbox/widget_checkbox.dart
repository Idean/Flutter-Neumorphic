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
      usedTheme: UsedTheme.SYSTEM,
      theme: NeumorphicThemeData(
        lightSource: LightSource.topLeft,
        accentColor: NeumorphicColors.accent,
        depth: 8,
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
  bool check1 = false;
  bool check2 = false;
  bool check3 = false;

  Widget _buildCheckboxes(BuildContext context) {
    return Row(
      children: <Widget>[
        Text(
          "Checkbox",
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
    );
  }

  Color _textColor(BuildContext context){
    if(NeumorphicTheme.isUsingDark(context))
      return Colors.white70;
    else {
      return Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: NeumorphicBackground(
        padding: EdgeInsets.all(8),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                TopBar(
                  title: "Checkbox",
                ),
                _buildCheckboxes(context),
                SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
