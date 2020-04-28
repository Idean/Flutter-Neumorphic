import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class CalculatorSample extends StatefulWidget {
  @override
  createState() => _CalculatorSampleState();
}

final Color _calcTextColor = Color(0xFF484848);

class _CalculatorSampleState extends State<CalculatorSample> {
  @override
  Widget build(BuildContext context) {
    return NeumorphicTheme(
      theme: NeumorphicThemeData(
        baseColor: Color(0xFFF4F5F5),
        intensity: 0.3,
        lightSource: LightSource.topLeft,
        variantColor: Colors.red,
        depth: 4,
      ),
      child: Scaffold(
        body: SafeArea(
          child: NeumorphicBackground(child: _PageContent()),
        ),
      ),
    );
  }
}

class _PageContent extends StatefulWidget {
  @override
  __PageContentState createState() => __PageContentState();
}

class CalcButton {
  final String label;
  final bool textAccent;
  final bool textVariant;
  final bool backgroundAccent;

  CalcButton(
    this.label, {
    this.textAccent = false,
    this.backgroundAccent = false,
    this.textVariant = false,
  });
}

class WidgetCalcButton extends StatelessWidget {
  final CalcButton button;

  WidgetCalcButton(this.button);

  Color _textColor(BuildContext context) {
    if (button.backgroundAccent) {
      return Colors.white;
    } else if (button.textAccent) {
      return NeumorphicTheme.accentColor(context);
    } else if (button.textVariant) {
      return NeumorphicTheme.variantColor(context);
    } else {
      return _calcTextColor;
    }
  }

  Color _backgroundColor(BuildContext context) {
    return button.backgroundAccent ? NeumorphicTheme.accentColor(context) : null;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 14),
      child: NeumorphicButton(
        onClick: () {},
        boxShape: NeumorphicBoxShape.circle(),
        style: NeumorphicStyle(
          surfaceIntensity: 0.15,
          shape: NeumorphicShape.concave,
          color: _backgroundColor(context),
        ),
        child: Center(
          child: Text(
            button.label,
            style: TextStyle(fontSize: 24, color: _textColor(context)),
          ),
        ),
      ),
    );
  }
}

class _TopScreenWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
      style: NeumorphicStyle(depth: -1 * NeumorphicTheme.of(context).current.depth),
      child: FractionallySizedBox(
        widthFactor: 1,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text(
                "3 x 7 =",
                style: TextStyle(fontSize: 30, color: _calcTextColor),
              ),
              Text("21", style: TextStyle(fontSize: 56, color: _calcTextColor)),
            ],
          ),
        ),
      ),
    );
  }
}

class __PageContentState extends State<_PageContent> {
  final buttons = [
    CalcButton("%", textAccent: true),
    CalcButton("^", textAccent: true),
    CalcButton("sqrt", textAccent: true),
    CalcButton("C", textVariant: true),
    //----
    CalcButton("7"),
    CalcButton("8"),
    CalcButton("9"),
    CalcButton("/", textAccent: true),
    //----
    CalcButton("4"),
    CalcButton("5"),
    CalcButton("6"),
    CalcButton("X", textAccent: true),
    //----
    CalcButton("1"),
    CalcButton("2"),
    CalcButton("3"),
    CalcButton("-", textAccent: true),
    //----
    CalcButton("0"),
    CalcButton("."),
    CalcButton("=", backgroundAccent: true),
    CalcButton("+", textAccent: true),
  ];

  @override
  Widget build(BuildContext context) {
    return NeumorphicBackground(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 18.0, top: 8),
              child: NeumorphicButton(
                onClick: () {
                  Navigator.of(context).pop();
                },
                style: NeumorphicStyle(shape: NeumorphicShape.flat),
                boxShape: NeumorphicBoxShape.circle(),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Icon(Icons.navigate_before),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: _TopScreenWidget(),
            ),
          ),
          Expanded(
            flex: 2,
            child: GridView.count(
              // Create a grid with 2 columns. If you change the scrollDirection to
              // horizontal, this produces 2 rows.
              crossAxisCount: 4,
              padding: const EdgeInsets.only(left: 40, right: 40.0),
              // Generate 100 widgets that display their index in the List.
              children: List.generate(buttons.length, (index) {
                return WidgetCalcButton(buttons[index]);
              }),
            ),
          ),
          Row(
            children: <Widget>[
              RaisedButton(
                onPressed: (){
                  setState(() {
                    NeumorphicTheme.of(context).updateCurrentTheme(NeumorphicThemeData(
                      depth: 1,
                      intensity: 0.5,
                      accentColor: Colors.cyan,
                    ));
                  });
                },
                child: Text("style 1",),
              ),
              RaisedButton(
                onPressed: (){
                  setState(() {
                    NeumorphicTheme.of(context).updateCurrentTheme(NeumorphicThemeData(
                      depth: 8,
                      intensity: 0.3,
                      accentColor: Colors.greenAccent,
                    ));
                  });
                },
                child: Text("style 2",),
              ),
            ],
          )
        ],
      ),
    );
  }
}
