import "package:equatable/equatable.dart";
import "package:flutter/material.dart";
import "package:j1_ui/j1_ui.dart";

class IconButtonOverrides extends Equatable {
  final double? buttonSize;
  final double? iconSize;
  final double? elevation;

  final Color? iconColor;
  final Color? backgroundColor;
  final Color? outlineColor;
  final double? outlineWidth;

  const IconButtonOverrides({
    this.buttonSize,
    this.iconSize,
    this.elevation,
    this.iconColor,
    this.backgroundColor,
    this.outlineColor,
    this.outlineWidth,
  });

  @override
  List<Object?> get props => [
        buttonSize,
        iconSize,
        elevation,
        iconColor,
        backgroundColor,
        outlineColor,
        outlineWidth,
      ];
}

class IconButton extends StatelessWidget {
  final IconData? icon;
  final Widget? iconWidget;
  final ButtonType type;
  final WidgetSize size;
  final WidgetColor color;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final IconButtonOverrides? overrides;

  const IconButton({
    required this.icon,
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
    final style = _createStyle(type, color, size, context.colorScheme(), overrides);

    return ElevatedButton(
      onPressed: onPressed,
      onLongPress: onLongPress,
      style: style,
      child: iconWidget ?? Icon(icon),
    );
  }
}

ButtonStyle _createStyle(
  ButtonType type,
  WidgetColor color,
  WidgetSize size,
  ColorScheme colors,
  IconButtonOverrides? overrides,
) {
  return switch (type) {
    ButtonType.filled => _createFilledStyle(color, size, colors, overrides),
    ButtonType.flat => _createFlatStyle(color, size, colors, overrides),
  };
}

ButtonStyle _createFilledStyle(
  WidgetColor color,
  WidgetSize size,
  ColorScheme colors,
  IconButtonOverrides? overrides,
) {
  final buttonSize = _createButtonSize(size);

  final buttonColors = switch (color) {
    WidgetColor.primary => (colors.onPrimary, colors.primary),
    WidgetColor.secondary => (colors.onSecondary, colors.secondary),
    WidgetColor.tertiary => (colors.onTertiary, colors.tertiary),
    WidgetColor.error => (colors.onError, colors.error),
    WidgetColor.surface => (colors.onSurface, colors.surface),
  };

  return ButtonStyle(
    iconColor: (overrides?.iconColor ?? buttonColors.$1).widgetState(),
    backgroundColor: (overrides?.backgroundColor ?? buttonColors.$2).widgetState(),
    overlayColor: (overrides?.iconColor ?? buttonColors.$1).withOpacity(J1Config.buttonOverlayOpacity).widgetState(),
    elevation: (overrides?.elevation ?? Dimens.elevation_s).widgetState(),
    padding: EdgeInsets.zero.widgetState(),
    minimumSize: Size.zero.widgetState(),
    fixedSize: Size.square(overrides?.buttonSize ?? buttonSize.$1).widgetState(),
    iconSize: (overrides?.iconSize ?? buttonSize.$2).widgetState(),
    shape: _createBorder(overrides).widgetState(),
  );
}

ButtonStyle _createFlatStyle(
  WidgetColor color,
  WidgetSize size,
  ColorScheme colors,
  IconButtonOverrides? overrides,
) {
  final buttonSize = _createButtonSize(size);

  final buttonColors = switch (color) {
    WidgetColor.primary => (colors.primary, Colors.transparent),
    WidgetColor.secondary => (colors.secondary, Colors.transparent),
    WidgetColor.tertiary => (colors.tertiary, Colors.transparent),
    WidgetColor.error => (colors.error, Colors.transparent),
    WidgetColor.surface => (colors.surface, Colors.transparent),
  };

  return ButtonStyle(
    iconColor: (overrides?.iconColor ?? buttonColors.$1).widgetState(),
    backgroundColor: (overrides?.backgroundColor ?? buttonColors.$2).widgetState(),
    overlayColor: (overrides?.iconColor ?? buttonColors.$1).withOpacity(J1Config.buttonOverlayOpacity).widgetState(),
    elevation: (overrides?.elevation ?? Dimens.elevation_none).widgetState(),
    padding: EdgeInsets.zero.widgetState(),
    minimumSize: Size.zero.widgetState(),
    fixedSize: Size.square(overrides?.buttonSize ?? buttonSize.$1).widgetState(),
    iconSize: (overrides?.iconSize ?? buttonSize.$2).widgetState(),
    shape: _createBorder(overrides).widgetState(),
  );
}

CircleBorder _createBorder(IconButtonOverrides? overrides) {
  final outlineColor = overrides?.outlineColor;
  final outlineWidth = overrides?.outlineWidth ?? 2;
  return CircleBorder(
    side: outlineColor != null ? BorderSide(color: outlineColor, width: outlineWidth) : BorderSide.none,
  );
}

(double, double) _createButtonSize(WidgetSize size) {
  return switch (size) {
    WidgetSize.large => (48, 28),
    WidgetSize.medium => (36, 22),
    WidgetSize.small => (32, 18),
  };
}
