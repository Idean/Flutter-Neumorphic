import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class AppBarWidgetPage extends StatelessWidget {
  AppBarWidgetPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        _FirstThemeWidgetPage(),
        _SecondThemeWidgetPage(),
        _ThirdThemeWidgetPage(),
        _CustomIcon(),
      ],
    );
  }
}

class _FirstThemeWidgetPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return NeumorphicTheme(
      themeMode: ThemeMode.light,
      theme: NeumorphicThemeData(
        lightSource: LightSource.topLeft,
        accentColor: NeumorphicColors.accent,
        appBarTheme: NeumorphicAppBarThemeData(
          buttonStyle: NeumorphicStyle(boxShape: NeumorphicBoxShape.circle()),
          textStyle: TextStyle(color: Colors.black54),
          iconTheme: IconThemeData(color: Colors.black54, size: 30),
        ),
        depth: 4,
        intensity: 0.9,
      ),
      child: AppBarPageUsingTheme(),
    );
  }
}

class _SecondThemeWidgetPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return NeumorphicTheme(
      themeMode: ThemeMode.light,
      theme: NeumorphicThemeData(
        lightSource: LightSource.topLeft,
        accentColor: NeumorphicColors.accent,
        appBarTheme: NeumorphicAppBarThemeData(
          buttonStyle: NeumorphicStyle(
              boxShape: NeumorphicBoxShape.beveled(BorderRadius.circular(12))),
          textStyle: TextStyle(color: Colors.black54),
          iconTheme: IconThemeData(color: Colors.black54, size: 30),
        ),
        depth: 4,
        intensity: 0.9,
      ),
      child: AppBarPageUsingTheme(),
    );
  }
}

class _ThirdThemeWidgetPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return NeumorphicTheme(
      themeMode: ThemeMode.light,
      theme: NeumorphicThemeData(
        lightSource: LightSource.topLeft,
        accentColor: NeumorphicColors.accent,
        appBarTheme: NeumorphicAppBarThemeData(
          buttonStyle: NeumorphicStyle(
              color: Colors.black54,
              boxShape:
                  NeumorphicBoxShape.roundRect(BorderRadius.circular(12))),
          textStyle: TextStyle(color: Colors.black54, fontSize: 20),
          iconTheme: IconThemeData(color: Colors.white, size: 20),
        ),
        depth: 4,
        intensity: 0.9,
      ),
      child: SizedAppBarPageUsingTheme(),
    );
  }
}

class AppBarPageUsingTheme extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Scaffold(
          appBar: NeumorphicAppBar(
            title: Text("App bar"),
            actions: <Widget>[
              NeumorphicButton(
                child: Icon(Icons.add),
                onPressed: () {},
              ),
            ],
          ),
          body: Container()),
    );
  }
}

class SizedAppBarPageUsingTheme extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(60.0),
            child: NeumorphicAppBar(
              title: Text("App bar custom size"),
              actions: <Widget>[
                NeumorphicButton(
                  child: Icon(Icons.add),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          body: Container()),
    );
  }
}

class FirstThemeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Scaffold(
          appBar: NeumorphicAppBar(
            title: Text("App bar"),
            actions: <Widget>[
              NeumorphicButton(
                child: Icon(Icons.add),
                onPressed: () {},
              ),
            ],
          ),
          body: Container()),
    );
  }
}

class _MyDrawer extends StatelessWidget {
  final bool isLead;

  const _MyDrawer({Key? key, this.isLead = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: NeumorphicTheme.baseColor(context),
        child: Column(
          children: [
            ConstrainedBox(
              constraints: BoxConstraints.tightFor(
                  height: NeumorphicAppBar.toolbarHeight),
              child: NeumorphicAppBar(
                title: Text('Menu'),
                leading:
                    isLead ? NeumorphicBackButton() : NeumorphicCloseButton(),
                actions: <Widget>[
                  NeumorphicButton(
                    child: Icon(Icons.style),
                    onPressed: () {},
                  ),
                  isLead
                      ? NeumorphicCloseButton()
                      : NeumorphicBackButton(forward: true),
                ],
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}

class _CustomIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
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
              textStyle: TextStyle(color: Colors.black, fontSize: 20),
              iconTheme: IconThemeData(color: Colors.green, size: 25),
              icons: NeumorphicAppBarIcons(
                  menuIcon: Icon(Icons.list, color: Colors.pink),
                  closeIcon: Icon(Icons.delete),
                  backIcon: Icon(Icons.reply))),
          depth: 2,
          intensity: 0.5,
        ),
        child: Scaffold(
          appBar: NeumorphicAppBar(
            title: Text("Custom icons + drawer"),
          ),
          endDrawer: _MyDrawer(isLead: false),
          body: Container(),
        ),
      ),
    );
  }
}
