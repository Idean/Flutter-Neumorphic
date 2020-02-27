import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class ContainersListPage extends StatefulWidget {
  ContainersListPage({Key key}) : super(key: key);

  @override
  _ContainersListPageState createState() => _ContainersListPageState();
}

class _ContainersListPageState extends State<ContainersListPage> {
  @override
  Widget build(BuildContext context) {
    return NeumorphicThemeProvider(
      currentTheme: CurrentTheme.SYSTEM,
      theme: NeumorphicTheme(
        baseColor: NeumorphicColors.background,
        lightSource: LightSource.topLeft,
        curveFactor: 1,
        accentColor: NeumorphicColors.accent,
        depth: 8,
        intensity: 0.2,
      ),
      child: Page(),
    );
  }
}

class Page extends StatefulWidget {
  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NeumorphicThemeProvider.of(context).baseColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text("List", style: Theme.of(context).textTheme.display1),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                children: <Widget>[
                  Neumorphic(
                    shape: NeumorphicBoxShape.circle(),
                    //accent: Colors.blueAccent,
                    style: NeumorphicStyle(
                      shape: NeumorphicShape.emboss,
                    ),
                    child: SizedBox(
                      height: 150,
                      width: 150,
                    ),
                  ),
                  SizedBox(width: 12),
                  Text("Emboss")
                ],
              ),
              SizedBox(height: 30),
              Row(
                children: <Widget>[
                  NeumorphicButton(
                    minDistance: -2,
                    shape: NeumorphicBoxShape.circle(),
                    //accent: Colors.blueAccent,
                    style: NeumorphicStyle(
                      shape: NeumorphicShape.flat,
                    ),
                    child: SizedBox(
                      height: 150,
                      width: 150,
                    ),
                  ),
                  SizedBox(width: 12),
                  Text("Flat")
                ],
              ),
              SizedBox(height: 30),
              Row(
                children: <Widget>[
                  NeumorphicButton(
                    shape: NeumorphicBoxShape.circle(),
                    //accent: Colors.blueAccent,
                    style: NeumorphicStyle(
                      shape: NeumorphicShape.convex,
                    ),
                    child: SizedBox(
                      height: 150,
                      width: 150,
                    ),
                  ),
                  SizedBox(width: 12),
                  Text("Convex")
                ],
              ),
              SizedBox(height: 30),
              Row(
                children: <Widget>[
                  NeumorphicButton(
                    shape: NeumorphicBoxShape.circle(),
                    //accent: Colors.blueAccent,
                    style: NeumorphicStyle(
                      shape: NeumorphicShape.concave,
                    ),
                    child: SizedBox(
                      height: 150,
                      width: 150,
                    ),
                  ),
                  SizedBox(width: 12),
                  Text("Concave")
                ],
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
