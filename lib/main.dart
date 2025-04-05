import 'package:devtools_extensions/devtools_extensions.dart';
import 'package:flutter/material.dart';
import 'package:material_dev_tools/utils/theme_stateful_widget.dart';
import 'package:material_dev_tools/utils/themer_addon.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import 'main.directories.g.dart';

void main() async {
  runApp(MaterialDevToolsApp());
}

// class ThemeTesting extends ThemeWidget {
//   const ThemeTesting({super.key, required super.builder});
//
//   @override
//   Widget build(BuildContext context) {
//     this.theme,
//     // return
//     return const Placeholder();
//   }
// }

@widgetbook.App()
class MaterialDevToolsApp extends ThemeWidget {
  const MaterialDevToolsApp({super.key});

  @override
  Widget build(BuildContext context, ThemeData theme) {
    return DevToolsExtension(
      child: Widgetbook.material(
        themeMode: ThemeMode.dark,
        addons: [
          ThemeModeAddon(),
          TextScaleAddon(min: 1.0, max: 4.0),
          DeviceFrameAddon(
            devices: [Devices.ios.iPhoneSE, Devices.ios.iPhone13],
          ),
          AlignmentAddon(initialAlignment: Alignment.center),
          InspectorAddon(enabled: true),
          TimeDilationAddon(),
          ZoomAddon(initialZoom: 1.0),
        ],
        directories: directories,
      ),
    );
  }
}
