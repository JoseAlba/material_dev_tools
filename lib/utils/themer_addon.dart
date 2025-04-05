import 'package:flutter/material.dart';
import 'package:material_dev_tools/utils/theme_controller.dart';
import 'package:widgetbook/widgetbook.dart' hide ThemeBuilder;

/// A [WidgetbookAddon] for wrapping use-cases with [ThemeMode] widget.
class ThemeModeAddon extends WidgetbookAddon<ThemeMode> {
  ThemeModeAddon({this.initialMode = ThemeMode.system})
    : super(name: 'ThemeMode');

  final ThemeMode initialMode;

  static final modes = {
    ThemeMode.system: 'System',
    ThemeMode.light: 'Light',
    ThemeMode.dark: 'Dark',
  };

  @override
  List<Field<ThemeMode>> get fields {
    return [
      ListField<ThemeMode>(
        name: 'ThemeMode',
        initialValue: initialMode,
        values: modes.keys.toList(),
        labelBuilder: (value) => modes[value]!,
      ),
    ];
  }

  @override
  ThemeMode valueFromQueryGroup(Map<String, String> group) {
    return valueOf<ThemeMode>('ThemeMode', group)!;
  }

  @override
  Widget buildUseCase(BuildContext context, Widget child, ThemeMode setting) {
    return _ThemeModeOverride(themeMode: setting, child: child);
  }
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
    ThemeController.themeMode = widget.themeMode;
  }

  @override
  void didUpdateWidget(_ThemeModeOverride oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.themeMode != widget.themeMode) {
      ThemeController.themeMode = widget.themeMode;
    }
  }

  @override
  void dispose() {
    // Only clear if this is the active override
    if (ThemeController.themeMode == widget.themeMode) {
      ThemeController.clearOverride();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
