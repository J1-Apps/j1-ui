import "package:equatable/equatable.dart";
import "package:flutter/material.dart";
import "package:j1_ui/j1_ui.dart";

class TextButtonOverrides extends Equatable {
  final EdgeInsets? padding;
  final double? cornerRadius;
  final double? iconSize;
  final double? elevation;

  final Color? foregroundColor;
  final Color? backgroundColor;
  final Color? outlineColor;
  final double? outlineWidth;

  final TextStyle? textStyle;

  const TextButtonOverrides({
    this.padding,
    this.cornerRadius,
    this.iconSize,
    this.elevation,
    this.foregroundColor,
    this.backgroundColor,
    this.outlineColor,
    this.outlineWidth,
    this.textStyle,
  });

  @override
  List<Object?> get props => [
        padding,
        cornerRadius,
        iconSize,
        elevation,
        foregroundColor,
        backgroundColor,
        outlineColor,
        outlineWidth,
        textStyle,
      ];
}

class TextButton extends StatelessWidget {
  final String? text;
  final bool forceCaps;
  final IconData? icon;
  final Widget? iconWidget;
  final ButtonType type;
  final WidgetSize size;
  final WidgetColor color;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final TextButtonOverrides? overrides;

  const TextButton({
    required this.text,
    this.forceCaps = true,
    this.icon,
    this.iconWidget,
    this.type = ButtonType.filled,
    this.size = WidgetSize.medium,
    this.color = WidgetColor.primary,
    required this.onPressed,
    this.onLongPress,
    this.overrides,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final style = _createStyle(type, color, size, context.colorScheme(), context.textTheme(), overrides);
    final displayIcon = iconWidget ?? (icon == null ? null : Icon(icon));

    return ElevatedButton.icon(
      onPressed: onPressed,
      onLongPress: onLongPress,
      style: style,
      icon: displayIcon,
      label: Text((forceCaps ? text?.toUpperCase() : text) ?? ""),
    );
  }
}

ButtonStyle _createStyle(
  ButtonType type,
  WidgetColor color,
  WidgetSize size,
  ColorScheme colors,
  TextTheme fonts,
  TextButtonOverrides? overrides,
) {
  return switch (type) {
    ButtonType.filled => _createFilledStyle(color, size, colors, fonts, overrides),
    ButtonType.flat => _createFlatStyle(color, size, colors, fonts, overrides),
  };
}

ButtonStyle _createFilledStyle(
  WidgetColor color,
  WidgetSize size,
  ColorScheme colors,
  TextTheme fonts,
  TextButtonOverrides? overrides,
) {
  final buttomParams = _createButtonParams(size, fonts);

  final buttonColors = switch (color) {
    WidgetColor.primary => (colors.onPrimary, colors.primary),
    WidgetColor.secondary => (colors.onSecondary, colors.secondary),
    WidgetColor.tertiary => (colors.onTertiary, colors.tertiary),
    WidgetColor.error => (colors.onError, colors.error),
    WidgetColor.surface => (colors.onSurface, colors.surface),
  };

  final overlayColor = (overrides?.foregroundColor ?? buttonColors.$1).withOpacity(J1Config.buttonOverlayOpacity);

  return ButtonStyle(
    textStyle: (overrides?.textStyle ?? buttomParams.$3)?.widgetState(),
    iconColor: (overrides?.foregroundColor ?? buttonColors.$1).widgetState(),
    foregroundColor: (overrides?.foregroundColor ?? buttonColors.$1).widgetState(),
    backgroundColor: (overrides?.backgroundColor ?? buttonColors.$2).widgetState(),
    overlayColor: overlayColor.widgetState(),
    padding: (overrides?.padding ?? buttomParams.$1).widgetState(),
    iconSize: (overrides?.iconSize ?? buttomParams.$2).widgetState(),
    elevation: (overrides?.elevation ?? Dimens.elevation_s).widgetState(),
    minimumSize: Size.zero.widgetState(),
    shape: _createBorder(overrides).widgetState(),
  );
}

ButtonStyle _createFlatStyle(
  WidgetColor color,
  WidgetSize size,
  ColorScheme colors,
  TextTheme fonts,
  TextButtonOverrides? overrides,
) {
  final buttomParams = _createButtonParams(size, fonts);

  final buttonColors = switch (color) {
    WidgetColor.primary => (colors.primary, Colors.transparent),
    WidgetColor.secondary => (colors.secondary, Colors.transparent),
    WidgetColor.tertiary => (colors.tertiary, Colors.transparent),
    WidgetColor.error => (colors.error, Colors.transparent),
    WidgetColor.surface => (colors.surface, Colors.transparent),
  };

  final overlayColor = (overrides?.foregroundColor ?? buttonColors.$1).withOpacity(J1Config.buttonOverlayOpacity);

  return ButtonStyle(
    textStyle: (overrides?.textStyle ?? buttomParams.$3)?.widgetState(),
    iconColor: (overrides?.foregroundColor ?? buttonColors.$1).widgetState(),
    foregroundColor: (overrides?.foregroundColor ?? buttonColors.$1).widgetState(),
    backgroundColor: (overrides?.backgroundColor ?? buttonColors.$2).widgetState(),
    overlayColor: overlayColor.widgetState(),
    padding: (overrides?.padding ?? buttomParams.$1).widgetState(),
    iconSize: (overrides?.iconSize ?? buttomParams.$2).widgetState(),
    elevation: (overrides?.elevation ?? Dimens.elevation_none).widgetState(),
    minimumSize: Size.zero.widgetState(),
    shape: _createBorder(overrides).widgetState(),
  );
}

RoundedRectangleBorder _createBorder(TextButtonOverrides? overrides) {
  final cornerRadius = overrides?.cornerRadius ?? Dimens.radius_s;
  final outlineColor = overrides?.outlineColor;
  final outlineWidth = overrides?.outlineWidth ?? 2;
  return RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(cornerRadius),
    side: outlineColor != null ? BorderSide(color: outlineColor, width: outlineWidth) : BorderSide.none,
  );
}

(EdgeInsets, double, TextStyle?) _createButtonParams(WidgetSize size, TextTheme fonts) {
  return switch (size) {
    WidgetSize.large => (
        const EdgeInsets.symmetric(horizontal: Dimens.spacing_s + 2, vertical: Dimens.spacing_s),
        28,
        fonts.titleLarge
      ),
    WidgetSize.medium => (
        const EdgeInsets.symmetric(horizontal: Dimens.spacing_s + 2, vertical: Dimens.spacing_s),
        24,
        fonts.titleMedium
      ),
    WidgetSize.small => (
        const EdgeInsets.symmetric(horizontal: Dimens.spacing_s + 2, vertical: Dimens.spacing_s),
        20,
        fonts.titleSmall
      ),
  };
}
