import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class AppBarWidgetPage extends StatefulWidget {
  AppBarWidgetPage({Key key}) : super(key: key);

  @override
  createState() => _WidgetPageState();
}

class _WidgetPageState extends State<AppBarWidgetPage> {
  @override
  Widget build(BuildContext context) {
    return NeumorphicTheme(
      themeMode: ThemeMode.light,
      theme: NeumorphicThemeData(
        lightSource: LightSource.topLeft,
        accentColor: NeumorphicColors.accent,
        appBarTheme: NeumorphicAppBarThemeData(
          buttonStyle: NeumorphicStyle(),
          textStyle: TextStyle(color: Colors.red),
          iconTheme: IconThemeData(color: Colors.red, size: 30),
        ),
        depth: 4,
        intensity: 0.9,
      ),
      child: _Page(),
    );
  }
}

class _Page extends StatefulWidget {
  @override
  createState() => _PageState();
}

class _PageState extends State<_Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NeumorphicAppBar(
        title: Text("App bar"),
        actions: <Widget>[
          NeumorphicButton(
            child: Icon(Icons.add),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: NeumorphicTheme(
              themeMode: ThemeMode.light,
              theme: NeumorphicThemeData(
                lightSource: LightSource.topLeft,
                accentColor: NeumorphicColors.accent,
                appBarTheme: NeumorphicAppBarThemeData(
                  buttonStyle: NeumorphicStyle(
                    boxShape: NeumorphicBoxShape.circle(),
                    shape: NeumorphicShape.concave,
                    depth: 10,
                    intensity: 1,
                  ),
                  textStyle: TextStyle(color: Colors.black),
                  iconTheme: IconThemeData(color: Colors.green, size: 25),
                ),
                depth: 2,
                intensity: 0.5,
              ),
              child: Scaffold(
                primary: false,
                drawer: _MyDrawer(),
                endDrawer: _MyDrawer(isLead: false),
                appBar: NeumorphicAppBar(
                  title: Text("Imply drawer"),
                ),
                body: Container(),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _MyDrawer extends StatelessWidget {
  final bool isLead;

  const _MyDrawer({Key key, this.isLead = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          ConstrainedBox(
            constraints: BoxConstraints.tightFor(height: NeumorphicAppBar.toolbarHeight),
            child: NeumorphicAppBar(
              title: Text('Menu'),
              leading: isLead ? NeumorphicBackButton() : NeumorphicCloseButton(),
              actions: <Widget>[
                NeumorphicButton(child: Icon(Icons.style)),
                isLead ? NeumorphicCloseButton() : NeumorphicBackButton(reversedArrow: true),
              ],
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
