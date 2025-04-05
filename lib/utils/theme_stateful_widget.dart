import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:material_dev_tools/services/theme_service.dart';
import 'package:material_dev_tools/utils/theme_cache.dart';
import 'package:material_dev_tools/utils/theme_controller.dart';

typedef ThemeBuilder =
    Widget Function(BuildContext context, ThemeData theme, Widget? child);

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
  late ThemeMode _themeMode;
  late ThemeData _lightTheme;
  late ThemeData _darkTheme;

  // final ThemeController _controller = ThemeController();

  /// Gets the currently active theme based on themeMode and system brightness
  ThemeData get theme {
    final systemBrightness =
        WidgetsBinding.instance.platformDispatcher.platformBrightness;

    // Use the overridden theme mode if available, otherwise use _themeMode
    final effectiveThemeMode = ThemeController.themeMode ?? _themeMode;

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

    // Initialize with cached values if available, otherwise use defaults
    if (ThemeCache.hasCache()) {
      _themeMode = ThemeCache.cachedThemeMode!;
      _lightTheme = ThemeCache.cachedLightTheme!;
      _darkTheme = ThemeCache.cachedDarkTheme!;
    } else {
      _themeMode = _defaultThemeMode;
      _lightTheme = _defaultLightTheme;
      _darkTheme = _defaultDarkTheme;
    }

    // Add listener for theme override changes
    ThemeController.addListener(_handleThemeOverrideChange);

    SchedulerBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 1), _getTheme);
    });
  }

  @override
  void dispose() {
    // Remove listener when disposed
    ThemeController.removeListener(_handleThemeOverrideChange);
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

      // Check if theme values have actually changed
      bool themeChanged =
          themeRecord.$1 != _themeMode ||
          themeRecord.$2 != _lightTheme ||
          themeRecord.$3 != _darkTheme;

      if (themeChanged) {
        // Update instance variables
        _themeMode = themeRecord.$1;
        _lightTheme = themeRecord.$2;
        _darkTheme = themeRecord.$3;

        // Update global cache
        ThemeCache.updateCache(_themeMode, _lightTheme, _darkTheme);

        // Only call setState if there were actual changes
        setState(() {});
      }
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
