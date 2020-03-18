import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'theme.dart';
import 'theme_wrapper.dart';
import 'used_theme.dart';

export 'theme.dart';
export 'theme_wrapper.dart';
export 'used_theme.dart';

class NeumorphicThemeInherited extends InheritedWidget {
  final Widget child;
  final ThemeWrapper value;
  final ValueChanged<ThemeWrapper> onChanged;

  NeumorphicThemeInherited(
      {Key key,
      @required this.child,
      @required this.value,
      @required this.onChanged});

  @override
  bool updateShouldNotify(NeumorphicThemeInherited old) => value != old.value;

  NeumorphicThemeData get current {
    return this.value.current;
  }

  bool get isUsingDark {
    return value.useDark;
  }

  UsedTheme get usedTheme => value.usedTheme;

  set usedTheme(UsedTheme currentTheme) {
    this.onChanged(value.copyWith(currentTheme: currentTheme));
  }

  void updateCurrentTheme(NeumorphicThemeData update) {
    if (value.useDark) {
      final newValue = value.copyWith(darkTheme: update);
      //this.value = newValue;
      this.onChanged(newValue);
    } else {
      final newValue = value.copyWith(theme: update);
      //this.value = newValue;
      this.onChanged(newValue);
    }
  }
}
