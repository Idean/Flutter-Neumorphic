/* nullable */
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'flutter_neumorphic.dart';

enum CurrentTheme { LIGHT, DARK, SYSTEM }

//FORCE TO USE LIGHT THEME FOR NOW, WORK IN PROGRESS
const _DARK_THEME_ENABLED = true;

class ThemeHost {
  NeumorphicTheme theme;
  NeumorphicTheme darkTheme;
  CurrentTheme _currentTheme;

  ThemeHost({
    @required this.theme,
    this.darkTheme,
    CurrentTheme currentTheme = CurrentTheme.SYSTEM,
  }) : _currentTheme = currentTheme;

  bool get useDark =>
      _DARK_THEME_ENABLED &&
      darkTheme != null &&
      (
          //forced to use DARK by user
          currentTheme == CurrentTheme.DARK ||
              //The setting indicating the current brightness mode of the host platform. If the platform has no preference, platformBrightness defaults to Brightness.light.
              window.platformBrightness == Brightness.dark);

  NeumorphicTheme getCurrentTheme() {
    if (useDark) {
      return darkTheme;
    } else {
      return theme;
    }
  }

  CurrentTheme get currentTheme => _currentTheme;

  set currentTheme(CurrentTheme value) {
    _currentTheme = value;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is ThemeHost && runtimeType == other.runtimeType && theme == other.theme && darkTheme == other.darkTheme && currentTheme == other.currentTheme;

  @override
  int get hashCode => theme.hashCode ^ darkTheme.hashCode ^ currentTheme.hashCode;
}

class NeumorphicThemeProvider extends InheritedWidget {
  final Widget child;
  final ThemeHost _themeHost;

  NeumorphicThemeProvider({
    Key key,
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
  bool updateShouldNotify(NeumorphicThemeProvider old) => _themeHost != old._themeHost;

  static NeumorphicThemeProvider of(BuildContext context) {
    try {
      return context.dependOnInheritedWidgetOfExactType<NeumorphicThemeProvider>();
    } catch (t) {
      return null;
    }
  }

  static NeumorphicTheme findNeumorphicTheme(BuildContext context) {
    try {
      final provider = NeumorphicThemeProvider.of(context);
      return provider.neumorphicTheme();
    } catch (t) {
      return null;
    }
  }

  NeumorphicTheme neumorphicTheme() {
    return this._themeHost.getCurrentTheme();
  }

  bool isUsingDark() {
    return _themeHost.useDark;
  }

  void setCurrentTheme(CurrentTheme currentTheme) {
    _themeHost.currentTheme = currentTheme;
  }
}
