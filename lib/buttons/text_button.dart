import "package:equatable/equatable.dart";
import "package:flutter/material.dart";
import "package:j1_ui/j1_ui.dart";

enum TextButtonType {
  filled,
  flat,
}

class TextButton extends StatelessWidget {
  final String? text;
  final TextStyle? textStyle;
  final bool forceCaps;
  final IconData? icon;
  final Widget? iconWidget;
  final TextButtonType type;
  final TextButtonDimens size;
  final WidgetColor color;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final Color? foregroundColor;
  final Color? backgroundColor;
  final Color? outlineColor;
  final double? outlineWidth;

  const TextButton({
    required this.text,
    this.textStyle,
    this.forceCaps = true,
    this.icon,
    this.iconWidget,
    this.type = TextButtonType.filled,
    this.size = TextButtonDimens.medium,
    required this.color,
    required this.onPressed,
    this.onLongPress,
    this.foregroundColor,
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
      foregroundColor,
      backgroundColor,
    );

    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(size.cornerRadius),
      side: outlineColor != null
          ? BorderSide(color: outlineColor ?? context.colorScheme().onSurface, width: outlineWidth ?? 2)
          : BorderSide.none,
    );

    final buttonStyle = style.copyWith(
      padding: size.padding.widgetState(),
      minimumSize: Size.zero.widgetState(),
      iconSize: size.iconSize.widgetState(),
      shape: shape.widgetState(),
    );

    final displayIcon = iconWidget ?? (icon == null ? null : Icon(icon));

    return ElevatedButton.icon(
      onPressed: onPressed,
      onLongPress: onLongPress,
      style: buttonStyle,
      icon: displayIcon,
      label: Text((forceCaps ? text?.toUpperCase() : text) ?? ""),
    );
  }
}

class TextButtonDimens extends Equatable {
  final EdgeInsets padding;
  final double cornerRadius;
  final double iconSpacing;
  final double iconSize;

  static const large = TextButtonDimens._(
    padding: EdgeInsets.symmetric(horizontal: Dimens.spacing_s + 2, vertical: Dimens.spacing_s),
    cornerRadius: Dimens.radius_s,
    iconSpacing: Dimens.spacing_xs,
    iconSize: 28,
  );

  static const medium = TextButtonDimens._(
    padding: EdgeInsets.symmetric(horizontal: Dimens.spacing_s, vertical: Dimens.spacing_s - 2),
    cornerRadius: Dimens.radius_s,
    iconSpacing: Dimens.spacing_xs,
    iconSize: 24,
  );

  static const small = TextButtonDimens._(
    padding: EdgeInsets.symmetric(horizontal: Dimens.spacing_xs + 2, vertical: Dimens.spacing_xs),
    cornerRadius: Dimens.radius_s,
    iconSpacing: Dimens.spacing_xs,
    iconSize: 20,
  );

  const TextButtonDimens._({
    required this.padding,
    required this.cornerRadius,
    required this.iconSpacing,
    required this.iconSize,
  });

  TextButtonDimens copyWith({
    EdgeInsets? padding,
    double? cornerRadius,
    double? iconSpacing,
    double? iconSize,
  }) {
    return TextButtonDimens._(
      padding: padding ?? this.padding,
      cornerRadius: cornerRadius ?? this.cornerRadius,
      iconSpacing: iconSpacing ?? this.iconSpacing,
      iconSize: iconSize ?? this.iconSize,
    );
  }

  @override
  List<Object?> get props => [
        padding,
        cornerRadius,
        iconSpacing,
        iconSize,
      ];
}

extension _TypeExtension on TextButtonType {
  ButtonStyle _createStyle(
    WidgetColor color,
    ColorScheme colors,
    Color? iconColor,
    Color? backgroundColor,
  ) {
    return switch (this) {
      TextButtonType.filled => _createFilledStyle(color, colors, iconColor, backgroundColor),
      TextButtonType.flat => _createFlatStyle(color, colors, iconColor, backgroundColor),
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
