import 'package:flutter/material.dart';

/// Class to manage theme override across the application
class ThemeController {
  static final ThemeController _instance = ThemeController._internal();

  factory ThemeController() => _instance;

  ThemeController._internal();

  ThemeMode? _themeMode;
  final List<VoidCallback> _listeners = [];

  /// Get the overridden theme mode or null if no override is set
  ThemeMode? get themeMode => _themeMode;

  /// Set an override for the theme mode across the application
  set themeMode(ThemeMode? themeMode) {
    _themeMode = themeMode;
    _notifyListeners();
  }

  /// Clear any theme mode override
  void clearOverride() {
    _themeMode = null;
    _notifyListeners();
  }

  /// Add a listener to be notified when the override changes
  void addListener(VoidCallback listener) {
    _listeners.add(listener);
  }

  /// Remove a previously added listener
  void removeListener(VoidCallback listener) {
    _listeners.remove(listener);
  }

  /// Notify all listeners of a change
  void _notifyListeners() {
    for (final listener in _listeners) {
      listener();
    }
  }
}
