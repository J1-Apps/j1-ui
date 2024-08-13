import "package:equatable/equatable.dart";
import "package:flutter/material.dart";
import "package:j1_ui/j1_ui.dart";

enum IconButtonType {
  filled,
  flat,
}

class IconButton extends StatelessWidget {
  final IconData? icon;
  final Widget? iconWidget;
  final IconButtonType type;
  final IconButtonDimens size;
  final WidgetColor color;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final Color? iconColor;
  final Color? backgroundColor;
  final Color? outlineColor;
  final double? outlineWidth;

  const IconButton({
    required this.icon,
    this.iconWidget,
    this.type = IconButtonType.filled,
    this.size = IconButtonDimens.medium,
    required this.color,
    required this.onPressed,
    this.onLongPress,
    this.iconColor,
    this.backgroundColor,
    this.outlineColor,
    this.outlineWidth,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final style = type._createStyle(
      color,
      context.colorScheme(),
      iconColor,
      backgroundColor,
    );

    final shape = CircleBorder(
      side: outlineColor != null
          ? BorderSide(color: outlineColor ?? context.colorScheme().onSurface, width: outlineWidth ?? 2)
          : BorderSide.none,
    );

    final buttonStyle = style.copyWith(
      padding: EdgeInsets.zero.widgetState(),
      minimumSize: Size.zero.widgetState(),
      iconSize: size.iconSize.widgetState(),
      fixedSize: Size.square(size.size).widgetState(),
      shape: shape.widgetState(),
    );

    return SizedBox(
      width: size.size,
      height: size.size,
      child: ElevatedButton(
        onPressed: onPressed,
        onLongPress: onLongPress,
        style: buttonStyle,
        child: iconWidget ?? Icon(icon),
      ),
    );
  }
}

class IconButtonDimens extends Equatable {
  final double size;
  final double iconSize;

  static const large = IconButtonDimens._(size: 48, iconSize: 28);
  static const medium = IconButtonDimens._(size: 36, iconSize: 22);
  static const small = IconButtonDimens._(size: 36, iconSize: 18);

  const IconButtonDimens._({
    required this.size,
    required this.iconSize,
  });

  IconButtonDimens copyWith({
    double? size,
    double? iconSize,
  }) {
    return IconButtonDimens._(
      size: size ?? this.size,
      iconSize: iconSize ?? this.iconSize,
    );
  }

  @override
  List<Object?> get props => [
        size,
        iconSize,
      ];
}

extension _TypeExtension on IconButtonType {
  ButtonStyle _createStyle(
    WidgetColor color,
    ColorScheme colors,
    Color? iconColor,
    Color? backgroundColor,
  ) {
    return switch (this) {
      IconButtonType.filled => _createFilledStyle(color, colors, iconColor, backgroundColor),
      IconButtonType.flat => _createFlatStyle(color, colors, iconColor, backgroundColor),
    };
  }
}

ButtonStyle _createFilledStyle(
  WidgetColor color,
  ColorScheme colors,
  Color? iconColor,
  Color? backgroundColor,
) {
  final buttonColors = switch (color) {
    WidgetColor.primary => (colors.onPrimary, colors.primary),
    WidgetColor.secondary => (colors.onSecondary, colors.secondary),
    WidgetColor.tertiary => (colors.onTertiary, colors.tertiary),
    WidgetColor.error => (colors.onError, colors.error),
    WidgetColor.surface => (colors.onSurface, colors.surface),
  };

  return ButtonStyle(
    iconColor: (iconColor ?? buttonColors.$1).widgetState(),
    backgroundColor: (backgroundColor ?? buttonColors.$2).widgetState(),
    overlayColor: (iconColor ?? buttonColors.$1).withOpacity(J1Config.buttonOverlayOpacity).widgetState(),
    elevation: Dimens.elevation_s.widgetState(),
  );
}

ButtonStyle _createFlatStyle(
  WidgetColor color,
  ColorScheme colors,
  Color? iconColor,
  Color? backgroundColor,
) {
  final buttonColors = switch (color) {
    WidgetColor.primary => (colors.primary, Colors.transparent),
    WidgetColor.secondary => (colors.secondary, Colors.transparent),
    WidgetColor.tertiary => (colors.tertiary, Colors.transparent),
    WidgetColor.error => (colors.error, Colors.transparent),
    WidgetColor.surface => (colors.surface, Colors.transparent),
  };

  return ButtonStyle(
    iconColor: (iconColor ?? buttonColors.$1).widgetState(),
    backgroundColor: (backgroundColor ?? buttonColors.$2).widgetState(),
    overlayColor: (iconColor ?? buttonColors.$1).withOpacity(J1Config.buttonOverlayOpacity).widgetState(),
    elevation: Dimens.elevation_none.widgetState(),
  );
}
