import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
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
  double intensity = 0.5;
  double cornerRadius = 0;
  double height = 0;
  Color baseColor = Color(0xffDDDDDD);

  @override
  Widget build(BuildContext context) {
    return NeumorphicThemeProvider(
      theme: NeumorphicTheme(
        baseColor: baseColor,
        lightSource: LightSource.topLeft,
        depth: 6,
        intensity: this.intensity,
      ),
      child: Scaffold(
          backgroundColor: this.baseColor,
          appBar: AppBar(
            backgroundColor: Colors.grey,
          ),
          body: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              shapeWidget(),
              boxshapeWidget(),
              intensitySelector(),
              depthSelector(),
              cornerRadiusSelector(),
              Expanded(
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    ...lightSourceWidgets(),
                    Center(child: neumorphic()),
                    colorPicker(),
                  ],
                ),
              )
            ],
          )),
    );
  }


  Widget colorPicker() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Row(
        children: <Widget>[
          RaisedButton(
            child: Text("Color"),
            onPressed: () {
              changeColor();
            },
          ),
        ],
      ),
    );
  }

  void changeColor() {
    showDialog(
      context: context,
      child: AlertDialog(
        title: const Text('Pick a color!'),
        content: SingleChildScrollView(
          child: ColorPicker(
            pickerColor: this.baseColor,
            onColorChanged: (color) {
              setState(() {
                this.baseColor = color;
              });
            },
            showLabel: true,
            pickerAreaHeightPercent: 0.8,
          ),
          // Use Material color picker:
          //
          // child: MaterialPicker(
          //   pickerColor: pickerColor,
          //   onColorChanged: changeColor,
          //   showLabel: true, // only on portrait mode
          // ),
          //
          // Use Block color picker:
          //
          // child: BlockPicker(
          //   pickerColor: currentColor,
          //   onColorChanged: changeColor,
          // ),
        ),
        actions: <Widget>[
          FlatButton(
            child: const Text('Close'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  Widget neumorphic() {
    return SizedBox(
      height: 50,
      width: 200,
      child: NeumorphicButton(
        onClick: () {

        },
        shape: boxShape,
        style: NeumorphicStyle(
          shape: this.shape,
          depth: depth,
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
    ];
  }
}
