import "package:equatable/equatable.dart";
import "package:flutter/material.dart";
import "package:j1_ui/j1_ui.dart";

class JIconButtonOverrides extends Equatable {
  final double? buttonSize;
  final double? iconSize;
  final double? elevation;

  final Color? iconColor;
  final Color? backgroundColor;
  final Color? outlineColor;
  final double? outlineWidth;

  const JIconButtonOverrides({
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

class JIconButton extends StatelessWidget {
  final IconData? icon;
  final Widget? iconWidget;
  final JButtonType type;
  final JWidgetSize size;
  final JWidgetColor color;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final JIconButtonOverrides? overrides;

  const JIconButton({
    required this.icon,
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
    final style = _createStyle(context.colorScheme());

    return ElevatedButton(
      onPressed: onPressed,
      onLongPress: onLongPress,
      style: style,
      child: iconWidget ?? Icon(icon),
    );
  }
}

extension _CreateStyle on JIconButton {
  ButtonStyle _createStyle(ColorScheme colors) {
    return switch (type) {
      JButtonType.filled => _createFilledStyle(colors),
      JButtonType.flat => _createFlatStyle(colors),
    };
  }

  ButtonStyle _createFilledStyle(ColorScheme colors) {
    final (buttonSize, iconSize) = _createButtonSize();

    final (iconColor, backgroundColor) = switch (color) {
      JWidgetColor.primary => (colors.onPrimary, colors.primary),
      JWidgetColor.secondary => (colors.onSecondary, colors.secondary),
      JWidgetColor.tertiary => (colors.onTertiary, colors.tertiary),
      JWidgetColor.error => (colors.onError, colors.error),
      JWidgetColor.surface => (colors.onSurface, colors.surface),
      JWidgetColor.onSurface => (colors.surface, colors.onSurface),
    };

    return ButtonStyle(
      iconColor: (overrides?.iconColor ?? iconColor).widgetState(),
      backgroundColor: (overrides?.backgroundColor ?? backgroundColor).widgetState(),
      overlayColor: (overrides?.iconColor ?? iconColor).withOpacity(J1Config.buttonOverlayOpacity).widgetState(),
      elevation: (overrides?.elevation ?? JDimens.elevation_s).widgetState(),
      padding: EdgeInsets.zero.widgetState(),
      minimumSize: Size.zero.widgetState(),
      fixedSize: Size.square(overrides?.buttonSize ?? buttonSize).widgetState(),
      iconSize: (overrides?.iconSize ?? iconSize).widgetState(),
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      shape: _createBorder().widgetState(),
    );
  }

  ButtonStyle _createFlatStyle(ColorScheme colors) {
    final (buttonSize, iconSize) = _createButtonSize();

    final (iconColor, backgroundColor) = switch (color) {
      JWidgetColor.primary => (colors.primary, Colors.transparent),
      JWidgetColor.secondary => (colors.secondary, Colors.transparent),
      JWidgetColor.tertiary => (colors.tertiary, Colors.transparent),
      JWidgetColor.error => (colors.error, Colors.transparent),
      JWidgetColor.surface => (colors.surface, Colors.transparent),
      JWidgetColor.onSurface => (colors.onSurface, Colors.transparent),
    };

    return ButtonStyle(
      iconColor: (overrides?.iconColor ?? iconColor).widgetState(),
      backgroundColor: (overrides?.backgroundColor ?? backgroundColor).widgetState(),
      overlayColor: (overrides?.iconColor ?? iconColor).withOpacity(J1Config.buttonOverlayOpacity).widgetState(),
      elevation: (overrides?.elevation ?? JDimens.elevation_none).widgetState(),
      padding: EdgeInsets.zero.widgetState(),
      minimumSize: Size.zero.widgetState(),
      fixedSize: Size.square(overrides?.buttonSize ?? buttonSize).widgetState(),
      iconSize: (overrides?.iconSize ?? iconSize).widgetState(),
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      shape: _createBorder().widgetState(),
    );
  }

  CircleBorder _createBorder() {
    final outlineColor = overrides?.outlineColor;
    final outlineWidth = overrides?.outlineWidth ?? 2;

    return CircleBorder(
      side: outlineColor != null ? BorderSide(color: outlineColor, width: outlineWidth) : BorderSide.none,
    );
  }

  (double, double) _createButtonSize() {
    return switch (size) {
      JWidgetSize.large => (48, 28),
      JWidgetSize.medium => (36, 22),
      JWidgetSize.small => (32, 18),
    };
  }
}
