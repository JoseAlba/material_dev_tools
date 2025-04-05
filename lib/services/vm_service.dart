import 'dart:convert';

import 'package:devtools_extensions/devtools_extensions.dart';
import 'package:material_dev_tools/services/service_manager_service.dart';
import 'package:vm_service/vm_service.dart';

class VmService {
  const VmService._();

  static Future<Obj?> getObj(Obj? obj, String fieldName) async {
    final field = (obj as Instance).fields!.firstWhere(
      (field) => field.name == fieldName,
    );
    final objectId = (field.value as InstanceRef).id!;
    return await ServiceManagerService.getObject(objectId);
  }

  static void copyObjectToClipboard(Obj? obj) {
    final String json = jsonEncode(obj);
    extensionManager.copyToClipboard(
      json,
      successMessage: 'Copied $json to clipboard',
    );
  }

  static void copyBoundFieldToClipboard(BoundField? field) {
    final String json = jsonEncode(field);
    extensionManager.copyToClipboard(
      json,
      successMessage: 'Copied $json to clipboard',
    );
  }
}
