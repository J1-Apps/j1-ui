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
    final style = _createStyle(context.colorScheme(), context.textTheme());
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

extension _CreateStyle on TextButton {
  ButtonStyle _createStyle(
    ColorScheme colors,
    TextTheme fonts,
  ) {
    return switch (type) {
      ButtonType.filled => _createFilledStyle(colors, fonts),
      ButtonType.flat => _createFlatStyle(colors, fonts),
    };
  }

  ButtonStyle _createFilledStyle(
    ColorScheme colors,
    TextTheme fonts,
  ) {
    final (padding, iconSize, textStyle) = _createButtonParams(fonts);

    final (foregroundColor, backgroundColor) = switch (color) {
      WidgetColor.primary => (colors.onPrimary, colors.primary),
      WidgetColor.secondary => (colors.onSecondary, colors.secondary),
      WidgetColor.tertiary => (colors.onTertiary, colors.tertiary),
      WidgetColor.error => (colors.onError, colors.error),
      WidgetColor.surface => (colors.onSurface, colors.surface),
      WidgetColor.onSurface => (colors.surface, colors.onSurface),
    };

    final overlayColor = (overrides?.foregroundColor ?? foregroundColor).withOpacity(J1Config.buttonOverlayOpacity);

    return ButtonStyle(
      textStyle: (overrides?.textStyle ?? textStyle)?.widgetState(),
      iconColor: (overrides?.foregroundColor ?? foregroundColor).widgetState(),
      foregroundColor: (overrides?.foregroundColor ?? foregroundColor).widgetState(),
      backgroundColor: (overrides?.backgroundColor ?? backgroundColor).widgetState(),
      overlayColor: overlayColor.widgetState(),
      padding: (overrides?.padding ?? padding).widgetState(),
      iconSize: (overrides?.iconSize ?? iconSize).widgetState(),
      elevation: (overrides?.elevation ?? Dimens.elevation_s).widgetState(),
      minimumSize: Size.zero.widgetState(),
      shape: _createBorder().widgetState(),
    );
  }

  ButtonStyle _createFlatStyle(
    ColorScheme colors,
    TextTheme fonts,
  ) {
    final (padding, iconSize, textStyle) = _createButtonParams(fonts);

    final (foregroundColor, backgroundColor) = switch (color) {
      WidgetColor.primary => (colors.primary, Colors.transparent),
      WidgetColor.secondary => (colors.secondary, Colors.transparent),
      WidgetColor.tertiary => (colors.tertiary, Colors.transparent),
      WidgetColor.error => (colors.error, Colors.transparent),
      WidgetColor.surface => (colors.surface, Colors.transparent),
      WidgetColor.onSurface => (colors.onSurface, Colors.transparent),
    };

    final overlayColor = (overrides?.foregroundColor ?? foregroundColor).withOpacity(J1Config.buttonOverlayOpacity);

    return ButtonStyle(
      textStyle: (overrides?.textStyle ?? textStyle)?.widgetState(),
      iconColor: (overrides?.foregroundColor ?? foregroundColor).widgetState(),
      foregroundColor: (overrides?.foregroundColor ?? foregroundColor).widgetState(),
      backgroundColor: (overrides?.backgroundColor ?? backgroundColor).widgetState(),
      overlayColor: overlayColor.widgetState(),
      padding: (overrides?.padding ?? padding).widgetState(),
      iconSize: (overrides?.iconSize ?? iconSize).widgetState(),
      elevation: (overrides?.elevation ?? Dimens.elevation_none).widgetState(),
      minimumSize: Size.zero.widgetState(),
      shape: _createBorder().widgetState(),
    );
  }

  RoundedRectangleBorder _createBorder() {
    final cornerRadius = overrides?.cornerRadius ?? Dimens.radius_s;
    final outlineColor = overrides?.outlineColor;
    final outlineWidth = overrides?.outlineWidth ?? 2;
    return RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(cornerRadius),
      side: outlineColor != null ? BorderSide(color: outlineColor, width: outlineWidth) : BorderSide.none,
    );
  }

  (EdgeInsets, double, TextStyle?) _createButtonParams(TextTheme fonts) {
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
}
