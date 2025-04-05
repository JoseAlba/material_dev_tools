import 'package:devtools_extensions/devtools_extensions.dart';
import 'package:flutter/material.dart';
import 'package:material_dev_tools/utils/theme_stateful_widget.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import 'main.directories.g.dart';

void main() async {
  runApp(MaterialDevToolsApp());
}

@widgetbook.App()
class MaterialDevToolsApp extends ThemeStatefulWidget {
  const MaterialDevToolsApp({super.key});

  @override
  ThemeState<MaterialDevToolsApp> createState() =>
      _MaterialDevToolsAppThemeState();
}

class _MaterialDevToolsAppThemeState extends ThemeState<MaterialDevToolsApp> {
  @override
  Widget build(BuildContext context) {
    return DevToolsExtension(
      child: Widgetbook.material(
        addons: [
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
