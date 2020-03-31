import 'package:example/lib/ThemeConfigurator.dart';
import 'package:example/lib/top_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class ClockSample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return NeumorphicTheme(
      theme: NeumorphicThemeData(
          defaultTextColor: Color(0xFF303E57), accentColor: Color(0xFF7B79FC), variantColor: Colors.black38, baseColor: Color(0xFFF8F9FC), depth: 8, intensity: 0.5, lightSource: LightSource.topLeft),
      usedTheme: UsedTheme.LIGHT,
      child: Material(
        child: NeumorphicBackground(
          child: _ClockFirstPage(),
        ),
      ),
    );
  }
}

class _ClockFirstPage extends StatefulWidget {
  @override
  createState() => _ClockFirstPageState();
}

class _ClockFirstPageState extends State<_ClockFirstPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 9.0),
            child: TopBar(),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Clock",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 28,
                      shadows: [Shadow(color: Colors.black38, offset: Offset(1.0, 1.0), blurRadius: 2)],
                      color: NeumorphicTheme.defaultTextColor(context),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Neumorphic(
                    style: NeumorphicStyle(depth: 20, intensity: 0.4),
                    boxShape: NeumorphicBoxShape.roundRect(borderRadius: BorderRadius.circular(8)),
                    child: NeumorphicButton(
                      padding: EdgeInsets.all(12.0),
                      boxShape: NeumorphicBoxShape.roundRect(borderRadius: BorderRadius.circular(8)),
                      child: Icon(
                        Icons.add,
                        color: Color(0xFFC1CDE5),
                      ),
                      style: NeumorphicStyle(depth: -1),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Flexible(child: NeumorphicClock()),
          SizedBox(height: 30),
          Text(
            "6:21 PM",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 36,
              shadows: [Shadow(color: Colors.black38, offset: Offset(1.0, 1.0), blurRadius: 2)],
              color: NeumorphicTheme.defaultTextColor(context),
            ),
          ),
          Text(
            "London, Uk",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: NeumorphicTheme.variantColor(context),
            ),
          ),
          SizedBox(height: 20),
          NeumorphicSelector(),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}

class NeumorphicClock extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Neumorphic(
        margin: EdgeInsets.all(14),
        boxShape: NeumorphicBoxShape.circle(),
        child: Neumorphic(
          style: NeumorphicStyle(depth: 14),
          margin: EdgeInsets.all(20),
          boxShape: NeumorphicBoxShape.circle(),
          child: Neumorphic(
            style: NeumorphicStyle(depth: -8),
            margin: EdgeInsets.all(10),
            boxShape: NeumorphicBoxShape.circle(),
            child: Stack(
              fit: StackFit.expand,
              alignment: Alignment.center,
              children: [
                //the click center
                Neumorphic(
                  style: NeumorphicStyle(depth: -1),
                  margin: EdgeInsets.all(65),
                  boxShape: NeumorphicBoxShape.circle(),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Stack(
                    children: <Widget>[
                      //those childs are not "good" for a real clock, but will fork for a sample
                      Align(
                        alignment: Alignment.topCenter,
                        child: _createDot(context),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: _createDot(context),
                      ),
                      Align(
                        alignment: Alignment(-0.7, -0.7),
                        child: _createDot(context),
                      ),
                      Align(
                        alignment: Alignment(0.7, -0.7),
                        child: _createDot(context),
                      ),
                      Align(
                        alignment: Alignment(-0.7, 0.7),
                        child: _createDot(context),
                      ),
                      Align(
                        alignment: Alignment(0.7, 0.7),
                        child: _createDot(context),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: _createDot(context),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: _createDot(context),
                      ),
                      _buildLine(
                        context: context,
                        angle: 0,
                        width: 70,
                        color: NeumorphicTheme.accentColor(context),
                      ),
                      _buildLine(
                        context: context,
                        angle: 0.9,
                        width: 100,
                        color: NeumorphicTheme.accentColor(context),
                      ),
                      _buildLine(
                        context: context,
                        angle: 2.2,
                        width: 120,
                        height: 1,
                        color: NeumorphicTheme.variantColor(context),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLine({BuildContext context, double angle, double width, double height = 6, Color color}) {
    return Transform.rotate(
      angle: angle,
      child: Center(
        child: Padding(
          padding: EdgeInsets.only(left: width),
          child: Neumorphic(
            style: NeumorphicStyle(
              depth: 20,
            ),
            child: Container(
              width: width,
              height: height,
              color: color,
            ),
          ),
        ),
      ),
    );
  }

  Widget _createDot(BuildContext context) {
    return Neumorphic(
      style: NeumorphicStyle(depth: -10),
      boxShape: NeumorphicBoxShape.circle(),
      child: SizedBox(
        height: 10,
        width: 10,
      ),
    );
  }
}

class NeumorphicSelector extends StatelessWidget {
  final double _elementHeight = 14;
  final double _spacing = 10;

  Widget _buildSimpleButton(BuildContext context) {
    return Neumorphic(
      boxShape: NeumorphicBoxShape.circle(),
      style: NeumorphicStyle(
        depth: -4,
      ),
      child: SizedBox(
        height: _elementHeight,
        width: _elementHeight,
      ),
    );
  }

  Widget _buildSelectedButton(BuildContext context) {
    return Neumorphic(
      boxShape: NeumorphicBoxShape.stadium(),
      style: NeumorphicStyle(
        depth: -4,
        color: Color(0xffE1E8F5),
      ),
      child: SizedBox(
        height: _elementHeight,
        width: 30,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _buildSimpleButton(context),
        SizedBox(
          width: _spacing,
        ),
        _buildSelectedButton(context),
        SizedBox(
          width: _spacing,
        ),
        _buildSimpleButton(context),
        SizedBox(
          width: _spacing,
        ),
        _buildSimpleButton(context),
      ],
    );
  }
}
