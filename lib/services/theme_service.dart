import 'package:flutter/material.dart';
import 'package:material_dev_tools/services/service_manager_service.dart';
import 'package:material_dev_tools/services/vm_service.dart';
import 'package:material_dev_tools/utils/extensions.dart';
import 'package:vm_service/vm_service.dart' hide VmService;

class MaterialAppService {
  const MaterialAppService._();

  static final _fetchMaterialAppExpression =
      '((){Element? materialAppElement; void findMaterialApp(Element element) { if (element.widget is MaterialApp) { materialAppElement = element; return; } element.visitChildren(findMaterialApp); } WidgetsBinding.instance.rootElement!.visitChildren(findMaterialApp);return materialAppElement?.widget; })()';

  static Future<(ThemeMode, ThemeData, ThemeData)> getMaterialAppData() async {
    final materialAppObj = await getMaterialAppObj();

    final themeModeObj = await VmService.getObj(materialAppObj, 'themeMode');
    final themeMode = getThemeMode(themeModeObj!);

    final themeObj = await VmService.getObj(materialAppObj, 'theme');
    final theme = await getThemeData(themeObj!);

    final darkThemeObj = await VmService.getObj(materialAppObj, 'darkTheme');
    final darkTheme = await getThemeData(darkThemeObj!);

    return (themeMode, theme, darkTheme);
  }

  static Future<Obj?> getMaterialAppObj() async {
    final response = await ServiceManagerService.evalInRunningApp(
      _fetchMaterialAppExpression,
    );
    final materialAppObjectId = (response as InstanceRef).id!;
    return await ServiceManagerService.getObject(materialAppObjectId);
  }

  static ThemeMode getThemeMode(Obj themeModeObj) {
    themeModeObj = themeModeObj as Instance;

    final indexField = themeModeObj.fields!.firstWhere(
      (field) => field.name == 'index',
    );
    final index = int.parse((indexField.value as InstanceRef).valueAsString!);

    return EnumExtension.fromInt(index, ThemeMode.values);
  }

  static Future<ThemeData> getThemeData(Obj themeObj) async {
    final colorSchemeObj = await VmService.getObj(themeObj, 'colorScheme');
    final colorScheme = await getColorScheme(colorSchemeObj!);

    return ThemeData(colorScheme: colorScheme);
  }

  static Future<ColorScheme> getColorScheme(Obj colorSchemeObj) async {
    final brightnessObj = await VmService.getObj(colorSchemeObj, 'brightness');
    final brightness = getBrightness(brightnessObj!);

    final primaryObj = await VmService.getObj(colorSchemeObj, 'primary');
    final primary = getColor(primaryObj!);

    final onPrimaryObj = await VmService.getObj(colorSchemeObj, 'onPrimary');
    final onPrimary = getColor(onPrimaryObj!);

    final secondaryObj = await VmService.getObj(colorSchemeObj, 'secondary');
    final secondary = getColor(secondaryObj!);

    final onSecondaryObj = await VmService.getObj(
      colorSchemeObj,
      'onSecondary',
    );
    final onSecondary = getColor(onSecondaryObj!);

    final errorObj = await VmService.getObj(colorSchemeObj, 'error');
    final error = getColor(errorObj!);

    final onErrorObj = await VmService.getObj(colorSchemeObj, 'onError');
    final onError = getColor(onErrorObj!);

    final surfaceObj = await VmService.getObj(colorSchemeObj, 'surface');
    final surface = getColor(surfaceObj!);

    final onSurfaceObj = await VmService.getObj(colorSchemeObj, 'onSurface');
    final onSurface = getColor(onSurfaceObj!);

    return ColorScheme(
      brightness: brightness,
      primary: primary,
      onPrimary: onPrimary,
      secondary: secondary,
      onSecondary: onSecondary,
      error: error,
      onError: onError,
      surface: surface,
      onSurface: onSurface,
    );
  }

  static Brightness getBrightness(Obj brightnessObj) {
    brightnessObj = brightnessObj as Instance;

    final indexField = brightnessObj.fields!.firstWhere(
      (field) => field.name == 'index',
    );
    final index = int.parse((indexField.value as InstanceRef).valueAsString!);

    return EnumExtension.fromInt(index, Brightness.values);
  }

  static Color getColor(Obj colorObj) {
    colorObj = colorObj as Instance;

    final aField = colorObj.fields!.firstWhere((field) => field.name == "a");
    final a = double.parse((aField.value as InstanceRef).valueAsString!);

    final rField = colorObj.fields!.firstWhere((field) => field.name == "r");
    final r = double.parse((rField.value as InstanceRef).valueAsString!);

    final gField = colorObj.fields!.firstWhere((field) => field.name == "g");
    final g = double.parse((gField.value as InstanceRef).valueAsString!);

    final bField = colorObj.fields!.firstWhere((field) => field.name == "b");
    final b = double.parse((bField.value as InstanceRef).valueAsString!);

    return Color.from(alpha: a, red: r, green: g, blue: b);
  }
}
