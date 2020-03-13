import 'package:example/lib/back_button.dart';
import 'package:example/samples/audio_player_sample.dart';
import 'package:example/samples/calculator_sample.dart';
import 'package:example/samples/credit_card_sample.dart';
import 'package:example/samples/testla_sample.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'widgets.dart';

class WidgetsHome extends StatelessWidget {
  Widget _buildTopBar(BuildContext context) {
    return Row(
      children: <Widget>[
        NeumorphicBack(),
      ],
    );
  }

  Widget _buildButton({String text, VoidCallback onClick}) {
    return NeumorphicButton(
      margin: EdgeInsets.only(bottom: 12),
      boxShape: NeumorphicBoxShape.roundRect(
        borderRadius: BorderRadius.circular(12),
      ),
      padding: EdgeInsets.symmetric(
        vertical: 18,
        horizontal: 24,
      ),
      style: NeumorphicStyle(
        shape: NeumorphicShape.flat,
      ),
      child: Center(child: Text(text)),
      onClick: onClick,
    );
  }

  @override
  Widget build(BuildContext context) {
    return NeumorphicTheme(
      theme: NeumorphicThemeData(depth: 8),
      child: Scaffold(
        backgroundColor: NeumorphicColors.background,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                _buildTopBar(context),
                _buildButton(
                    text: "Container",
                    onClick: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                        return WidgetsPage();
                      }));
                    }),
                _buildButton(
                    text: "Button",
                    onClick: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                        return WidgetsPage();
                      }));
                    }),
                _buildButton(
                    text: "RadioButton",
                    onClick: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                        return WidgetsPage();
                      }));
                    }),
                _buildButton(
                    text: "Checkbox",
                    onClick: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                        return WidgetsPage();
                      }));
                    }),
                _buildButton(
                    text: "Switch",
                    onClick: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                        return WidgetsPage();
                      }));
                    }),
                _buildButton(
                    text: "Slider",
                    onClick: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                        return WidgetsPage();
                      }));
                    }),
                _buildButton(
                    text: "Indicator",
                    onClick: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                        return WidgetsPage();
                      }));
                    }),
                _buildButton(
                    text: "Progress",
                    onClick: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                        return WidgetsPage();
                      }));
                    }),
                _buildButton(
                    text: "IndeterminateProgress",
                    onClick: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                        return WidgetsPage();
                      }));
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
