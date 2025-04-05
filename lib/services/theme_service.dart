import 'package:flutter/material.dart';
import 'package:material_dev_tools/services/vm_service.dart';

class ThemeService {
  const ThemeService._();

  static Future<ThemeData> fetchTheme() async {
    final themeObj = await VmService.getThemeObj();
    final colorSchemeObj = await VmService.getObj(themeObj, 'colorScheme');
    final primaryObj = await VmService.getObj(colorSchemeObj, 'primary');

    Color primaryColor = VmService.getColor(primaryObj!);
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
    );
    // setState(() {
    //   themeData = ThemeData(
    //     colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
    //   );
    // });
    //
    // return themeData;
  }
}
