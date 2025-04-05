import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:material_dev_tools/services/theme_service.dart';

const _defaultThemeMode = ThemeMode.dark;
final _defaultTheme = ThemeData.dark();
final _defaultDarkTheme = ThemeData.dark();

abstract class ThemeStatefulWidget extends StatefulWidget {
  const ThemeStatefulWidget({super.key});

  @override
  ThemeState createState();

  @override
  ThemeStatefulElement createElement() => ThemeStatefulElement(this);
}

abstract class ThemeState<T extends ThemeStatefulWidget> extends State<T> {
  ThemeMode themeMode = _defaultThemeMode;
  ThemeData theme = _defaultTheme;
  ThemeData darkTheme = _defaultDarkTheme;
  ThemeData currentTheme = _defaultDarkTheme;

  @override
  @protected
  @mustCallSuper
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 1), _getTheme);
    });
  }

  Future<void> _getTheme() async {
    try {
      final themeRecord = await MaterialAppService.getMaterialAppData();
      themeMode = themeRecord.$1;
      theme = themeRecord.$2;
      darkTheme = themeRecord.$3;
      currentTheme = ThemeMode.dark == ThemeMode.dark ? darkTheme : theme;
    } finally {
      if (mounted) {
        setState(() {});
      }
    }
  }
}

class ThemeStatefulElement extends StatefulElement {
  ThemeStatefulElement(super.widget);
}
