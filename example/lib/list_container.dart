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
      theme: NeumorphicTheme(
        baseColor: NeumorphicColors.background,
        lightSource: LightSource.topLeft,
        curveFactor: 1,
        depth: 3,
        intensity: 0.2,
      ),
      child: Scaffold(
        backgroundColor: NeumorphicColors.background,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title:
              Text("List", style: Theme.of(context).textTheme.display1),
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
                      shape: BoxShape.circle,
                      //accent: Colors.blueAccent,
                      style: NeumorphicStyle(
                        depth: 10,
                        borderRadius: 40,
                        shape: NeumorphicShape.concave,
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
                      shape: BoxShape.circle,
                      //accent: Colors.blueAccent,
                      style: NeumorphicStyle(
                        depth: 10,
                        borderRadius: 40,
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
                      shape: BoxShape.circle,
                      //accent: Colors.blueAccent,
                      style: NeumorphicStyle(
                        depth: 8,
                        borderRadius: 40,
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
                      shape: BoxShape.circle,
                      //accent: Colors.blueAccent,
                      style: NeumorphicStyle(
                        depth: 8,
                        borderRadius: 40,
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
      ),
    );
  }
}
