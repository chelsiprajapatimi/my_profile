import 'package:flutter/material.dart';

extension ThemeDataExtension on BuildContext {
  /// to get text theme
  TextTheme get textTheme => Theme.of(this).textTheme;

  /// to get primary theme color
  Color get themeColor => Theme.of(this).primaryColor;

  /// to get primary dark theme color
  Color get themeDarkColor => Theme.of(this).primaryColorDark;
}
