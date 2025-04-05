import 'package:flutter/material.dart';

/// Class to manage theme override across the application
class ThemeController {
  ThemeController._();

  static ThemeMode? _themeMode;
  static final List<VoidCallback> _listeners = [];

  /// Get the overridden theme mode or null if no override is set
  static ThemeMode? get themeMode => _themeMode;

  /// Set an override for the theme mode across the application
  static set themeMode(ThemeMode? themeMode) {
    _themeMode = themeMode;
    _notifyListeners();
  }

  /// Clear any theme mode override
  static void clearOverride() {
    _themeMode = null;
    _notifyListeners();
  }

  /// Add a listener to be notified when the override changes
  static void addListener(VoidCallback listener) {
    _listeners.add(listener);
  }

  /// Remove a previously added listener
  static void removeListener(VoidCallback listener) {
    _listeners.remove(listener);
  }

  /// Notify all listeners of a change
  static void _notifyListeners() {
    for (final listener in _listeners) {
      listener();
    }
  }
}
