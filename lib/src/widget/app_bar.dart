import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_neumorphic/src/widget/back_button.dart';

class NeumorphicAppBar extends StatefulWidget implements PreferredSizeWidget {
  static const toolbarHeight = kToolbarHeight + 16 * 2;
  static const defaultSpacing = 4.0;

  /// The primary widget displayed in the app bar.
  ///
  /// Typically a [Text] widget that contains a description of the current
  /// contents of the app.
  final Widget title;

  /// A widget to display before the [title].
  ///
  /// Typically the [leading] widget is an [Icon] or an [IconButton].
  ///
  /// Becomes the leading component of the [NavigationToolBar] built
  /// by this widget. The [leading] widget's width and height are constrained to
  /// be no bigger than toolbar's height, which is [kToolbarHeight].
  ///
  /// If this is null and [automaticallyImplyLeading] is set to true, the
  /// [NeumorphicAppBar] will imply an appropriate widget. For example, if the [NeumorphicAppBar] is
  /// in a [Scaffold] that also has a [Drawer], the [Scaffold] will fill this
  /// widget with an [IconButton] that opens the drawer (using [Icons.menu]). If
  /// there's no [Drawer] and the parent [Navigator] can go back, the [NeumorphicAppBar]
  /// will use a [NeumorphicBackButton] that calls [Navigator.maybePop].
  final Widget leading;

  /// Whether the title should be centered.
  ///
  /// Defaults to being adapted to the current [TargetPlatform].
  final bool centerTitle;

  /// Widgets to display in a row after the [title] widget.
  ///
  /// Typically these widgets are [IconButton]s representing common operations.
  /// For less common operations, consider using a [PopupMenuButton] as the
  /// last action.
  ///
  /// The [actions] become the trailing component of the [NavigationToolBar] built
  /// by this widget. The height of each action is constrained to be no bigger
  /// than the toolbar's height, which is [kToolbarHeight].
  final List<Widget> actions;

  /// Controls whether we should try to imply the leading widget if null.
  ///
  /// If true and [leading] is null, automatically try to deduce what the leading
  /// widget should be. If false and [leading] is null, leading space is given to [title].
  /// If leading widget is not null, this parameter has no effect.
  final bool automaticallyImplyLeading;

  /// The spacing around [title] content on the horizontal axis. This spacing is
  /// applied even if there is no [leading] content or [actions]. If you want
  /// [title] to take all the space available, set this value to 0.0.
  ///
  /// Defaults to [NavigationToolbar.kMiddleSpacing].
  final double titleSpacing;

  /// The spacing [actions] left side, useful to have spacing between actions
  ///
  /// Defaults to [NeumorphicAppBar.defaultSpacing].
  final double actionSpacing;

  /// Force background color of the app bar
  final Color color;

  /// Force color of the icon inside app bar
  final IconThemeData iconTheme;

  @override
  final Size preferredSize;

  final NeumorphicStyle buttonStyle;

  final EdgeInsets buttonPadding;

  final TextStyle textStyle;

  final double padding;

  NeumorphicAppBar({
    Key key,
    this.title,
    this.buttonPadding,
    this.buttonStyle,
    this.iconTheme,
    this.color,
    this.actions,
    this.textStyle,
    this.leading,
    this.automaticallyImplyLeading = true,
    this.centerTitle,
    this.titleSpacing = NavigationToolbar.kMiddleSpacing,
    this.actionSpacing = defaultSpacing,
    this.padding = 16,
  })  : preferredSize = Size.fromHeight(toolbarHeight),
        super(key: key);

  @override
  NeumorphicAppBarState createState() => NeumorphicAppBarState();

  bool _getEffectiveCenterTitle(ThemeData theme, NeumorphicThemeData nTheme) {
    if (centerTitle != null || nTheme.appBarTheme.centerTitle != null)
      return centerTitle ?? nTheme.appBarTheme.centerTitle;
    assert(theme.platform != null);
    switch (theme.platform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return false;
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return actions == null || actions.length < 2;
    }
    return null;
  }
}

class NeumorphicAppBarTheme extends InheritedWidget {
  final Widget child;

  NeumorphicAppBarTheme({this.child}) : super(child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return false;
  }

  static NeumorphicAppBarTheme of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType();
  }
}

class NeumorphicAppBarState extends State<NeumorphicAppBar> {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final nTheme = NeumorphicTheme.of(context);
    final ModalRoute<dynamic> parentRoute = ModalRoute.of(context);
    final bool canPop = parentRoute?.canPop ?? false;
    final bool useCloseButton =
        parentRoute is PageRoute<dynamic> && parentRoute.fullscreenDialog;
    final ScaffoldState scaffold = Scaffold.maybeOf(context);
    final bool hasDrawer = scaffold?.hasDrawer ?? false;
    final bool hasEndDrawer = scaffold?.hasEndDrawer ?? false;

    Widget leading = widget.leading;
    if (leading == null && widget.automaticallyImplyLeading) {
      if (hasDrawer) {
        leading = NeumorphicButton(
          padding: widget.buttonPadding,
          style: widget.buttonStyle,
          child: nTheme.current.appBarTheme.icons.menuIcon,
          onPressed: _handleDrawerButton,
          tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
        );
      } else {
        if (canPop)
          leading = useCloseButton
              ? NeumorphicCloseButton(
                  padding: widget.buttonPadding,
                  style: widget.buttonStyle,
                )
              : NeumorphicBackButton(
                  padding: widget.buttonPadding,
                  style: widget.buttonStyle,
                );
      }
    }
    if (leading != null) {
      leading = ConstrainedBox(
        constraints: const BoxConstraints.tightFor(width: kToolbarHeight),
        child: leading,
      );
    }

    Widget title = widget.title;
    if (title != null) {
      final AppBarTheme appBarTheme = AppBarTheme.of(context);
      title = DefaultTextStyle(
        style: (appBarTheme.textTheme?.headline5 ??
                Theme.of(context).textTheme.headline5)
            .merge(widget.textStyle ?? nTheme.current.appBarTheme.textStyle),
        softWrap: false,
        overflow: TextOverflow.ellipsis,
        child: title,
      );
    }

    Widget actions;
    if (widget.actions != null && widget.actions.isNotEmpty) {
      actions = Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: widget.actions
            .map((child) => Padding(
                  padding: EdgeInsets.only(left: widget.actionSpacing),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints.tightFor(
                        width: kToolbarHeight, height: kToolbarHeight),
                    child: child,
                  ),
                ))
            .toList(growable: false),
      );
    } else if (hasEndDrawer) {
      actions = ConstrainedBox(
        constraints: const BoxConstraints.tightFor(
            width: kToolbarHeight, height: kToolbarHeight),
        child: NeumorphicButton(
          padding: widget.buttonPadding,
          style: widget.buttonStyle,
          child: nTheme.current.appBarTheme.icons.menuIcon,
          onPressed: _handleDrawerButtonEnd,
          tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
        ),
      );
    }
    return Container(
      color: widget.color ?? nTheme.current.appBarTheme.color,
      child: SafeArea(
        bottom: false,
        child: NeumorphicAppBarTheme(
          child: Padding(
            padding: EdgeInsets.all(widget.padding),
            child: IconTheme(
              data: widget.iconTheme ??
                  nTheme.current.appBarTheme.iconTheme ??
                  nTheme.current.iconTheme ??
                  const IconThemeData(),
              child: NavigationToolbar(
                leading: leading,
                middle: title,
                trailing: actions,
                centerMiddle:
                    widget._getEffectiveCenterTitle(theme, nTheme.current),
                middleSpacing: widget.titleSpacing,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _handleDrawerButton() {
    Scaffold.of(context).openDrawer();
  }

  void _handleDrawerButtonEnd() {
    Scaffold.of(context).openEndDrawer();
  }
}
