import 'package:flutter/material.dart';
import 'package:material_dev_tools/utils/theme_stateful_widget.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default', type: ColorScheme)
Widget colorSchemeDemo(BuildContext context) {
  return ColorSchemeDemo();
}

class ColorSchemeDemo extends ThemeStatefulWidget {
  const ColorSchemeDemo({super.key});

  @override
  ThemeState<ColorSchemeDemo> createState() => _ColorSchemeDemoThemeState();
}

class _ColorSchemeDemoThemeState extends ThemeState<ColorSchemeDemo> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = currentTheme.colorScheme;
    return Container(
      height: 48,
      width: 48,
      color: colorScheme.primary,
      child: Center(child: Text('primary')),
    );
    // return const Placeholder();
  }
}
