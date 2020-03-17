import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class WidgetsSample extends StatefulWidget {
  WidgetsSample({Key key}) : super(key: key);

  @override
  createState() => _ContainersListPageState();
}

class _ContainersListPageState extends State<WidgetsSample> {
  int _groupValue;
  bool _switchConcaveEnabled = false;
  bool _switchConvexEnabled = false;
  bool _switchFlatEnabled = false;

  bool useDark = false;

  Color _textColor(){
    if(useDark)
      return Colors.white70;
    else {
      return Colors.black;
    }
  }

  Widget _buildProgress() {
    return Row(
      children: <Widget>[
        Text("Progress", style: TextStyle(color: _textColor()),),
        SizedBox(width: 12),
        Flexible(
          child: NeumorphicProgress(
            height: 15,
            percent: 0.55,
          ),
        ),
        SizedBox(width: 12),
      ],
    );
  }

  Widget _buildIndeterminateProgress() {
    return Row(
      children: <Widget>[
        Text("Progress", style: TextStyle(color: _textColor()),),
        SizedBox(width: 12),
        Flexible(
          child: NeumorphicProgressIndeterminate(
            height: 10,
          ),
        ),
        SizedBox(width: 12),
      ],
    );
  }

  Widget _buildButtons() {
    return Row(
      children: <Widget>[
        Text("Buttons", style: TextStyle(color: _textColor()),),
        SizedBox(width: 4),
        NeumorphicButton(
          boxShape: NeumorphicBoxShape.stadium(),
          style: NeumorphicStyle(shape: NeumorphicShape.flat),
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 18),
          child: Text("button 1", style: TextStyle(color: _textColor()),),
          onClick:() {
            setState(() {
              useDark = !useDark;
            });
          },
        ),
        SizedBox(width: 10),
        NeumorphicButton(
          boxShape: NeumorphicBoxShape.stadium(),
          style: NeumorphicStyle(shape: NeumorphicShape.flat),
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 18),
          child: Text("button 2", style: TextStyle(color: _textColor()),),
          onClick:() {
          },
        ),
      ],
    );
  }

  Widget _buildRadios() {
    return Row(
      children: <Widget>[
        Text("Radio", style: TextStyle(color: _textColor()),),
        SizedBox(width: 12),
        NeumorphicRadio(
          child: SizedBox(
            height: 50,
            width: 50,
            child: Center(
              child: Text("1", style: TextStyle(color: _textColor()),),
            ),
          ),
          value: 1,
          groupValue: _groupValue,
          onChanged: (value) {
            setState(() {
              _groupValue = value;
            });
          },
        ),
        SizedBox(width: 12),
        NeumorphicRadio(
          child: SizedBox(
            height: 50,
            width: 50,
            child: Center(
              child: Text("2", style: TextStyle(color: _textColor()),),
            ),
          ),
          value: 2,
          groupValue: _groupValue,
          onChanged: (value) {
            setState(() {
              _groupValue = value;
            });
          },
        ),
        SizedBox(width: 12),
        NeumorphicRadio(
          child: SizedBox(
            height: 50,
            width: 50,
            child: Center(
              child: Text("3", style: TextStyle(color: _textColor()),),
            ),
          ),
          value: 3,
          groupValue: _groupValue,
          onChanged: (value) {
            setState(() {
              _groupValue = value;
            });
          },
        ),
      ],
    );
  }

  bool check1 = false;
  bool check2 = false;
  bool check3 = false;

  Widget _buildChecks() {
    return Row(
      children: <Widget>[
        Text("Checkbox", style: TextStyle(color: _textColor()),),
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

  Widget _buildIndicators() {
    final width = 14.0;
    return SizedBox(
      height: 130,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          NeumorphicIndicator(
            width: width,
            percent: 0.4,
          ),
          SizedBox(width: 10),
          NeumorphicIndicator(
            width: width,
            percent: 0.2,
          ),
          SizedBox(width: 10),
          NeumorphicIndicator(
            width: width,
            percent: 0.5,
          ),
          SizedBox(width: 10),
          NeumorphicIndicator(
            width: width,
            percent: 1,
          ),
          SizedBox(width: 10),
          NeumorphicIndicator(
            width: width,
            percent: 0.4,
          ),
          SizedBox(width: 10),
          NeumorphicIndicator(
            width: width,
            percent: 0.2,
          ),
          SizedBox(width: 10),
          NeumorphicIndicator(
            width: width,
            percent: 0.5,
          ),
          SizedBox(width: 10),
          NeumorphicIndicator(
            width: width,
            percent: 1,
          ),
        ],
      ),
    );
  }

  double seekValue = 0;

  Widget _buildSlider() {
    return Row(
      children: <Widget>[
        Text("Slider", style: TextStyle(color: _textColor()),),
        SizedBox(width: 12),
        Flexible(
          child: NeumorphicSlider(
              height: 15,
              value: seekValue,
              min: 0,
              max: 10,
              onChanged: (value) {
                setState(() {
                  seekValue = value;
                });
              }),
        ),
        SizedBox(width: 12),
        Text("value: ${seekValue.round()}", style: TextStyle(color: _textColor()),),
        SizedBox(width: 12),
      ],
    );
  }

  Widget _buildSwitches() {
    return Row(children: <Widget>[
      Text("Switch", style: TextStyle(color: _textColor()),),
      SizedBox(width: 15),
      NeumorphicSwitch(
        value: _switchConcaveEnabled,
        style: NeumorphicSwitchStyle(
          thumbShape: NeumorphicShape.concave, // concave or flat with elevation
        ),
        onChanged: (value) {
          setState(() {
            _switchConcaveEnabled = value;
          });
        },
      ),
      SizedBox(width: 15),
      NeumorphicSwitch(
        value: _switchFlatEnabled,
        style: NeumorphicSwitchStyle(
          thumbShape: NeumorphicShape.flat, // concave or flat with elevation
        ),
        onChanged: (value) {
          setState(() {
            _switchFlatEnabled = value;
          });
        },
      ),
      SizedBox(width: 15),
      NeumorphicSwitch(
        value: _switchConvexEnabled,
        style: NeumorphicSwitchStyle(
          thumbShape: NeumorphicShape.convex,
        ),
        onChanged: (value) {
          setState(() {
            _switchConvexEnabled = value;
          });
        },
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return NeumorphicTheme(
      usedTheme: useDark ? UsedTheme.DARK : UsedTheme.LIGHT,
      darkTheme: NeumorphicThemeData(
        baseColor: NeumorphicColors.darkBackground,
        accentColor: NeumorphicColors.darkAccent,
        lightSource: LightSource.topLeft,
        depth: 6,
        intensity: 0.3,
      ),
      theme: NeumorphicThemeData(
        baseColor: NeumorphicColors.background,
        lightSource: LightSource.topLeft,
        depth: 10,
        intensity: 0.5,
      ),
      child: Scaffold(
        body: FractionallySizedBox(
          //match parent height
          heightFactor: 1,
          child: NeumorphicBackground(
            //margin: EdgeInsets.all(10),
            //borderRadius: BorderRadius.circular(40),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Stack(
                    children: <Widget>[
                      Neumorphic(
                        child: AppBar(
                          iconTheme: IconThemeData.fallback(),
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                          title: Text(
                            "Widgets",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        style: NeumorphicStyle(depth: -8),
                      ),
                      /*
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: NeumorphicButton(
                          onClick: (){
                            setState(() {
                              useDark = !useDark;
                            });
                          },
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                          child: Text(useDark ? "Dark" : "Light"),
                        ),
                      )
                       */
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        SizedBox(height: 30),
                        _buildProgress(),
                        SizedBox(height: 12),
                        _buildIndeterminateProgress(),
                        SizedBox(height: 30),
                        _buildButtons(),
                        SizedBox(height: 30),
                        _buildRadios(),
                        SizedBox(height: 30),
                        _buildIndicators(),
                        SizedBox(height: 30),
                        _buildChecks(),
                        SizedBox(height: 30),
                        _buildSlider(),
                        SizedBox(height: 30),
                        _buildSwitches(),
                        SizedBox(height: 30),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
