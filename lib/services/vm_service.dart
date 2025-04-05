import 'package:flutter/material.dart';
import 'package:material_dev_tools/services/service_manager_service.dart';
import 'package:vm_service/vm_service.dart';

class VmService {
  const VmService._();

  static final _fetchThemeExpression =
      '((){Element? scaffoldElement; void findScaffold(Element element) { if (element.widget is Scaffold) { scaffoldElement = element; return; } element.visitChildren(findScaffold); } WidgetsBinding.instance.rootElement!.visitChildren(findScaffold); return Theme.of(scaffoldElement as BuildContext); })()';

  static Future<Obj?> getThemeObj() async {
    final response = await ServiceManagerService.evalInRunningApp(
      _fetchThemeExpression,
    );
    final themeDataObjectId = (response as InstanceRef).id!;
    return await ServiceManagerService.getObject(themeDataObjectId);
  }

  static Future<Obj?> getObj(Obj? obj, String fieldName) async {
    final field = (obj as Instance).fields!.firstWhere(
      (field) => field.name == fieldName,
    );
    final objectId = (field.value as InstanceRef).id!;
    return await ServiceManagerService.getObject(objectId);
  }

  static Color getColor(Obj colorObj) {
    final aField = (colorObj as Instance).fields!.firstWhere(
      (field) => field.name == "a",
    );
    final a = double.parse((aField.value as InstanceRef).valueAsString!);

    final rField = (colorObj).fields!.firstWhere((field) => field.name == "r");
    final r = double.parse((rField.value as InstanceRef).valueAsString!);

    final gField = (colorObj).fields!.firstWhere((field) => field.name == "g");
    final g = double.parse((gField.value as InstanceRef).valueAsString!);

    final bField = (colorObj).fields!.firstWhere((field) => field.name == "b");
    final b = double.parse((bField.value as InstanceRef).valueAsString!);

    return Color.fromARGB(
      (a * 255).toInt(),
      (r * 255).toInt(),
      (g * 255).toInt(),
      (b * 255).toInt(),
    );
  }
}
