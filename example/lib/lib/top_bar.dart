import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'back_button.dart';

class TopBar extends StatelessWidget {
  final String title;

  TopBar({this.title = ""});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18.0),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(alignment: Alignment.centerLeft, child: NeumorphicBack()),
          Center(
            child: Text(
              this.title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: NeumorphicTheme.isUsingDark(context) ? Colors.white70 : Colors.black87,
              ),
            ),
          )
        ],
      ),
    );
  }
}
