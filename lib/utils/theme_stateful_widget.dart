import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:material_dev_tools/services/theme_service.dart';

ThemeData _defaultTheme = ThemeData.dark();

class _ThemeMemoryDatasource {
  const _ThemeMemoryDatasource._();

  static ThemeData _theme = _defaultTheme;

  static void saveTheme(ThemeData theme) {
    _theme = theme;
  }

  static ThemeData getTheme() {
    return _theme;
  }
}

abstract class ThemeStatefulWidget extends StatefulWidget {
  const ThemeStatefulWidget({super.key});

  @override
  ThemeState createState();

  @override
  ThemeStatefulElement createElement() => ThemeStatefulElement(this);
}

abstract class ThemeState<T extends ThemeStatefulWidget> extends State<T> {
  late ThemeData theme = ThemeData.light();

  @override
  @protected
  @mustCallSuper
  void initState() {
    super.initState();
    theme = _ThemeMemoryDatasource.getTheme();

    SchedulerBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 1), _fetchTheme);
    });
  }

  Future<void> _fetchTheme() async {
    try {
      theme = await ThemeService.fetchTheme();
    } catch (e) {
      theme = _ThemeMemoryDatasource.getTheme();
    } finally {
      _ThemeMemoryDatasource.saveTheme(theme);
      if (mounted) {
        setState(() {});
      }
    }
  }
}

class ThemeStatefulElement extends StatefulElement {
  ThemeStatefulElement(super.widget);
}
