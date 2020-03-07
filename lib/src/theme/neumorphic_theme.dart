import 'package:flutter/widgets.dart';

import 'inherited_neumorphic_theme.dart';
import 'theme.dart';
import 'theme_wrapper.dart';
import 'used_theme.dart';

export 'theme.dart';
export 'theme_wrapper.dart';
export 'used_theme.dart';
export 'inherited_neumorphic_theme.dart';


/// The NeumorphicTheme (provider)
/// 1. Defines the used neumorphic theme used in child widgets
///
///   @see NeumorphicThemeData
///
///   NeumorphicTheme(
///     theme: NeumorphicThemeData(...),
///     darkTheme: NeumorphicThemeData(...),
///     currentTheme: CurrentTheme.LIGHT,
///     child: ...
///
/// 2. Provide by static methods the current theme
///
///   NeumorphicThemeData theme = NeumorphicTheme.getCurrentTheme(context);
///
/// 3. Provide by static methods the current theme's colors
///
///   Color baseColor = NeumorphicTheme.baseColor(context);
///   Color accent = NeumorphicTheme.accentColor(context);
///   Color variant = NeumorphicTheme.variantColor(context);
///
/// 4. Tells if the current theme is dark
///
///   bool dark = NeumorphicTheme.isUsingDark(context);
///
/// 5. Provides a way to update the current theme
///
///   NeumorphicTheme.of(context).updateCurrentTheme(
///     NeumorphicThemeData(
///       /* new values */
///     )
///   )
///
class NeumorphicTheme extends StatefulWidget {
  final NeumorphicThemeData theme;
  final NeumorphicThemeData darkTheme;
  final Widget child;
  final UsedTheme usedTheme;

  NeumorphicTheme({
    Key key,
    @required this.child,
    this.theme = neumorphicDefaultTheme,
    this.darkTheme = neumorphicDefaultDarkTheme,
    this.usedTheme,
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

  static bool isUsingDark(BuildContext context) {
    return of(context).isUsingDark;
  }

  static Color accentColor(BuildContext context) {
    return currentTheme(context).accentColor;
  }

  static Color baseColor(BuildContext context) {
    return currentTheme(context).baseColor;
  }

  static Color variantColor(BuildContext context) {
    return currentTheme(context).variantColor;
  }

  static NeumorphicThemeData currentTheme(BuildContext context) {
    try {
      final provider = NeumorphicTheme.of(context);
      return provider.current;
    } catch (t) {
      return null;
    }
  }
}

class _NeumorphicThemeState extends State<NeumorphicTheme> {
  ThemeWrapper _themeHost;

  @override
  void initState() {
    super.initState();
    _themeHost = ThemeWrapper(
      theme: widget.theme,
      usedTheme: widget.usedTheme,
      darkTheme: widget.darkTheme,
    );
  }

  @override
  void didUpdateWidget(NeumorphicTheme oldWidget) {
    super.didUpdateWidget(oldWidget);
    setState(() {
      _themeHost = ThemeWrapper(
        theme: widget.theme,
        usedTheme: widget.usedTheme,
        darkTheme: widget.darkTheme,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return NeumorphicThemeInherited(
      value: _themeHost,
      onChanged: (value) {
        setState(() {
          _themeHost = value;
        });
      },
      child: widget.child,
    );
  }
}
