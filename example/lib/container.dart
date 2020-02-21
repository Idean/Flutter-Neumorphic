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
  BoxShape boxShape = BoxShape.rectangle;

  //forces have 2 different widgets if the shape changes
  GlobalKey circleKey = GlobalKey();
  GlobalKey rectangleKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return NeumorphicThemeProvider(
      theme: NeumorphicTheme(
        baseColor: NeumorphicColors.background,
        lightSource: LightSource.topLeft,
        curveFactor: 1,
        distance: 6,
        intensity: 0.2,
      ),
      child: Scaffold(
          backgroundColor: NeumorphicColors.background,
          appBar: AppBar(
            backgroundColor: Colors.grey,
          ),
          body: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              shapeWidget(),
              boxshapeWidget(),
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
    return NeumorphicButton(
      key: boxShape == BoxShape.circle ? circleKey : rectangleKey,
      shape: boxShape,
      style: NeumorphicStyle(
        shape: this.shape,
        lightSource: this.lightSource,
      ),
      child: SizedBox(
        height: 150,
        width: 150,
      ),
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
