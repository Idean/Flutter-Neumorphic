import 'package:example/lib/color_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class NeumorphicAccessibility extends StatefulWidget {
  @override
  createState() => _NeumorphicAccessibilityState();
}

class _NeumorphicAccessibilityState extends State<NeumorphicAccessibility> {
  @override
  Widget build(BuildContext context) {
    return NeumorphicTheme(
      themeMode: ThemeMode.light,
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
  NeumorphicBoxShape boxShape =
      NeumorphicBoxShape.roundRect(BorderRadius.circular(12));
  double depth = 5;
  double intensity = 0.8;
  double surfaceIntensity = 0.5;
  double cornerRadius = 20;
  double height = 150.0;
  double width = 150.0;

  Color borderColor;
  double borderWidth;

  static final minWidth = 50.0;
  static final maxWidth = 200.0;
  static final minHeight = 50.0;
  static final maxHeight = 200.0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    borderColor = NeumorphicTheme.currentTheme(context).borderColor;
    borderWidth = NeumorphicTheme.currentTheme(context).borderWidth;
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
                      Center(child: neumorphic()),
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
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    child: Text(
                      "Border",
                      style: TextStyle(
                        color: selectedConfiguratorIndex == 2
                            ? textActiveColor
                            : textInactiveColor,
                      ),
                    ),
                    color: selectedConfiguratorIndex == 2
                        ? buttonActiveColor
                        : buttonInnactiveColor,
                    onPressed: () {
                      setState(() {
                        selectedConfiguratorIndex = 2;
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
      case 2:
        return borderCustomizer();
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
        cornerRadiusSelector(),
        shapeWidget(),
        sizeSelector(),
      ],
    );
  }

  Widget borderCustomizer() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        borderColorPicker(),
        borderWidthSelector(),
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

  Widget borderColorPicker() {
    return Row(
      children: <Widget>[
        SizedBox(
          width: 12,
        ),
        Text("BorderColor "),
        SizedBox(
          width: 4,
        ),
        ColorSelector(
          onColorChanged: (color) {
            setState(() {
              borderColor = color;
            });
          },
          color: borderColor,
        ),
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
      style: NeumorphicStyle(
        boxShape: boxShape,
        border: NeumorphicBorder(
            isEnabled: true, width: this.borderWidth, color: this.borderColor),
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
        child: Container(
          //color: Colors.blue,
          child: Center(child: Text("")),
        ),
      ),
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

  Widget borderWidthSelector() {
    return Row(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 12),
          child: Text("BorderWidth"),
        ),
        Expanded(
          child: Slider(
            min: 0,
            max: 10,
            value: borderWidth,
            onChanged: (value) {
              setState(() {
                borderWidth = value;
              });
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 12),
          child: Text(borderWidth.floor().toString()),
        ),
      ],
    );
  }

  Widget sizeSelector() {
    return Row(
      children: <Widget>[
        SizedBox(
          width: 12,
        ),
        Text("W: "),
        Expanded(
          child: Slider(
            min: minWidth,
            max: maxWidth,
            value: width,
            onChanged: (value) {
              setState(() {
                width = value;
              });
            },
          ),
        ),
        Text("H: "),
        Expanded(
          child: Slider(
            min: minHeight,
            max: maxHeight,
            value: height,
            onChanged: (value) {
              setState(() {
                height = value;
              });
            },
          ),
        ),
      ],
    );
  }

  Widget cornerRadiusSelector() {
    if (boxShape.isRoundRect) {
      return Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 12),
            child: Text("Corner"),
          ),
          Expanded(
            child: Slider(
              min: 0,
              max: 30,
              value: cornerRadius,
              onChanged: (value) {
                setState(() {
                  cornerRadius = value;
                  if (boxShape.isRoundRect) {
                    boxShape = NeumorphicBoxShape.roundRect(
                        BorderRadius.circular(this.cornerRadius));
                  }
                });
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 12),
            child: Text(cornerRadius.floor().toString()),
          ),
        ],
      );
    } else {
      return SizedBox();
    }
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
