
import 'dart:ui';

import 'package:flutter/foundation.dart';

import 'theme.dart';
import 'used_theme.dart';

export 'theme.dart';
export 'used_theme.dart';

/// A immutable contained by the NeumorhicTheme
/// That will save the current definition of the theme
/// It will be accessible to the childs widgets by an InheritedWidget
class ThemeWrapper {

  final NeumorphicThemeData theme;
  final NeumorphicThemeData darkTheme;
  final UsedTheme usedTheme;

  const ThemeWrapper({
    @required this.theme,
    this.darkTheme,
    this.usedTheme = UsedTheme.SYSTEM,
  });

  bool get useDark =>
      darkTheme != null &&
          (
              //forced to use DARK by user
              usedTheme == UsedTheme.DARK ||
                  //The setting indicating the current brightness mode of the host platform. If the platform has no preference, platformBrightness defaults to Brightness.light.
                  window.platformBrightness == Brightness.dark);

  NeumorphicThemeData get current {
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
              usedTheme == other.usedTheme;

  @override
  int get hashCode =>
      theme.hashCode ^ darkTheme.hashCode ^ usedTheme.hashCode;

  ThemeWrapper copyWith({
    NeumorphicThemeData theme,
    NeumorphicThemeData darkTheme,
    UsedTheme currentTheme,
  }) {
    return new ThemeWrapper(
      theme: theme ?? this.theme,
      darkTheme: darkTheme ?? this.darkTheme,
      usedTheme: currentTheme ?? this.usedTheme,
    );
  }
}