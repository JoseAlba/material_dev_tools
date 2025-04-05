import 'package:flutter/material.dart';
import 'package:material_dev_tools/utils/theme_stateful_widget.dart';
import 'package:widgetbook/widgetbook.dart' hide ThemeBuilder;

class ThemeModeAddon<T> extends WidgetbookAddon<WidgetbookThemeMode> {
  ThemeModeAddon({required this.modes})
    : assert(modes.isNotEmpty, 'modes cannot be empty'),
      super(name: 'ThemeMode');

  final List<WidgetbookThemeMode> modes;

  @override
  List<Field> get fields {
    return [
      ListField<WidgetbookThemeMode>(
        name: 'name',
        values: modes,
        initialValue: modes.first,
        labelBuilder: (theme) => theme.name,
      ),
    ];
  }

  @override
  WidgetbookThemeMode valueFromQueryGroup(Map<String, String> group) {
    return valueOf('name', group)!;
  }

  @override
  Widget buildUseCase(
    BuildContext context,
    Widget child,
    WidgetbookThemeMode setting,
  ) {
    return _ThemeModeOverride(themeMode: setting.mode, child: child);
  }
}

class WidgetbookThemeMode {
  const WidgetbookThemeMode({required this.name, required this.mode});

  final String name;
  final ThemeMode mode;

  @override
  bool operator ==(covariant WidgetbookThemeMode other) {
    if (identical(this, other)) return true;

    return other.name == name && other.mode == mode;
  }

  @override
  int get hashCode => name.hashCode ^ mode.hashCode;
}

/// Widget that allows overriding the theme mode for its descendants
class _ThemeModeOverride extends StatefulWidget {
  const _ThemeModeOverride({required this.themeMode, required this.child});

  final ThemeMode themeMode;
  final Widget child;

  @override
  State<_ThemeModeOverride> createState() => _ThemeModeOverrideState();
}

class _ThemeModeOverrideState extends State<_ThemeModeOverride> {
  @override
  void initState() {
    super.initState();
    ThemeOverride().setOverride(widget.themeMode);
  }

  @override
  void didUpdateWidget(_ThemeModeOverride oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.themeMode != widget.themeMode) {
      ThemeOverride().setOverride(widget.themeMode);
    }
  }

  @override
  void dispose() {
    // Only clear if this is the active override
    if (ThemeOverride().overriddenThemeMode == widget.themeMode) {
      ThemeOverride().clearOverride();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
