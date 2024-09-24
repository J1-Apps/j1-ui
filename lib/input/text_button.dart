import "package:equatable/equatable.dart";
import "package:flutter/material.dart";
import "package:j1_ui/j1_ui.dart";

class JTextButtonOverrides extends Equatable {
  final EdgeInsets? padding;
  final double? cornerRadius;
  final double? iconSize;
  final double? elevation;

  final Color? foregroundColor;
  final Color? backgroundColor;
  final Color? outlineColor;
  final double? outlineWidth;

  final TextStyle? textStyle;

  const JTextButtonOverrides({
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

class JTextButton extends StatelessWidget {
  final String? text;
  final bool forceCaps;
  final IconData? icon;
  final Widget? iconWidget;
  final JButtonType type;
  final JWidgetSize size;
  final JWidgetColor color;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final JTextButtonOverrides? overrides;

  const JTextButton({
    required this.text,
    this.forceCaps = true,
    this.icon,
    this.iconWidget,
    this.type = JButtonType.filled,
    this.size = JWidgetSize.medium,
    this.color = JWidgetColor.primary,
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

extension _CreateStyle on JTextButton {
  ButtonStyle _createStyle(
    ColorScheme colors,
    TextTheme fonts,
  ) {
    return switch (type) {
      JButtonType.filled => _createFilledStyle(colors, fonts),
      JButtonType.flat => _createFlatStyle(colors, fonts),
    };
  }

  ButtonStyle _createFilledStyle(
    ColorScheme colors,
    TextTheme fonts,
  ) {
    final (padding, iconSize, textStyle) = _createButtonParams(fonts);

    final (foregroundColor, backgroundColor) = switch (color) {
      JWidgetColor.primary => (colors.onPrimary, colors.primary),
      JWidgetColor.secondary => (colors.onSecondary, colors.secondary),
      JWidgetColor.tertiary => (colors.onTertiary, colors.tertiary),
      JWidgetColor.error => (colors.onError, colors.error),
      JWidgetColor.surface => (colors.onSurface, colors.surface),
      JWidgetColor.onSurface => (colors.surface, colors.onSurface),
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
      elevation: (overrides?.elevation ?? JDimens.elevation_s).widgetState(),
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
      JWidgetColor.primary => (colors.primary, Colors.transparent),
      JWidgetColor.secondary => (colors.secondary, Colors.transparent),
      JWidgetColor.tertiary => (colors.tertiary, Colors.transparent),
      JWidgetColor.error => (colors.error, Colors.transparent),
      JWidgetColor.surface => (colors.surface, Colors.transparent),
      JWidgetColor.onSurface => (colors.onSurface, Colors.transparent),
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
      elevation: (overrides?.elevation ?? JDimens.elevation_none).widgetState(),
      minimumSize: Size.zero.widgetState(),
      shape: _createBorder().widgetState(),
    );
  }

  RoundedRectangleBorder _createBorder() {
    final cornerRadius = overrides?.cornerRadius ?? JDimens.radius_s;
    final outlineColor = overrides?.outlineColor;
    final outlineWidth = overrides?.outlineWidth ?? 2;
    return RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(cornerRadius),
      side: outlineColor != null ? BorderSide(color: outlineColor, width: outlineWidth) : BorderSide.none,
    );
  }

  (EdgeInsets, double, TextStyle?) _createButtonParams(TextTheme fonts) {
    return switch (size) {
      JWidgetSize.large => (
          const EdgeInsets.symmetric(horizontal: JDimens.spacing_s + 2, vertical: JDimens.spacing_s),
          28,
          fonts.titleLarge,
        ),
      JWidgetSize.medium => (
          const EdgeInsets.symmetric(horizontal: JDimens.spacing_s + 2, vertical: JDimens.spacing_s),
          24,
          fonts.titleMedium,
        ),
      JWidgetSize.small => (
          const EdgeInsets.symmetric(horizontal: JDimens.spacing_s + 2, vertical: JDimens.spacing_s),
          20,
          fonts.titleSmall,
        ),
    };
  }
}
