import 'package:example/lib/top_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class ContainerWidgetPage extends StatefulWidget {
  ContainerWidgetPage({Key key}) : super(key: key);

  @override
  _ContainerWidgetPageState createState() => _ContainerWidgetPageState();
}

class _ContainerWidgetPageState extends State<ContainerWidgetPage> {
  @override
  Widget build(BuildContext context) {
    return NeumorphicTheme(
      theme: NeumorphicThemeData(
        lightSource: LightSource.topLeft,
        accentColor: NeumorphicColors.accent,
        depth: 4,
        intensity: 0.5,
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
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: NeumorphicBackground(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                TopBar(title: "Container",),
                Row(
                  children: <Widget>[
                    Neumorphic(
                      boxShape: NeumorphicBoxShape.circle(),
                      //accent: Colors.blueAccent,
                      style: NeumorphicStyle(
                        depth: -5,
                      ),
                      child: SizedBox(
                        height: 150,
                        width: 150,
                      ),
                    ),
                    SizedBox(width: 30),
                    Text("Emboss")
                  ],
                ),
                SizedBox(height: 30),
                Row(
                  children: <Widget>[
                    NeumorphicButton(
                      minDistance: -2,
                      boxShape: NeumorphicBoxShape.circle(),
                      //accent: Colors.blueAccent,
                      style: NeumorphicStyle(
                        shape: NeumorphicShape.flat,
                      ),
                      child: SizedBox(
                        height: 150,
                        width: 150,
                      ),
                    ),
                    SizedBox(width: 30),
                    Text("Flat")
                  ],
                ),
                SizedBox(height: 30),
                Row(
                  children: <Widget>[
                    NeumorphicButton(
                      boxShape: NeumorphicBoxShape.circle(),
                      //accent: Colors.blueAccent,
                      style: NeumorphicStyle(
                        shape: NeumorphicShape.convex,
                      ),
                      child: SizedBox(
                        height: 150,
                        width: 150,
                      ),
                    ),
                    SizedBox(width: 30),
                    Text("Convex")
                  ],
                ),
                SizedBox(height: 30),
                Row(
                  children: <Widget>[
                    NeumorphicButton(
                      boxShape: NeumorphicBoxShape.circle(),
                      //accent: Colors.blueAccent,
                      style: NeumorphicStyle(
                        shape: NeumorphicShape.concave,
                      ),
                      child: SizedBox(
                        height: 150,
                        width: 150,
                      ),
                    ),
                    SizedBox(width: 30),
                    Text("Concave")
                  ],
                ),
                SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
