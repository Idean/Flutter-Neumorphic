import 'package:example/lib/top_bar.dart';
import 'package:example/samples/widgets_sample.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'checkbox/widget_checkbox.dart';
import 'container/widget_container.dart';
import 'indeterminate_progress/widget_indeterminate_progress.dart';
import 'indicator/widget_indicator.dart';
import 'radiobutton/widget_radio_button.dart';
import 'slider/widget_slider.dart';
import 'switch/widget_switch.dart';
import 'progress/widget_progress.dart';

class WidgetsHome extends StatelessWidget {
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
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  TopBar(title: "Widgets"),
                  _buildButton(
                      text: "Container",
                      onClick: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                          return ContainerWidgetPage();
                        }));
                      }),
                  _buildButton(
                      text: "Button",
                      onClick: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                          return WidgetsSample();
                        }));
                      }),
                  _buildButton(
                      text: "RadioButton",
                      onClick: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                          return RadioButtonWidgetPage();
                        }));
                      }),
                  _buildButton(
                      text: "Checkbox",
                      onClick: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                          return CheckboxWidgetPage();
                        }));
                      }),
                  _buildButton(
                      text: "Switch",
                      onClick: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                          return SwitchWidgetPage();
                        }));
                      }),
                  _buildButton(
                      text: "Slider",
                      onClick: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                          return SliderWidgetPage();
                        }));
                      }),
                  _buildButton(
                      text: "Indicator",
                      onClick: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                          return IndicatorWidgetPage();
                        }));
                      }),
                  _buildButton(
                      text: "Progress",
                      onClick: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                          return ProgressWidgetPage();
                        }));
                      }),
                  _buildButton(
                      text: "IndeterminateProgress",
                      onClick: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                          return IndeterminateProgressWidgetPage();
                        }));
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
