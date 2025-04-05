import 'package:devtools_app_shared/ui.dart';
import 'package:devtools_extensions/devtools_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:material_dev_tools/services/service_manager_service.dart';
import 'package:material_dev_tools/services/theme_service.dart';

void main() {
  runApp(const MaterialDevTools());
}

class MaterialDevTools extends StatefulWidget {
  const MaterialDevTools({super.key});

  @override
  State<MaterialDevTools> createState() => _MaterialDevToolsState();
}

class _MaterialDevToolsState extends State<MaterialDevTools> {
  ThemeData? themeData;

  @override
  void initState() {
    super.initState();

    // For some reason init and WidgetsBinding.instance!.addPostFrameCallback
    // does not work.
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 1), () {
        if (mounted) {
          _fetchTheme();
        }
      });
    });
  }

  Future<ThemeData?> _fetchTheme() async {
    themeData = await ThemeService.fetchTheme();
    setState(() {});
    return themeData;
  }

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();

    return DevToolsExtension(
      child: Column(
        children: [
          DevToolsClearableTextField(
            controller: controller,
            hintText: 'Eval',
            onSubmitted: (text) {
              ServiceManagerService.evalInRunningApp(text);
            },
          ),
          DevToolsButton(
            onPressed: () async => await _fetchTheme(),
            label: 'Toggle App theme',
          ),
          Container(
            height: 48,
            width: 48,
            color: themeData?.colorScheme.primary,
            child: Center(child: Text('primary')),
          ),
        ],
      ),
    );
  }
}
