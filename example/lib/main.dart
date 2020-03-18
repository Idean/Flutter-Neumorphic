import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'main_home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: NeumorphicTheme(
          usedTheme: UsedTheme.LIGHT,
          theme: NeumorphicThemeData(
            baseColor: Color(0xFFFFFFFF),
            intensity: 0.5,
            lightSource: LightSource.topLeft,
            depth: 10,
          ),
          darkTheme: NeumorphicThemeData(
            baseColor: Color(0xFF3E3E3E),
            intensity: 0.5,
            lightSource: LightSource.topLeft,
            depth: 6,
          ),
          child: MyHomePage()),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key}) : super(key: key);

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NeumorphicTheme.baseColor(context),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            NeumorphicButton(
              onClick: () {},
              style: NeumorphicStyle(shape: NeumorphicShape.flat),
              boxShape: NeumorphicBoxShape.circle(),
              padding: const EdgeInsets.all(12.0),
              child: Icon(
                Icons.favorite_border,
                color: _iconsColor(context),
              ),
            ),
            NeumorphicButton(
                margin: EdgeInsets.only(top: 12),
                onClick: () {
                  NeumorphicTheme.of(context).usedTheme = NeumorphicTheme.isUsingDark(context) ? UsedTheme.LIGHT : UsedTheme.DARK;
                },
                style: NeumorphicStyle(shape: NeumorphicShape.flat),
                boxShape: NeumorphicBoxShape.roundRect(borderRadius: BorderRadius.circular(8)),
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  "Toggle Theme",
                  style: TextStyle(color: _textColor(context)),
                )),
            NeumorphicButton(
                margin: EdgeInsets.only(top: 12),
                onClick: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
                    return FullSampleHomePage();
                  }));
                },
                style: NeumorphicStyle(shape: NeumorphicShape.flat),
                boxShape: NeumorphicBoxShape.roundRect(borderRadius: BorderRadius.circular(8)),
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  "Go to full sample",
                  style: TextStyle(color: _textColor(context)),
                )),
          ],
        ),
      ),
    );
  }

  Color _iconsColor(BuildContext context) {
    final theme = NeumorphicTheme.of(context);
    if (theme.isUsingDark) {
      return theme.current.accentColor;
    } else {
      return null;
    }
  }

  Color _textColor(BuildContext context) {
    if (NeumorphicTheme.isUsingDark(context)) {
      return Colors.white;
    } else {
      return Colors.black;
    }
  }
}
