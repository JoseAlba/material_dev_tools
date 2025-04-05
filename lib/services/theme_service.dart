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
    final themeMode = await getThemeMode(materialAppObj);

    final darkThemeObj = await VmService.getObj(materialAppObj, 'darkTheme');
    final darkTheme = await getThemeData(darkThemeObj);

    final themeObj = await VmService.getObj(materialAppObj, 'theme');
    final theme = await getThemeData(themeObj);
    return (themeMode, theme, darkTheme);
  }

  static Future<Obj?> getMaterialAppObj() async {
    final response = await ServiceManagerService.evalInRunningApp(
      _fetchMaterialAppExpression,
    );
    final materialAppObjectId = (response as InstanceRef).id!;
    return await ServiceManagerService.getObject(materialAppObjectId);
  }

  static Future<ThemeMode> getThemeMode(Obj? materialAppObj) async {
    final themeModeObj = await VmService.getObj(materialAppObj, 'themeMode');

    final indexField = (themeModeObj as Instance).fields!.firstWhere(
      (field) => field.name == 'index',
    );
    final index = int.parse((indexField.value as InstanceRef).valueAsString!);

    return EnumExtension.fromInt(
      index,
      ThemeMode.values,
      defaultValue: ThemeMode.system,
    );
  }

  static Future<ThemeData> getThemeData(Obj? themeObj) async {
    final colorSchemeObj = await VmService.getObj(themeObj, 'colorScheme');
    final primaryObj = await VmService.getObj(colorSchemeObj, 'primary');

    Color primaryColor = getColor(primaryObj!);
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
    );
  }

  static Color getColor(Obj colorObj) {
    colorObj = (colorObj as Instance);

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
