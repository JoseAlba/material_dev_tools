import 'package:flutter/material.dart';
import 'package:material_dev_tools/utils/theme_stateful_widget.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default', type: ColorScheme)
Widget colorSchemeDemo(BuildContext context) {
  return ColorSchemeDemo();
}

class ColorSchemeDemo extends ThemeWidget {
  const ColorSchemeDemo({super.key});

  @override
  Widget build(BuildContext context, ThemeData theme) {
    return Container(
      color: Colors.white,
      child: const Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _PrimaryContainer()),
              Expanded(child: _SecondaryContainer()),
              Expanded(child: _TertiaryContainer()),
              Expanded(child: _ErrorContainer()),
            ],
          ),
          SizedBox(height: 48),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 3, child: _SurfaceContainer()),
              Expanded(flex: 1, child: _MiscellaneousContainer()),
            ],
          ),
        ],
      ),
    );
  }
}

const Color _temporaryColor = Colors.pink;

class ColorBox extends ThemeWidget {
  const ColorBox({super.key, this.color = _temporaryColor, required this.text});

  /// The color to paint behind the [text].
  final Color color;

  /// The text to display.
  final String text;

  @override
  Widget build(BuildContext context, ThemeData theme) {
    final textTheme = theme.textTheme;

    final whiteText = textTheme.bodyMedium!.copyWith(color: Colors.white);
    final blackText = textTheme.bodyMedium!.copyWith(color: Colors.black);
    return Container(
      height: 48,
      width: double.infinity,
      color: color,
      child: Center(
        child: DefaultTextStyle(
          style: color.computeLuminance() > 0.5 ? blackText : whiteText,
          child: Text(text),
        ),
      ),
    );
  }
}

class _PrimaryContainer extends ThemeWidget {
  const _PrimaryContainer();

  @override
  Widget build(BuildContext context, ThemeData theme) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Column(
      children: [
        ColorBox(color: colorScheme.primary, text: 'Primary'),
        ColorBox(color: colorScheme.onPrimary, text: 'OnPrimary'),
        ColorBox(color: colorScheme.primaryContainer, text: 'PrimaryContainer'),
        ColorBox(
          color: colorScheme.onPrimaryContainer,
          text: 'OnPrimaryContainer',
        ),
        ColorBox(color: colorScheme.primaryFixed, text: 'PrimaryFixed'),
        ColorBox(color: colorScheme.primaryFixedDim, text: 'PrimaryFixedDim'),
        ColorBox(color: colorScheme.onPrimaryFixed, text: 'OnPrimaryFixed'),
        ColorBox(
          color: colorScheme.onPrimaryFixedVariant,
          text: 'OnPrimaryFixedVariant',
        ),
      ],
    );
  }
}

class _SecondaryContainer extends ThemeWidget {
  const _SecondaryContainer();

  @override
  Widget build(BuildContext context, ThemeData theme) {
    ColorScheme colorScheme = theme.colorScheme;
    return Column(
      children: [
        ColorBox(color: colorScheme.secondary, text: 'Secondary'),
        ColorBox(color: colorScheme.onSecondary, text: 'OnSecondary'),
        ColorBox(
          color: colorScheme.secondaryContainer,
          text: 'SecondaryContainer',
        ),
        ColorBox(
          color: colorScheme.onSecondaryContainer,
          text: 'OnSecondaryContainer',
        ),
        ColorBox(color: colorScheme.secondaryFixed, text: 'SecondaryFixed'),
        ColorBox(
          color: colorScheme.secondaryFixedDim,
          text: 'SecondaryFixedDim',
        ),
        ColorBox(color: colorScheme.onSecondaryFixed, text: 'OnSecondaryFixed'),
        ColorBox(
          color: colorScheme.onSecondaryFixedVariant,
          text: 'OnSecondaryFixedVariant',
        ),
      ],
    );
  }
}

class _TertiaryContainer extends ThemeWidget {
  const _TertiaryContainer();

  @override
  Widget build(BuildContext context, ThemeData theme) {
    ColorScheme colorScheme = theme.colorScheme;
    return Column(
      children: [
        ColorBox(color: colorScheme.tertiary, text: 'Tertiary'),
        ColorBox(color: colorScheme.onTertiary, text: 'OnTertiary'),
        ColorBox(
          color: colorScheme.tertiaryContainer,
          text: 'TertiaryContainer',
        ),
        ColorBox(
          color: colorScheme.onTertiaryContainer,
          text: 'OnTertiaryContainer',
        ),
        ColorBox(color: colorScheme.tertiaryFixed, text: 'TertiaryFixed'),
        ColorBox(color: colorScheme.tertiaryFixedDim, text: 'TertiaryFixedDim'),
        ColorBox(color: colorScheme.onTertiaryFixed, text: 'OnTertiaryFixed'),
        ColorBox(
          color: colorScheme.onTertiaryFixedVariant,
          text: 'OnTertiaryFixedVariant',
        ),
      ],
    );
  }
}

class _ErrorContainer extends ThemeWidget {
  const _ErrorContainer();

  @override
  Widget build(BuildContext context, ThemeData theme) {
    ColorScheme colorScheme = theme.colorScheme;
    return Column(
      children: [
        ColorBox(color: colorScheme.error, text: 'Error'),
        ColorBox(color: colorScheme.onError, text: 'OnError'),
        ColorBox(color: colorScheme.errorContainer, text: 'ErrorContainer'),
        ColorBox(color: colorScheme.onErrorContainer, text: 'onErrorContainer'),
      ],
    );
  }
}

class _SurfaceContainer extends ThemeWidget {
  const _SurfaceContainer();

  @override
  Widget build(BuildContext context, ThemeData theme) {
    ColorScheme colorScheme = theme.colorScheme;
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: ColorBox(
                color: colorScheme.surfaceDim,
                text: 'SurfaceDim',
              ),
            ),
            Expanded(
              child: ColorBox(color: colorScheme.surface, text: 'Surface'),
            ),
            Expanded(
              child: ColorBox(
                color: colorScheme.surfaceBright,
                text: 'SurfaceBright',
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: ColorBox(
                color: colorScheme.surfaceContainerLowest,
                text: 'SurfaceContainerLowest',
              ),
            ),
            Expanded(
              child: ColorBox(
                color: colorScheme.surfaceContainerLow,
                text: 'SurfaceContainerLow',
              ),
            ),
            Expanded(
              child: ColorBox(
                color: colorScheme.surfaceContainer,
                text: 'SurfaceContainer',
              ),
            ),
            Expanded(
              child: ColorBox(
                color: colorScheme.surfaceContainerHigh,
                text: 'SurfaceContainerHigh',
              ),
            ),
            Expanded(
              child: ColorBox(
                color: colorScheme.surfaceContainerHighest,
                text: 'SurfaceContainerHighest',
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: ColorBox(color: colorScheme.onSurface, text: 'OnSurface'),
            ),
            Expanded(
              child: ColorBox(
                color: colorScheme.onSurfaceVariant,
                text: 'OnSurfaceVariant',
              ),
            ),
            Expanded(
              child: ColorBox(color: colorScheme.outline, text: 'Outline'),
            ),
            Expanded(
              child: ColorBox(
                color: colorScheme.outlineVariant,
                text: 'OutlineVariant',
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _MiscellaneousContainer extends ThemeWidget {
  const _MiscellaneousContainer();

  @override
  Widget build(BuildContext context, ThemeData theme) {
    ColorScheme colorScheme = theme.colorScheme;
    return Column(
      children: [
        ColorBox(color: colorScheme.inverseSurface, text: 'InverseSurface'),
        ColorBox(color: colorScheme.onInverseSurface, text: 'OnInverseSurface'),
        ColorBox(color: colorScheme.inversePrimary, text: 'InversePrimary'),
        ColorBox(color: colorScheme.scrim, text: 'Scrim'),
        ColorBox(color: colorScheme.shadow, text: 'Shadow'),
      ],
    );
  }
}
