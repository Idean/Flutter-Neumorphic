import 'package:example/button.dart';
import 'package:example/samples/audio_player_sample.dart';
import 'package:example/samples/calculator_sample.dart';
import 'package:example/samples/credit_card_sample.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'container.dart';
import 'list_container.dart';
import 'samples/testla_sample.dart';
import 'widgets.dart';

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
              RaisedButton(
                child: Text("button"),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context){
                    return ButtonSample();
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
              Text("samples :"),
              SizedBox(height: 12),
              RaisedButton(
                child: Text("sample audio"),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context){
                    return AudioPlayerSample();
                  }));
                },
              ),
              SizedBox(height: 12),
              RaisedButton(
                child: Text("credit card"),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context){
                    return CreditCardSample();
                  }));
                },
              ),
              SizedBox(height: 12),
              RaisedButton(
                child: Text("tesla"),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context){
                    return TeslaSample();
                  }));
                },
              ),
              SizedBox(height: 12),
              RaisedButton(
                child: Text("calculator"),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context){
                    return CalculatorSample();
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
