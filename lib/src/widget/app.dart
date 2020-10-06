import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class NeumorphicApp extends StatelessWidget {
  final String title;
  final ThemeMode themeMode;
  final NeumorphicThemeData theme;
  final NeumorphicThemeData darkTheme;
  final ThemeData materialDarkTheme;
  final ThemeData materialTheme;
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
  final Function(BuildContext, Widget) builder;
  final Function(Locale, Iterable<Locale>) localeResolutionCallback;
  final ThemeData highContrastTheme;
  final ThemeData highContrastDarkTheme;
  final LocaleListResolutionCallback localeListResolutionCallback;
  final bool showPerformanceOverlay;
  final bool checkerboardRasterCacheImages;
  final bool checkerboardOffscreenLayers;
  final bool showSemanticsDebugger;
  final Map<LogicalKeySet, Intent> shortcuts;
  final Map<Type, Action<Intent>> actions;

  final bool debugShowMaterialGrid;

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
    this.builder,
    this.localeResolutionCallback,
    this.highContrastTheme,
    this.highContrastDarkTheme,
    this.localeListResolutionCallback,
    this.showPerformanceOverlay = false,
    this.checkerboardRasterCacheImages = false,
    this.checkerboardOffscreenLayers = false,
    this.showSemanticsDebugger = false,
    this.debugShowMaterialGrid = false,
    this.shortcuts,
    this.actions,
  }) : super(key: key);

  ThemeData _getMaterialTheme(NeumorphicThemeData theme) {
    final color = theme.accentColor;

    if (color is MaterialColor) {
      return ThemeData(
        primarySwatch: color,
        textTheme: theme.textTheme,
        iconTheme: theme.iconTheme,
        scaffoldBackgroundColor: theme.baseColor,
      );
    }

    return ThemeData(
      primaryColor: theme.accentColor,
      accentColor: theme.variantColor,
      iconTheme: theme.iconTheme,
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
      child: Builder(
        builder: (context) => IconTheme(
          data: NeumorphicTheme.currentTheme(context).iconTheme,
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
              builder: builder,
              localeResolutionCallback: localeResolutionCallback,
              highContrastTheme: highContrastTheme,
              highContrastDarkTheme: highContrastDarkTheme,
              localeListResolutionCallback: localeListResolutionCallback,
              showPerformanceOverlay: showPerformanceOverlay,
              checkerboardRasterCacheImages: checkerboardRasterCacheImages,
              checkerboardOffscreenLayers: checkerboardOffscreenLayers,
              showSemanticsDebugger: showSemanticsDebugger,
              shortcuts: shortcuts,
              actions: actions,
              debugShowMaterialGrid: debugShowMaterialGrid),
        ),
      ),
    );
  }
}
