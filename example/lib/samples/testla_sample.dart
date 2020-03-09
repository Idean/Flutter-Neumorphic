import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class TestlaSample extends StatefulWidget {
  @override
  createState() => _TeslaSampleState();
}

class _TeslaSampleState extends State<TestlaSample> {
  @override
  Widget build(BuildContext context) {
    return NeumorphicTheme(
      theme: NeumorphicThemeData(
        baseColor: Color(0xFF30353B),
        intensity: 0.6,
        accentColor: Color(0xFF0F95E6),
        lightSource: LightSource.topLeft,
        depth: 5,
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

class __PageContentState extends State<_PageContent> {
  @override
  Widget build(BuildContext context) {
    return NeumorphicBackground(
      borderRadius: BorderRadius.circular(12),
      margin: EdgeInsets.all(12),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          _buildTopBar(context),
          _buildTitle(context),
          _buildCenterContent(context),
          _buildBottomAction(context),
        ],
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Stack(
      children: <Widget>[
        Align(
          alignment: Alignment.centerRight,
          child: NeumorphicButton(
            boxShape: NeumorphicBoxShape.circle(),
            style: NeumorphicStyle(
              color: Color(0xFF222429),
              shape: NeumorphicShape.convex,
            ),
            child: Icon(
              Icons.settings,
              color: Colors.grey,
            ),
          ),
        )
      ],
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          "Tesla",
          style: TextStyle(
            color: Colors.white30,
          ),
        ),
        Text(
          "CyberTruck",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildCenterContent(BuildContext context) {
    return Stack(
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "297",
              style: TextStyle(color: Colors.white, fontSize: 40),
            ),
            Text(
              "km",
              style: TextStyle(color: Colors.white, fontSize: 10),
            ),
          ],
        ),
        Image.network(
          "assets/images/tesla.png",
        ),
      ],
    );
  }

  Widget _buildBottomAction(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          "A/C turned on",
          style: TextStyle(
            color: Colors.white30,
          ),
        ),
        NeumorphicButton(
          boxShape: NeumorphicBoxShape.circle(),
          style: NeumorphicStyle(
            color: NeumorphicTheme.accentColor(context),
            shape: NeumorphicShape.concave,
          ),
          child: SizedBox(
            height: 40,
            width: 40,
            child: Icon(
              Icons.lock,
              color: Colors.white,
            ),
          ),
        ),
        Text(
          "Tap to open the car",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
