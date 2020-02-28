import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class ContainerPage extends StatefulWidget {
  @override
  _ContainerPageState createState() => _ContainerPageState();
}

class _ContainerPageState extends State<ContainerPage> {
  final Color buttonActiveColor = Colors.yellow;
  final Color buttonInnactiveColor = Colors.grey;

  LightSource lightSource = LightSource.topLeft;
  NeumorphicShape shape = NeumorphicShape.concave;
  NeumorphicBoxShape boxShape = NeumorphicBoxShape.roundRect();
  double depth = 5;
  double curveFactor = 1;
  double cornerRadius = 0;
  double height = 0;

  @override
  Widget build(BuildContext context) {
    return NeumorphicThemeProvider(
      theme: NeumorphicTheme(
        baseColor: Color(0xffDDDDDD),
        lightSource: LightSource.topLeft,
        curveFactor: 1,
        depth: 6,
        intensity: 1,
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
              curveSelector(),
              depthSelector(),
              cornerRadiusSelector(),
              Expanded(
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    ...lightSourceWidgets(),
                    Center(child: neumorphic()),
                  ],
                ),
              )
            ],
          )),
    );
  }

  Widget neumorphic() {
    return SizedBox(
      height: 50,
      width: 200,
      child: NeumorphicButton(
        shape: boxShape,
        style: NeumorphicStyle(
          shape: this.shape,
          depth: depth,
          curveFactor: curveFactor / 100,
          lightSource: this.lightSource,
        ),
        child: SizedBox(
          height: 150,
          width: 150,
          /*
          child: Center(
            child: Text(
              "hello world".toUpperCase(),
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: Colors.black.withOpacity(0.3),
                shadows: <Shadow>[
                  Shadow(
                    offset: Offset(2.0, 2.0),
                    blurRadius: 3.0,
                    color: Colors.white,
                  ),
                  Shadow(
                    offset: Offset(-2.0, -2.0),
                    blurRadius: 2.0,
                    color: Colors.grey.withOpacity(0.3),
                  ),
                ],
              ),
            ),
          ),
           */
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

  Widget cornerRadiusSelector() {
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
                  boxShape = NeumorphicBoxShape.roundRect(borderRadius: BorderRadius.circular(this.cornerRadius));
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
  }

  Widget curveSelector() {
    return Row(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 12),
          child: Text("CurveFactor"),
        ),
        Expanded(
          child: Slider(
            min: Neumorphic.MIN_CURVE * 100, //in case of != 0
            max: Neumorphic.MAX_CURVE * 100,
            value: curveFactor,
            onChanged: (value) {
              setState(() {
                curveFactor = value;
              });
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 12),
          child: Text((curveFactor.floor() / 100).toString()),
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
              boxShape = NeumorphicBoxShape.roundRect(borderRadius: BorderRadius.circular(this.cornerRadius));
            });
          },
          color: boxShape.isRoundRect ? buttonActiveColor : buttonInnactiveColor,
          child: Text("Rectangle"),
        ),
        RaisedButton(
          onPressed: () {
            setState(() {
              boxShape = NeumorphicBoxShape.circle();
            });
          },
          color: boxShape.isCircle ? buttonActiveColor : buttonInnactiveColor,
          child: Text("Circle"),
        ),
        RaisedButton(
          onPressed: () {
            setState(() {
              boxShape = NeumorphicBoxShape.stadium();
            });
          },
          color: boxShape.isStadium ? buttonActiveColor : buttonInnactiveColor,
          child: Text("Stadium"),
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
      ],
    );
  }

  List<Widget> lightSourceWidgets() {
    return [
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
        child:
        RotatedBox(
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

      /**
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
          */
    ];
  }
}
