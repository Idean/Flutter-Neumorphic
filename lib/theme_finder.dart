/* nullable */
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'flutter_neumorphic.dart';

enum CurrentTheme { LIGHT, DARK, SYSTEM }

//FORCE TO USE LIGHT THEME FOR NOW, WORK IN PROGRESS
const _DARK_THEME_ENABLED = true;

class ThemeHost {
  NeumorphicThemeData theme;
  NeumorphicThemeData darkTheme;
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

  NeumorphicThemeData getCurrentTheme() {
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

  void updateCurrentTheme(NeumorphicThemeData themeData) {
    if(useDark){
      darkTheme = darkTheme.copyFrom(other: themeData);
    } else {
      theme = theme.copyFrom(other: themeData);
    }
  }
}

class NeumorphicTheme extends StatefulWidget {

  final NeumorphicThemeData theme;
  final NeumorphicThemeData darkTheme;
  final Widget child;
  final CurrentTheme currentTheme;

  NeumorphicTheme({
    Key key,
    @required this.child,
    this.theme = neumorphicDefaultTheme,
    this.darkTheme = neumorphicDefaultDarkTheme,
    this.currentTheme,
  });

  @override
  _NeumorphicThemeState createState() => _NeumorphicThemeState();


  static NeumorphicThemeInherited of(BuildContext context) {
    try {
      return context.dependOnInheritedWidgetOfExactType<NeumorphicThemeInherited>();
    } catch (t) {
      return null;
    }
  }

  static Color accentColor(BuildContext context) {
    return getCurrentTheme(context).accentColor;
  }

  static Color baseColor(BuildContext context) {
    return getCurrentTheme(context).baseColor;
  }

  static Color variantColor(BuildContext context) {
    return getCurrentTheme(context).variantColor;
  }

  static NeumorphicThemeData getCurrentTheme(BuildContext context) {
    try {
      final provider = NeumorphicTheme.of(context);
      return provider.current;
    } catch (t) {
      return null;
    }
  }
}

class _NeumorphicThemeState extends State<NeumorphicTheme> {

  ThemeHost _themeHost;

  @override
  void initState() {
    super.initState();
    _themeHost = ThemeHost(
      theme: widget.theme,
      currentTheme: widget.currentTheme,
      darkTheme: widget.darkTheme,
    );
  }

  @override
  void didUpdateWidget(NeumorphicTheme oldWidget) {
    super.didUpdateWidget(oldWidget);
    setState(() {
      _themeHost = ThemeHost(
        theme: widget.theme,
        currentTheme: widget.currentTheme,
        darkTheme: widget.darkTheme,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return NeumorphicThemeInherited(
      value: _themeHost,
      onChanged: (value){
        setState(() {

        });
      },
      child: widget.child,
    );
  }
}


class NeumorphicThemeInherited extends InheritedWidget {
  final Widget child;
  final ThemeHost value;
  final ValueChanged<ThemeHost> onChanged;

  NeumorphicThemeInherited({
    Key key,
    @required this.child,
    @required this.value,
    @required this.onChanged
  });

  @override
  bool updateShouldNotify(NeumorphicThemeInherited old) => value != old.value;

  NeumorphicThemeData get current {
    return this.value.getCurrentTheme();
  }

  bool isUsingDark() {
    return value.useDark;
  }

  void setCurrentTheme(CurrentTheme currentTheme) {
    value.currentTheme = currentTheme;
    this.onChanged(value);
  }

  void updateCurrentTheme(NeumorphicThemeData update) {
    value.updateCurrentTheme(update);
    this.onChanged(value);
  }
}
