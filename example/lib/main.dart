import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Neumophic'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Provider<NeumorphicTheme>.value(
      value: NeumorphicTheme(
        baseColor: NeumorphicColors.background,
        lightSource: LightSource.bottomRight,
        distance: 3,
        blur: 6,
        intensity: 0.2
      ),
      child: Scaffold(
        backgroundColor: NeumorphicColors.background,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(widget.title, style: Theme.of(context).textTheme.display1),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              NeumorphicContainer(
                //accent: Colors.blueAccent,
                style: NeumorphicStyle(
                  distance: 10,
                  borderRadius: 40,
                  shape: NeumorphicShape.emboss,
                ),
                child: SizedBox(
                  height: 150,
                  width: 150,
                ),
              ),
              SizedBox(height: 30),
              NeumorphicButton(
                //accent: Colors.blueAccent,
                style: NeumorphicStyle(
                  distance: 10,
                  borderRadius: 40,
                  shape: NeumorphicShape.flat,
                ),
                child: SizedBox(
                  height: 150,
                  width: 150,
                ),
              ),
              SizedBox(height: 30),
              NeumorphicButton(
                //accent: Colors.blueAccent,
                style: NeumorphicStyle(
                  distance: 8,
                  borderRadius: 40,
                  shape: NeumorphicShape.convex,
                ),
                child: SizedBox(
                  height: 150,
                  width: 150,
                ),
              ),
              SizedBox(height: 30),
              NeumorphicButton(
                //accent: Colors.blueAccent,
                style: NeumorphicStyle(
                  distance: 8,
                  borderRadius: 40,
                  shape: NeumorphicShape.concave,
                ),
                child: SizedBox(
                  height: 150,
                  width: 150,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
