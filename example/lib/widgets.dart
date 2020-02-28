import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class WidgetsPage extends StatefulWidget {
  WidgetsPage({Key key}) : super(key: key);

  @override
  createState() => _ContainersListPageState();
}

class _ContainersListPageState extends State<WidgetsPage> {
  int _groupValue;

  Widget _buildProgress() {
    return Row(
      children: <Widget>[
        Text("Progress"),
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
        Text("Progress"),
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

  Widget _buildRadios() {
    return Row(
      children: <Widget>[
        Text("Radio"),
        SizedBox(width: 12),
        NeumorphicRadio(
          child: SizedBox(
            height: 50,
            width: 50,
            child: Center(
              child: Text("1"),
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
              child: Text("2"),
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
              child: Text("3"),
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
        Text("Checkbox"),
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

  Widget _buildSeekbar() {
    return Row(
      children: <Widget>[
        Text("Seekbar"),
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
        Text("value: ${seekValue.round()}"),
        SizedBox(width: 12),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return NeumorphicThemeProvider(
      theme: NeumorphicTheme(
        baseColor: NeumorphicColors.background,
        lightSource: LightSource.topLeft,
        curveFactor: 1,
        depth: 5,
        intensity: 0.5,
      ),
      child: Scaffold(
        backgroundColor: NeumorphicColors.background,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
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
                    _buildRadios(),
                    SizedBox(height: 30),
                    _buildIndicators(),
                    SizedBox(height: 30),
                    _buildChecks(),
                    SizedBox(height: 30),
                    _buildSeekbar(),
                    SizedBox(height: 30),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
