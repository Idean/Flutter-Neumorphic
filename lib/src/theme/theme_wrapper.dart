import 'dart:ui';

import 'package:flutter/material.dart';

import 'theme.dart';

export 'theme.dart';

/// A immutable contained by the NeumorhicTheme
/// That will save the current definition of the theme
/// It will be accessible to the childs widgets by an InheritedWidget
class ThemeWrapper {
  final NeumorphicThemeData theme;
  final NeumorphicThemeData? darkTheme;
  final ThemeMode themeMode;

  const ThemeWrapper({
    required this.theme,
    this.darkTheme,
    this.themeMode = ThemeMode.system,
  });

  bool get useDark =>
      //forced to use DARK by user
      themeMode == ThemeMode.dark ||
      //The setting indicating the current brightness mode of the host platform. If the platform has no preference, platformBrightness defaults to Brightness.light.
      (themeMode == ThemeMode.system &&
          window.platformBrightness == Brightness.dark);

  NeumorphicThemeData? get current {
    if (useDark) {
      return darkTheme;
    } else {
      return theme;
    }
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ThemeWrapper &&
          runtimeType == other.runtimeType &&
          theme == other.theme &&
          darkTheme == other.darkTheme &&
          themeMode == other.themeMode;

  @override
  int get hashCode => theme.hashCode ^ darkTheme.hashCode ^ themeMode.hashCode;

  ThemeWrapper copyWith({
    NeumorphicThemeData? theme,
    NeumorphicThemeData? darkTheme,
    ThemeMode? currentTheme,
  }) {
    return new ThemeWrapper(
      theme: theme ?? this.theme,
      darkTheme: darkTheme ?? this.darkTheme,
      themeMode: currentTheme ?? this.themeMode,
    );
  }
}
