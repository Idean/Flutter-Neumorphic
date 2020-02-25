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
            height: 10,
            percent: 0.55,
            style: ProgressStyle(depth: 15),
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
            style: ProgressStyle(depth: 15),
          ),
        ),
        SizedBox(width: 12),
      ],
    );
  }

  Widget _buildRadios() {
    return Row(
      children: <Widget>[
        Text("Radiu"),
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

  @override
  Widget build(BuildContext context) {
    return NeumorphicThemeProvider(
      theme: NeumorphicTheme(
        baseColor: NeumorphicColors.background,
        lightSource: LightSource.topLeft,
        curveFactor: 1,
        depth: 3,
        intensity: 0.5,
      ),
      child: Scaffold(
        backgroundColor: NeumorphicColors.background,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text("Widgets", style: Theme.of(context).textTheme.display1),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                _buildProgress(),
                SizedBox(height: 12),
                _buildIndeterminateProgress(),
                SizedBox(height: 30),
                _buildRadios(),
                SizedBox(height: 30),
                _buildIndicators(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
