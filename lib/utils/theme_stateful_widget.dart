import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:material_dev_tools/services/theme_service.dart';

typedef ThemeBuilder =
    Widget Function(BuildContext context, ThemeData theme, Widget? child);

/// Class to manage theme override across the application
class ThemeOverride {
  static final ThemeOverride _instance = ThemeOverride._internal();

  factory ThemeOverride() => _instance;

  ThemeOverride._internal();

  ThemeMode? _overriddenThemeMode;
  final List<VoidCallback> _listeners = [];

  /// Get the overridden theme mode or null if no override is set
  ThemeMode? get overriddenThemeMode => _overriddenThemeMode;

  /// Set an override for the theme mode across the application
  void setOverride(ThemeMode? themeMode) {
    _overriddenThemeMode = themeMode;
    _notifyListeners();
  }

  /// Clear any theme mode override
  void clearOverride() {
    _overriddenThemeMode = null;
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

class Themer extends ThemeWidget {
  const Themer({super.key, required this.builder, this.child});

  final ThemeBuilder builder;

  final Widget? child;

  @override
  Widget build(BuildContext context, ThemeData theme) {
    return builder(context, theme, child);
  }
}

/// A simple widget that provides access to the theme
abstract class ThemeWidget extends ThemeStatefulWidget {
  const ThemeWidget({super.key});

  Widget build(BuildContext context, ThemeData theme);

  @override
  ThemeState<ThemeWidget> createState() => _ThemeWidgetState();
}

class _ThemeWidgetState extends ThemeState<ThemeWidget> {
  @override
  Widget build(BuildContext context) {
    return widget.build(context, theme);
  }
}

/// A StatefulWidget that manages theme data
abstract class ThemeStatefulWidget extends StatefulWidget {
  const ThemeStatefulWidget({super.key});

  @override
  ThemeState createState();

  @override
  ThemeStatefulElement createElement() => ThemeStatefulElement(this);
}

/// Base state class for ThemeStatefulWidget that handles theme loading and
/// access
abstract class ThemeState<T extends ThemeStatefulWidget> extends State<T> {
  ThemeMode _themeMode = _defaultThemeMode;
  ThemeData _lightTheme = _defaultLightTheme;
  ThemeData _darkTheme = _defaultDarkTheme;

  final ThemeOverride _themeOverride = ThemeOverride();

  /// Gets the currently active theme based on themeMode and system brightness
  ThemeData get theme {
    final systemBrightness =
        WidgetsBinding.instance.platformDispatcher.platformBrightness;

    // Use the overridden theme mode if available, otherwise use _themeMode
    final effectiveThemeMode = _themeOverride.overriddenThemeMode ?? _themeMode;

    return switch (effectiveThemeMode) {
      ThemeMode.dark => _darkTheme,
      ThemeMode.light => _lightTheme,
      ThemeMode.system =>
        systemBrightness == Brightness.dark ? _darkTheme : _lightTheme,
    };
  }

  @override
  @protected
  @mustCallSuper
  void initState() {
    super.initState();

    // Add listener for theme override changes
    _themeOverride.addListener(_handleThemeOverrideChange);

    SchedulerBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 1), _getTheme);
    });
  }

  @override
  void dispose() {
    // Remove listener when disposed
    _themeOverride.removeListener(_handleThemeOverrideChange);
    super.dispose();
  }

  /// Handle theme override changes
  void _handleThemeOverrideChange() {
    if (mounted) {
      setState(() {
        // State is updated when override changes
      });
    }
  }

  /// Loads theme data asynchronously
  Future<void> _getTheme() async {
    try {
      final themeRecord = await MaterialAppService.getMaterialAppData();

      if (!mounted) return;

      _themeMode = themeRecord.$1;
      _lightTheme = themeRecord.$2;
      _darkTheme = themeRecord.$3;
      setState(() {});
    } catch (e) {
      rethrow;
    }
  }


  // Default theme values would be defined here
  static const ThemeMode _defaultThemeMode = ThemeMode.system;
  static final ThemeData _defaultLightTheme = ThemeData.light();
  static final ThemeData _defaultDarkTheme = ThemeData.dark();
}

/// Custom element for ThemeStatefulWidget
class ThemeStatefulElement extends StatefulElement {
  ThemeStatefulElement(super.widget);
}
