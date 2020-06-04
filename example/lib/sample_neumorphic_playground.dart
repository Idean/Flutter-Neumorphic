import 'package:example/lib/color_selector.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

void main() => runApp(NeumorphicPlayground());

class NeumorphicPlayground extends StatefulWidget {
  @override
  _NeumorphicPlaygroundState createState() => _NeumorphicPlaygroundState();
}

class _NeumorphicPlaygroundState extends State<NeumorphicPlayground> {
  @override
  Widget build(BuildContext context) {
    return NeumorphicApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: NeumorphicThemeData(
        baseColor: Color(0xffDDDDDD),
        lightSource: LightSource.topLeft,
        depth: 6,
        intensity: 0.5,
      ),
      home: _Page(),
    );
  }
}

class _Page extends StatefulWidget {
  @override
  __PageState createState() => __PageState();
}

class __PageState extends State<_Page> {
  LightSource lightSource = LightSource.topLeft;
  NeumorphicShape shape = NeumorphicShape.flat;
  NeumorphicBoxShape boxShape =
      NeumorphicBoxShape.roundRect(BorderRadius.circular(12));

  double depth = 5;
  double intensity = 0.5;
  double surfaceIntensity = 0.5;
  double cornerRadius = 40;
  double height = 150.0;
  double width = 150.0;

  bool haveNeumorphicChild = false;
  bool childOppositeLightsourceChild = false;
  bool drawAboveChild = false;
  double childMargin = 5;
  double childDepth = 5;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: NeumorphicTheme.baseColor(context),
        //appBar: NeumorphicAppBar(
        //  title: Text('Playground'),
        //),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Flexible(
              flex: 1,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  lightSourceWidgets(),
                  Center(child: neumorphic()),
                ],
              ),
            ),
            Flexible(
              flex: 1,
              child: _configurators(),
            )
          ],
        ));
  }

  Widget _configurators() {
    final Color buttonActiveColor = Theme.of(context).accentColor;
    final Color buttonInnactiveColor = Colors.white;

    final Color textActiveColor = Colors.white;
    final Color textInactiveColor = Colors.black.withOpacity(0.3);

    return Column(
      children: <Widget>[
        styleCustomizer(),
      ],
    );
  }

  Widget styleCustomizer() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        //depthSelector(),
        //intensitySelector(),
        //surfaceIntensitySelector(),
        //shapeWidget(),
      ],
    );
  }

  Widget neumorphic() {
    return NeumorphicButton(
      padding: EdgeInsets.zero,
      duration: Duration(milliseconds: 300),
      onPressed: () {
        setState(() {});
      },
      drawSurfaceAboveChild: this.drawAboveChild,
      style: NeumorphicStyle(
        boxShape: boxShape,
        //border: NeumorphicBorder(),
        shape: this.shape,
        intensity: this.intensity,
        /*
        shadowLightColor: Colors.red,
        shadowDarkColor: Colors.blue,
        shadowLightColorEmboss: Colors.red,
        shadowDarkColorEmboss: Colors.blue,
         */
        surfaceIntensity: this.surfaceIntensity,
        depth: depth,
        lightSource: this.lightSource,
      ),
      child: SizedBox(
        height: height,
        width: width,
        child: haveNeumorphicChild
            ? neumorphicChild()
            : Container(
                //color: Colors.blue,
                child: Center(child: Text("")),
              ),
      ),
    );
  }

  Widget neumorphicChild() {
    return Neumorphic(
      padding: EdgeInsets.zero,
      duration: Duration(milliseconds: 300),
      margin: EdgeInsets.all(this.childMargin),
      drawSurfaceAboveChild: true,
      style: NeumorphicStyle(
          boxShape: boxShape,
          //shape: this.shape,
          intensity: this.intensity,
          surfaceIntensity: this.surfaceIntensity,
          depth: childDepth,
          lightSource: this.lightSource,
          oppositeShadowLightSource: this.childOppositeLightsourceChild),
      child: SizedBox.expand(),
    );
  }

  Widget depthSelector() {
    return Row(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 12),
          child: Text("Depth"),
        ),
        Expanded(
          child: Slider(
            min: Neumorphic.MIN_DEPTH,
            max: Neumorphic.MAX_DEPTH,
            value: depth,
            onChanged: (value) {
              setState(() {
                depth = value;
              });
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 12),
          child: Text(depth.floor().toString()),
        ),
      ],
    );
  }

  Widget intensitySelector() {
    return Row(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 12),
          child: Text("Intensity"),
        ),
        Expanded(
          child: Slider(
            min: Neumorphic.MIN_INTENSITY, //in case of != 0
            max: Neumorphic.MAX_INTENSITY,
            value: intensity,
            onChanged: (value) {
              setState(() {
                intensity = value;
              });
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 12),
          child: Text(((intensity * 100).floor() / 100).toString()),
        ),
      ],
    );
  }

  Widget surfaceIntensitySelector() {
    return Row(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 12),
          child: Text("SurfaceIntensity"),
        ),
        Expanded(
          child: Slider(
            min: Neumorphic.MIN_INTENSITY, //in case of != 0
            max: Neumorphic.MAX_INTENSITY,
            value: surfaceIntensity,
            onChanged: (value) {
              setState(() {
                surfaceIntensity = value;
              });
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 12),
          child: Text(((surfaceIntensity * 100).floor() / 100).toString()),
        ),
      ],
    );
  }

  Widget shapeWidget() {
    final Color buttonActiveColor = Theme.of(context).accentColor;
    final Color buttonInnactiveColor = Colors.white;

    final Color iconActiveColor = Colors.white;
    final Color iconInactiveColor = Colors.black.withOpacity(0.3);

    return Row(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              onPressed: () {
                setState(() {
                  shape = NeumorphicShape.concave;
                });
              },
              color: shape == NeumorphicShape.concave
                  ? buttonActiveColor
                  : buttonInnactiveColor,
              child: Image.asset("assets/images/concave.png",
                  color: shape == NeumorphicShape.concave
                      ? iconActiveColor
                      : iconInactiveColor),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              onPressed: () {
                setState(() {
                  shape = NeumorphicShape.convex;
                });
              },
              color: shape == NeumorphicShape.convex
                  ? buttonActiveColor
                  : buttonInnactiveColor,
              child: Image.asset("assets/images/convex.png",
                  color: shape == NeumorphicShape.convex
                      ? iconActiveColor
                      : iconInactiveColor),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              onPressed: () {
                setState(() {
                  shape = NeumorphicShape.flat;
                });
              },
              color: shape == NeumorphicShape.flat
                  ? buttonActiveColor
                  : buttonInnactiveColor,
              child: Image.asset("assets/images/flat.png",
                  color: shape == NeumorphicShape.flat
                      ? iconActiveColor
                      : iconInactiveColor),
            ),
          ),
        ),
      ],
    );
  }

  Widget lightSourceWidgets() {
    return Stack(
      children: <Widget>[
        Positioned(
          left: 20,
          right: 20,
          child: Slider(
            min: -1,
            max: 1,
            value: lightSource.dx,
            onChanged: (value) {
              setState(() {
                lightSource = lightSource.copyWith(dx: value);
              });
            },
          ),
        ),
        Positioned(
          left: 0,
          top: 20,
          bottom: 20,
          child: RotatedBox(
            quarterTurns: 1,
            child: Slider(
              min: -1,
              max: 1,
              value: lightSource.dy,
              onChanged: (value) {
                setState(() {
                  lightSource = lightSource.copyWith(dy: value);
                });
              },
            ),
          ),
        ),
      ],
    );
  }
}
