import 'package:example/lib/back_button.dart';
import 'package:example/samples/audio_player_sample.dart';
import 'package:example/samples/calculator_sample.dart';
import 'package:example/samples/credit_card_sample.dart';
import 'package:example/samples/testla_sample.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class SamplesHome extends StatelessWidget {
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
                    text: "Tesla",
                    onClick: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                        return TeslaSample();
                      }));
                    }),
                _buildButton(
                    text: "Audio Player",
                    onClick: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                        return AudioPlayerSample();
                      }));
                    }),
                _buildButton(
                    text: "Calculator",
                    onClick: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                        return CalculatorSample();
                      }));
                    }),
                _buildButton(
                    text: "CreditCard",
                    onClick: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                        return CreditCardSample();
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
