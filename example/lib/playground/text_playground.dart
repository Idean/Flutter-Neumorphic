import 'package:example/lib/color_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class NeumorphicTextPlayground extends StatefulWidget {
  @override
  _NeumorphicPlaygroundState createState() => _NeumorphicPlaygroundState();
}

class _NeumorphicPlaygroundState extends State<NeumorphicTextPlayground> {
  @override
  Widget build(BuildContext context) {
    return NeumorphicTheme(
      usedTheme: UsedTheme.LIGHT,
      theme: NeumorphicThemeData(
        baseColor: Color(0xffDDDDDD),
        lightSource: LightSource.topLeft,
        depth: 6,
        intensity: 0.5,
      ),
      child: _Page(),
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
  double depth = 2;
  double intensity = 0.8;
  double surfaceIntensity = 0.5;
  double cornerRadius = 20;
  double height = 150.0;
  double width = 150.0;

  double fontSize = 100;
  int fontWeight = 800;

  final _textController = TextEditingController(text: "Flutter");

  bool displayIcon = true;

  Widget neumorphicText() {
    if (displayIcon) {
      return NeumorphicIcon(
        Icons.public,
        size: this.fontSize,
        style: NeumorphicStyle(
          shape: this.shape,
          intensity: this.intensity,
          surfaceIntensity: this.surfaceIntensity,
          depth: depth,
          lightSource: this.lightSource,
        ),
      );
    } else {
      return NeumorphicText(
        this._textController.text,
        textStyle: TextStyle(
          fontSize: this.fontSize,
          fontWeight: _fontWeight(),
        ),
        style: NeumorphicStyle(
          shape: this.shape,
          intensity: this.intensity,
          surfaceIntensity: this.surfaceIntensity,
          depth: depth,
          lightSource: this.lightSource,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: NeumorphicBackground(
        child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding:
                      const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    color: Theme.of(context).accentColor,
                    child: Text(
                      "back",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      lightSourceWidgets(),
                      Center(child: neumorphicText()),
                    ],
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: _configurators(),
                )
              ],
            )),
      ),
    );
  }

  int selectedConfiguratorIndex = 0;

  Widget _configurators() {
    final Color buttonActiveColor = Theme.of(context).accentColor;
    final Color buttonInnactiveColor = Colors.white;

    final Color textActiveColor = Colors.white;
    final Color textInactiveColor = Colors.black.withOpacity(0.3);

    return Card(
      margin: EdgeInsets.all(8),
      elevation: 12,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Colors.grey[300],
      child: Column(
        children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    color: selectedConfiguratorIndex == 0
                        ? buttonActiveColor
                        : buttonInnactiveColor,
                    child: Text(
                      "Style",
                      style: TextStyle(
                        color: selectedConfiguratorIndex == 0
                            ? textActiveColor
                            : textInactiveColor,
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        selectedConfiguratorIndex = 0;
                      });
                    },
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    child: Text(
                      "Element",
                      style: TextStyle(
                        color: selectedConfiguratorIndex == 1
                            ? textActiveColor
                            : textInactiveColor,
                      ),
                    ),
                    color: selectedConfiguratorIndex == 1
                        ? buttonActiveColor
                        : buttonInnactiveColor,
                    onPressed: () {
                      setState(() {
                        selectedConfiguratorIndex = 1;
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
          _configuratorsChild(),
        ],
      ),
    );
  }

  Widget _configuratorsChild() {
    switch (selectedConfiguratorIndex) {
      case 0:
        return styleCustomizer();
        break;
      case 1:
        return elementCustomizer();
        break;
    }
    return null;
  }

  Widget styleCustomizer() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        depthSelector(),
        intensitySelector(),
        surfaceIntensitySelector(),
        colorPicker(),
      ],
    );
  }

  Widget elementCustomizer() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        fontSizeSelector(),
        fontWeightSelector(),
        textSelector(),
        shapeWidget(),
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

  Widget colorPicker() {
    return Row(
      children: <Widget>[
        SizedBox(
          width: 12,
        ),
        Text("Color "),
        SizedBox(
          width: 4,
        ),
        ColorSelector(
          onColorChanged: (color) {
            setState(() {
              NeumorphicTheme.of(context)
                  .updateCurrentTheme(NeumorphicThemeData(baseColor: color));
            });
          },
          color: NeumorphicTheme.baseColor(context),
        ),
      ],
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

  Widget fontSizeSelector() {
    return Row(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 12),
          child: Text("FontSize"),
        ),
        Expanded(
          child: Slider(
            min: 40,
            max: 200,
            value: fontSize,
            onChanged: (value) {
              setState(() {
                fontSize = value;
              });
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 12),
          child: Text(fontSize.floor().toString()),
        ),
      ],
    );
  }

  Widget textSelector() {
    return Row(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 12),
          child: Text("Text"),
        ),
        SizedBox(
          width: 12,
        ),
        Expanded(
          child: TextField(
            controller: this._textController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
            ),
            onChanged: (s) {
              setState(() {});
            },
          ),
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

  FontWeight _fontWeight() {
    switch ((this.fontWeight / 100).toInt()) {
      case 1:
        return FontWeight.w100;
      case 2:
        return FontWeight.w200;
      case 3:
        return FontWeight.w300;
      case 4:
        return FontWeight.w400;
      case 5:
        return FontWeight.w500;
      case 6:
        return FontWeight.w600;
      case 7:
        return FontWeight.w700;
      case 8:
        return FontWeight.w800;
      case 9:
        return FontWeight.w900;
    }
    return FontWeight.w500;
  }

  Widget fontWeightSelector() {
    return Row(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 12),
          child: Text("FontWeight"),
        ),
        Expanded(
          child: Slider(
            min: 100,
            max: 900,
            value: fontWeight.toDouble(),
            onChanged: (value) {
              setState(() {
                fontWeight = value.toInt();
              });
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 12),
          child: Text(((fontWeight * 100).floor() / 100).toString()),
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

  Widget lightSourceWidgets() {
    return Stack(
      children: <Widget>[
        Positioned(
          left: 10,
          right: 10,
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
          top: 10,
          bottom: 10,
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
