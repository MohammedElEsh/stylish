import 'package:flutter/material.dart';

extension ContextExtensions on BuildContext {
  // Theme
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
  TextTheme get textTheme => Theme.of(this).textTheme;

  // Media queries
  double get width => MediaQuery.sizeOf(this).width;
  double get height => MediaQuery.sizeOf(this).height;
  bool get isLandscape => MediaQuery.orientationOf(this) == Orientation.landscape;
  double get keyboardHeight => MediaQuery.viewInsetsOf(this).bottom;
  EdgeInsets get padding => MediaQuery.paddingOf(this);
  EdgeInsets get viewInsets => MediaQuery.viewInsetsOf(this);
  EdgeInsets get viewPadding => MediaQuery.viewPaddingOf(this);

  // Navigation shortcuts
  void pop<T extends Object?>([T? result]) => Navigator.of(this).pop(result);

  void pushNamed(String routeName, {Object? arguments}) =>
      Navigator.of(this).pushNamed(routeName, arguments: arguments);

  void pushReplacementNamed(String routeName, {Object? arguments}) =>
      Navigator.of(this).pushReplacementNamed(routeName, arguments: arguments);

  // Scaffold
  void showSnackBar(String message, {Color? backgroundColor}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor ?? Theme.of(this).colorScheme.primary,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void hideSnackBar() => ScaffoldMessenger.of(this).hideCurrentSnackBar();

  void openDrawer() => Scaffold.of(this).openDrawer();

  void openEndDrawer() => Scaffold.of(this).openEndDrawer();

  // Focus
  void unfocusKeyboard() => FocusScope.of(this).unfocus();

  // Dialogs
  Future<T?> showAppDialog<T>(Widget child, {bool barrierDismissible = true}) {
    return showDialog<T>(
      context: this,
      barrierDismissible: barrierDismissible,
      builder: (_) => Dialog(child: child),
    );
  }

  // Safe area
  bool get hasNotch => padding.top > 24;
}
