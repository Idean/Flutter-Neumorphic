import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class ButtonSample extends StatefulWidget {
  @override
  createState() => _ButtonSampleState();
}

class _ButtonSampleState extends State<ButtonSample> {
  @override
  Widget build(BuildContext context) {
    return NeumorphicTheme(
        usedTheme: UsedTheme.LIGHT,
        theme: NeumorphicThemeData(
          baseColor: Color(0xFFFFFFFF),
          intensity: 0.5,
          lightSource: LightSource.topLeft,
          depth: 10,
        ),
        darkTheme: NeumorphicThemeData(
          baseColor: Color(0xFF000000),
          intensity: 0.5,
          lightSource: LightSource.topLeft,
          depth: 10,
        ),
        child: _Page());
  }
}

class _Page extends StatefulWidget {
  @override
  createState() => __PageState();
}

class __PageState extends State<_Page> {
  bool _useDark = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("back"),
            ),
            RaisedButton(
              onPressed: () {
                setState(() {
                  _useDark = !_useDark;
                  NeumorphicTheme.of(context).usedTheme =
                      _useDark ? UsedTheme.DARK : UsedTheme.LIGHT;
                });
              },
              child: Text("toggle theme"),
            ),
            SizedBox(height: 34),
            _buildTopBar(context),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Center(
      child: NeumorphicButton(
        onPressed: () {
          print("click");
        },
        style: NeumorphicStyle(shape: NeumorphicShape.flat),
        boxShape: NeumorphicBoxShape.circle(),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Icon(
            Icons.favorite_border,
            color: _iconsColor(),
          ),
        ),
      ),
    );
  }

  Color _iconsColor() {
    final theme = NeumorphicTheme.of(context);
    if (theme.isUsingDark) {
      return theme.current.accentColor;
    } else {
      return null;
    }
  }
}
