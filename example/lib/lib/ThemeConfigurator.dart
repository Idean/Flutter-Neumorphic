import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'ThemeColorSelector.dart';

class ThemeConfigurator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return NeumorphicButton(
      padding: EdgeInsets.all(18),
      style: NeumorphicStyle(
        shape: NeumorphicShape.flat,
        boxShape: NeumorphicBoxShape.circle(),
      ),
      child: Icon(
        Icons.settings,
        color: NeumorphicTheme.isUsingDark(context)
            ? Colors.white70
            : Colors.black87,
      ),
      onPressed: () {
        _changeColor(context);
      },
    );
  }

  void _changeColor(BuildContext context) {
    showDialog(
        useRootNavigator: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Update Theme'),
            content: SingleChildScrollView(
              child: _ThemeConfiguratorDialog(contextContainingTheme: context),
            ),
            actions: <Widget>[
              NeumorphicButton(
                child: const Text('Close'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}

class _ThemeConfiguratorDialog extends StatefulWidget {
  final BuildContext contextContainingTheme;

  _ThemeConfiguratorDialog({required this.contextContainingTheme});

  @override
  _ThemeConfiguratorState createState() => _ThemeConfiguratorState();
}

class _ThemeConfiguratorState extends State<_ThemeConfiguratorDialog> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ThemeColorSelector(
          customContext: widget.contextContainingTheme,
        ),
        intensitySelector(),
        depthSelector(),
      ],
    );
  }

  Widget intensitySelector() {
    final intensity = NeumorphicTheme.intensity(widget.contextContainingTheme);
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
            value: intensity!,
            onChanged: (value) {
              setState(() {
                NeumorphicTheme.update(
                  widget.contextContainingTheme,
                  (current) => current!.copyWith(
                    intensity: value,
                  ),
                );
              });
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 12),
          child: Container(
            width: 40,
            child: Text(((intensity * 100).floor() / 100).toString()),
          ),
        ),
      ],
    );
  }

  Widget depthSelector() {
    final depth = NeumorphicTheme.depth(widget.contextContainingTheme);

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
            value: depth!,
            onChanged: (value) {
              setState(() {
                NeumorphicTheme.update(
                  widget.contextContainingTheme,
                  (current) => current!.copyWith(depth: value),
                );
              });
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 12),
          child: Container(
            width: 40,
            child: Text(depth.floor().toString()),
          ),
        ),
      ],
    );
  }
}
