import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'container.dart';
import 'list_container.dart';
import 'widgets.dart';

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
    return Scaffold(
      backgroundColor: NeumorphicColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title:
            Text(widget.title, style: Theme.of(context).textTheme.display1),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              RaisedButton(
                child: Text("container"),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context){
                    return ContainerPage();
                  }));
                },
              ),
              SizedBox(height: 12),
              RaisedButton(
                child: Text("containers list"),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context){
                    return ContainersListPage();
                  }));
                },
              ),
              SizedBox(height: 12),
              RaisedButton(
                child: Text("widgets"),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context){
                    return WidgetsPage();
                  }));
                },
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
