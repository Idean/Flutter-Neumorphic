import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class NeumorphicApp extends StatelessWidget {
  final String title;
  final ThemeMode themeMode;
  final NeumorphicThemeData theme;
  final NeumorphicThemeData darkTheme;
  final NeumorphicThemeData materialDarkTheme;
  final NeumorphicThemeData materialTheme;
  final String initialRoute;
  final Color color;
  final Iterable<LocalizationsDelegate<dynamic>> localizationsDelegates;
  final Locale locale;
  final Widget home;
  final Iterable<Locale> supportedLocales;
  final Map<String, WidgetBuilder> routes;
  final RouteFactory onGenerateRoute;
  final RouteFactory onUnknownRoute;
  final GenerateAppTitle onGenerateTitle;
  final GlobalKey<NavigatorState> navigatorKey;
  final List<NavigatorObserver> navigatorObservers;
  final InitialRouteListFactory onGenerateInitialRoutes;
  final bool debugShowCheckedModeBanner;

  const NeumorphicApp({
    Key key,
    this.title = '',
    this.color,
    this.initialRoute,
    this.routes = const {},
    this.home,
    this.debugShowCheckedModeBanner = true,
    this.navigatorKey,
    this.navigatorObservers = const [],
    this.onGenerateRoute,
    this.onGenerateTitle,
    this.onGenerateInitialRoutes,
    this.onUnknownRoute,
    this.theme = neumorphicDefaultTheme,
    this.darkTheme = neumorphicDefaultDarkTheme,
    this.locale,
    this.localizationsDelegates,
    this.supportedLocales = const <Locale>[Locale('en', 'US')],
    this.themeMode = ThemeMode.system,
    this.materialDarkTheme,
    this.materialTheme,
  }) : super(key: key);

  ThemeData _getMaterialTheme(NeumorphicThemeData theme) {
    final color = theme.accentColor;

    if (color is MaterialColor) {
      return ThemeData(
        primarySwatch: color,
        textTheme: theme.textTheme,
        scaffoldBackgroundColor: theme.baseColor,
      );
    }

    return ThemeData(
      primaryColor: theme.accentColor,
      accentColor: theme.variantColor,
      brightness: ThemeData.estimateBrightnessForColor(theme.baseColor),
      primaryColorBrightness:
          ThemeData.estimateBrightnessForColor(theme.accentColor),
      accentColorBrightness:
          ThemeData.estimateBrightnessForColor(theme.variantColor),
      textTheme: theme.textTheme,
      scaffoldBackgroundColor: theme.baseColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    final materialTheme = this.materialTheme ?? _getMaterialTheme(theme);
    final materialDarkTheme =
        this.materialDarkTheme ?? _getMaterialTheme(darkTheme);
    return NeumorphicTheme(
      theme: theme,
      darkTheme: darkTheme,
      themeMode: themeMode,
      child: MaterialApp(
        title: title,
        color: color,
        theme: materialTheme,
        darkTheme: materialDarkTheme,
        initialRoute: initialRoute,
        routes: routes,
        themeMode: themeMode,
        localizationsDelegates: localizationsDelegates,
        supportedLocales: supportedLocales,
        locale: locale,
        home: home,
        onGenerateRoute: onGenerateRoute,
        onUnknownRoute: onUnknownRoute,
        onGenerateTitle: onGenerateTitle,
        onGenerateInitialRoutes: onGenerateInitialRoutes,
        navigatorKey: navigatorKey,
        navigatorObservers: navigatorObservers,
        debugShowCheckedModeBanner: debugShowCheckedModeBanner,
      ),
    );
  }
}
