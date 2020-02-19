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
        lightSource: LightSource.bottomLeft,
        distance: 5,
        blur: 6
      ),
      child: Scaffold(
        backgroundColor: NeumorphicColors.background,
        appBar: AppBar(
          backgroundColor: NeumorphicColors.background,
          title: Text(widget.title, style: Theme.of(context).textTheme.display1),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              NeumorphicContainer(
                style: NeumorphicStyle(
                  borderRadius: 40,
                  shape: NeumorphicShape.concave,
                ),
                child: SizedBox(
                  height: 200,
                  width: 200,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
