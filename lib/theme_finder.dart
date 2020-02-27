/* nullable */
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'flutter_neumorphic.dart';

enum CurrentTheme { LIGHT, DARK, SYSTEM }

class ThemeHost {
  final NeumorphicTheme theme;
  final NeumorphicTheme darkTheme;
  final CurrentTheme currentTheme;

  const ThemeHost({
    @required this.theme,
    this.darkTheme,
    this.currentTheme = CurrentTheme.SYSTEM,
  });

  bool get useDark => darkTheme != null && (
      //forced to use DARK by user
      currentTheme == CurrentTheme.DARK ||
      //The setting indicating the current brightness mode of the host platform. If the platform has no preference, platformBrightness defaults to Brightness.light.
      window.platformBrightness == Brightness.dark
  );

  NeumorphicTheme getCurrentTheme() {
    if(useDark){
      return darkTheme;
    } else {
      return theme;
    }
  }
}

class NeumorphicThemeProvider extends StatelessWidget {
  final Widget child;
  final ThemeHost _themeHost;

  NeumorphicThemeProvider({
    @required this.child,
    NeumorphicTheme theme = neumorphicDefaultTheme,
    NeumorphicTheme darkTheme = neumorphicDefaultDarkTheme,
    CurrentTheme currentTheme,
  }) : this._themeHost = ThemeHost(
          theme: theme,
          currentTheme: currentTheme,
          darkTheme: darkTheme,
        );

  @override
  Widget build(BuildContext context) {
    return Provider.value(value: this._themeHost, child: this.child);
  }

  static NeumorphicTheme of(BuildContext context) {
    try {
      final ThemeHost host = Provider.of<ThemeHost>(context);
      return host.getCurrentTheme();
    } catch (t) {
      return null;
    }
  }

  static bool useDark(BuildContext context) {
    try {
      final ThemeHost host = Provider.of<ThemeHost>(context);
      return host.useDark;
    } catch (t) {
      return null;
    }
  }
}
