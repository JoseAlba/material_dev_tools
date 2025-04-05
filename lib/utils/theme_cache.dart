import 'package:flutter/material.dart';

/// Global cache for theme values
class ThemeCache {
  ThemeCache._();

  static ThemeMode? cachedThemeMode;
  static ThemeData? cachedLightTheme;
  static ThemeData? cachedDarkTheme;

  static bool hasCache() {
    return cachedThemeMode != null &&
        cachedLightTheme != null &&
        cachedDarkTheme != null;
  }

  static void updateCache(ThemeMode mode, ThemeData light, ThemeData dark) {
    cachedThemeMode = mode;
    cachedLightTheme = light;
    cachedDarkTheme = dark;
  }
}
