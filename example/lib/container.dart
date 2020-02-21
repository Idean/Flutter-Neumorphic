import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';

class ContainerPage extends StatefulWidget {
  @override
  _ContainerPageState createState() => _ContainerPageState();
}

class _ContainerPageState extends State<ContainerPage> {
  final Color buttonActiveColor = Colors.yellow;
  final Color buttonInnactiveColor = Colors.grey;

  LightSource lightSource = LightSource.topLeft;
  NeumorphicShape shape = NeumorphicShape.concave;
  BoxShape boxShape = BoxShape.rectangle;
  double depth = 1;

  @override
  Widget build(BuildContext context) {
    return NeumorphicThemeProvider(
      theme: NeumorphicTheme(
        baseColor: Color(0xffDDDDDD),
        lightSource: LightSource.topLeft,
        curveFactor: 1,
        distance: 6,
        intensity: 0.2,
      ),
      child: Scaffold(
          backgroundColor: Color(0xffDDDDDD),
          appBar: AppBar(
            backgroundColor: Colors.grey,
          ),
          body: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              shapeWidget(),
              boxshapeWidget(),
              depthSelector(),
              Expanded(
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    ...lightSourceWidgets(),
                    Center(child: neumophic()),
                  ],
                ),
              )
            ],
          )),
    );
  }

  Widget neumophic() {
    return SizedBox(
      height: 200,
      width: 200,
      child: NeumorphicButton(
        shape: boxShape,
        style: NeumorphicStyle(
          shape: this.shape,
          distance: depth,
          lightSource: this.lightSource,
        ),
        child: SizedBox(
          height: 150,
          width: 150,
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
            min: 0,
            max: 40,
            value: depth,
            onChanged: (value){
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

    Widget boxshapeWidget() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        RaisedButton(
          onPressed: () {
            setState(() {
              boxShape = BoxShape.rectangle;
            });
          },
          color: boxShape == BoxShape.rectangle ? buttonActiveColor : buttonInnactiveColor,
          child: Text("Rectangle"),
        ),
        RaisedButton(
          onPressed: () {
            setState(() {
              boxShape = BoxShape.circle;
            });
          },
          color: boxShape == BoxShape.circle ? buttonActiveColor : buttonInnactiveColor,
          child: Text("Circle"),
        ),
      ],
    );
  }

  Widget shapeWidget() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Expanded(
          child: RaisedButton(
            onPressed: () {
              setState(() {
                shape = NeumorphicShape.concave;
              });
            },
            color: shape == NeumorphicShape.concave ? buttonActiveColor : buttonInnactiveColor,
            child: Text("Concave"),
          ),
        ),
        Expanded(
          child: RaisedButton(
            onPressed: () {
              setState(() {
                shape = NeumorphicShape.convex;
              });
            },
            color: shape == NeumorphicShape.convex ? buttonActiveColor : buttonInnactiveColor,
            child: Text("Convex"),
          ),
        ),
        Expanded(
          child: RaisedButton(
            onPressed: () {
              setState(() {
                shape = NeumorphicShape.flat;
              });
            },
            color: shape == NeumorphicShape.flat ? buttonActiveColor : buttonInnactiveColor,
            child: Text("Flat"),
          ),
        ),
        Expanded(
          child: RaisedButton(
            onPressed: () {
              setState(() {
                shape = NeumorphicShape.emboss;
              });
            },
            color: shape == NeumorphicShape.emboss ? buttonActiveColor : buttonInnactiveColor,
            child: Text("Emboss"),
          ),
        ),
      ],
    );
  }

  List<Widget> lightSourceWidgets() {
    return [
      Positioned(
        child: RaisedButton(
          onPressed: () {
            setState(() {
              lightSource = LightSource.topLeft;
            });
          },
          color: lightSource == LightSource.topLeft ? buttonActiveColor : buttonInnactiveColor,
          child: Text("topLeft"),
        ),
        top: 0,
        left: 0,
      ),
      Positioned(
        child: RaisedButton(
          onPressed: () {
            setState(() {
              lightSource = LightSource.topRight;
            });
          },
          color: lightSource == LightSource.topRight ? buttonActiveColor : buttonInnactiveColor,
          child: Text("topRight"),
        ),
        top: 0,
        right: 0,
      ),
      Positioned(
        child: Center(
          child: RaisedButton(
            onPressed: () {
              setState(() {
                lightSource = LightSource.top;
              });
            },
            color: lightSource == LightSource.top ? buttonActiveColor : buttonInnactiveColor,
            child: Text("top"),
          ),
        ),
        top: 0,
        left: 0,
        right: 0,
      ),
      Positioned(
        child: Center(
          child: RaisedButton(
            onPressed: () {
              setState(() {
                lightSource = LightSource.bottom;
              });
            },
            color: lightSource == LightSource.bottom ? buttonActiveColor : buttonInnactiveColor,
            child: Text("bottom"),
          ),
        ),
        bottom: 0,
        left: 0,
        right: 0,
      ),
      Positioned(
        child: Center(
          child: RaisedButton(
            onPressed: () {
              setState(() {
                lightSource = LightSource.left;
              });
            },
            color: lightSource == LightSource.left ? buttonActiveColor : buttonInnactiveColor,
            child: Text("left"),
          ),
        ),
        top: 0,
        bottom: 0,
        left: 0,
      ),
      Positioned(
        child: Center(
          child: RaisedButton(
            onPressed: () {
              setState(() {
                lightSource = LightSource.right;
              });
            },
            color: lightSource == LightSource.right ? buttonActiveColor : buttonInnactiveColor,
            child: Text("right"),
          ),
        ),
        top: 0,
        bottom: 0,
        right: 0,
      ),
      Positioned(
        child: RaisedButton(
          onPressed: () {
            setState(() {
              lightSource = LightSource.bottomLeft;
            });
          },
          color: lightSource == LightSource.bottomLeft ? buttonActiveColor : buttonInnactiveColor,
          child: Text("bottomLeft"),
        ),
        bottom: 0,
        left: 0,
      ),
      Positioned(
        child: RaisedButton(
          onPressed: () {
            setState(() {
              lightSource = LightSource.bottomRight;
            });
          },
          color: lightSource == LightSource.bottomRight ? buttonActiveColor : buttonInnactiveColor,
          child: Text("bottomRight"),
        ),
        bottom: 0,
        right: 0,
      ),
    ];
  }
}
