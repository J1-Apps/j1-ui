import "package:equatable/equatable.dart";
import "package:flutter/material.dart" hide Card;
import "package:j1_ui/j1_ui.dart";

class ThemeCardOverrides extends Equatable {
  final EdgeInsets? padding;
  final double? cornerRadius;
  final double? elevation;
  final double? cardSpacing;
  final double? colorSpacing;
  final double? fontSpacing;
  final double? outlineWidth;
  final double? selectedOutlineWidth;
  final double? colorOutlineWidth;
  final double? colorSize;
  final double? colorIconSize;
  final IconData? colorIcon;

  const ThemeCardOverrides({
    this.padding,
    this.cornerRadius,
    this.elevation,
    this.cardSpacing,
    this.colorSpacing,
    this.fontSpacing,
    this.outlineWidth,
    this.selectedOutlineWidth,
    this.colorOutlineWidth,
    this.colorSize,
    this.colorIconSize,
    this.colorIcon,
  });

  @override
  List<Object?> get props => [
        padding,
        cornerRadius,
        elevation,
        cardSpacing,
        colorSpacing,
        fontSpacing,
        outlineWidth,
        selectedOutlineWidth,
        colorOutlineWidth,
        colorSize,
        colorIconSize,
        colorIcon,
      ];
}

class ThemeCard extends StatelessWidget {
  final String themeName;
  final ColorScheme colors;
  final TextTheme fonts;
  final bool isSelected;
  final VoidCallback? onPressed;
  final ThemeCardOverrides? overrides;

  const ThemeCard({
    required this.themeName,
    required this.colors,
    required this.fonts,
    this.isSelected = false,
    this.onPressed,
    this.overrides,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final selectedWidth = overrides?.selectedOutlineWidth ?? J1Config.selectedStrokeWidth;

    return Theme(
      data: context.theme().copyWith(colorScheme: colors, textTheme: fonts),
      child: Card(
        onPressed: onPressed,
        overrides: CardOverrides(
          cornerRadius: overrides?.cornerRadius,
          strokeWidth: isSelected ? selectedWidth : overrides?.outlineWidth,
          elevation: overrides?.elevation,
        ),
        child: Padding(
          padding: overrides?.padding ?? const EdgeInsets.all(Dimens.spacing_s),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _ColorGrid(
                colorSpacing: overrides?.colorSpacing,
                icon: overrides?.colorIcon,
                circleSize: overrides?.colorSize,
                iconSize: overrides?.colorIconSize,
                outlineWidth: overrides?.colorOutlineWidth,
              ),
              SizedBox(width: overrides?.cardSpacing ?? Dimens.spacing_xs),
              FontColumn(
                text: themeName,
                styles: [
                  fonts.headlineMedium,
                  fonts.titleMedium,
                  fonts.bodyMedium,
                ],
                spacing: Dimens.spacing_xxxs,
                color: colors.onSurface,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ColorGrid extends StatelessWidget {
  final double? colorSpacing;
  final IconData? icon;
  final double? circleSize;
  final double? iconSize;
  final double? outlineWidth;

  const _ColorGrid({
    required this.colorSpacing,
    required this.icon,
    required this.circleSize,
    required this.iconSize,
    required this.outlineWidth,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme();

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _ColorColumn(
          colorSpacing: colorSpacing,
          icon: icon,
          circleSize: circleSize,
          iconSize: iconSize,
          outlineWidth: outlineWidth,
          colors: [(colors.onPrimary, colors.primary), (colors.onSecondary, colors.secondary)],
        ),
        SizedBox(width: colorSpacing ?? Dimens.spacing_xxs),
        _ColorColumn(
          colorSpacing: colorSpacing,
          icon: icon,
          circleSize: circleSize,
          iconSize: iconSize,
          outlineWidth: outlineWidth,
          colors: [(colors.onTertiary, colors.tertiary), (colors.onError, colors.error)],
        ),
      ],
    );
  }
}

class _ColorColumn extends StatelessWidget {
  final double? colorSpacing;
  final IconData? icon;
  final double? circleSize;
  final double? iconSize;
  final double? outlineWidth;

  final List<(Color, Color)> colors;

  const _ColorColumn({
    required this.colorSpacing,
    required this.icon,
    required this.circleSize,
    required this.iconSize,
    required this.outlineWidth,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[];
    for (var i = 0; i < colors.length; i++) {
      final (foreground, background) = colors[i];

      children.add(
        _ColorCircle(
          foregroundColor: foreground,
          backgroundColor: background,
          icon: icon,
          size: circleSize,
          iconSize: iconSize,
          outlineWidth: outlineWidth,
        ),
      );

      if (i + 1 < colors.length) {
        children.add(SizedBox(height: colorSpacing ?? Dimens.spacing_xxs));
      }
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: children,
    );
  }
}

class _ColorCircle extends StatelessWidget {
  final Color foregroundColor;
  final Color backgroundColor;
  final IconData? icon;
  final double? size;
  final double? iconSize;
  final double? outlineWidth;

  const _ColorCircle({
    required this.foregroundColor,
    required this.backgroundColor,
    required this.icon,
    required this.size,
    required this.iconSize,
    required this.outlineWidth,
  });

  @override
  Widget build(BuildContext context) {
    final diameter = size ?? 32.0;

    return Container(
      height: diameter,
      width: diameter,
      decoration: BoxDecoration(
        border: Border.all(color: context.colorScheme().onSurface, width: outlineWidth ?? 1.0),
        borderRadius: BorderRadius.circular(diameter / 2),
        color: backgroundColor,
      ),
      child: Center(
        child: Icon(
          icon ?? JamIcons.language,
          color: foregroundColor,
          size: iconSize ?? 18.0,
        ),
      ),
    );
  }
}
