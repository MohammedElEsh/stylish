import 'package:flutter/material.dart';

import 'dark_theme.dart';
import 'light_theme.dart';

export 'dark_theme.dart';
export 'light_theme.dart';

abstract class AppThemes {
  static ThemeData get light => LightTheme.theme;

  static ThemeData get dark => DarkTheme.theme;
}
