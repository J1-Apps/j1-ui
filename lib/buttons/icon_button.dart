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
  final WidgetColor? color;
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
    this.color,
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
    final builder = switch (type) {
      IconButtonType.filled => _FilledIconButtonBuilder(this),
      IconButtonType.flat => _FlatIconButtonBuilder(this),
    };

    final style = builder.styleOf(
      context.colorScheme(),
      iconColor,
      backgroundColor,
      outlineColor,
      outlineWidth,
    );

    return _IconButtonContent(
      size: size,
      icon: icon,
      iconWidget: iconWidget,
      onPressed: onPressed,
      onLongPress: onLongPress,
      style: style,
      iconColor: iconColor,
      backgroundColor: backgroundColor,
    );
  }
}

class _IconButtonContent extends StatelessWidget {
  final IconButtonDimens size;
  final IconData? icon;
  final Widget? iconWidget;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final ButtonStyle style;
  final Color? iconColor;
  final Color? backgroundColor;

  const _IconButtonContent({
    required this.size,
    required this.icon,
    required this.iconWidget,
    required this.onPressed,
    required this.onLongPress,
    required this.style,
    required this.iconColor,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final buttonStyle = style.copyWith(
      padding: EdgeInsets.zero.widgetState(),
      minimumSize: Size.zero.widgetState(),
      iconSize: size.iconSize.widgetState(),
      fixedSize: Size.square(size.size).widgetState(),
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

abstract class _IconButtonBuilder {
  final IconButton source;

  const _IconButtonBuilder(this.source);

  ButtonStyle styleOf(
    ColorScheme colors,
    Color? iconColor,
    Color? backgroundColor,
    Color? outlineColor,
    double? outlineWidth,
  );
}

class _FilledIconButtonBuilder extends _IconButtonBuilder {
  const _FilledIconButtonBuilder(super.source);

  @override
  ButtonStyle styleOf(
    ColorScheme colors,
    Color? iconColor,
    Color? backgroundColor,
    Color? outlineColor,
    double? outlineWidth,
  ) {
    final buttonColors = switch (source.color) {
      WidgetColor.primary => (colors.onPrimary, colors.primary),
      WidgetColor.secondary => (colors.onSecondary, colors.secondary),
      WidgetColor.tertiary => (colors.onTertiary, colors.tertiary),
      _ => (colors.onPrimary, colors.primary),
    };

    final shape = CircleBorder(
      side: outlineColor != null ? BorderSide(color: outlineColor, width: outlineWidth ?? 2) : BorderSide.none,
    );

    return ButtonStyle(
      iconColor: (iconColor ?? buttonColors.$1).widgetState(),
      backgroundColor: (backgroundColor ?? buttonColors.$2).widgetState(),
      overlayColor: (iconColor ?? buttonColors.$1).withOpacity(J1Config.buttonOverlayOpacity).widgetState(),
      elevation: Dimens.elevation_s.widgetState(),
      shape: shape.widgetState(),
    );
  }
}

class _FlatIconButtonBuilder extends _IconButtonBuilder {
  const _FlatIconButtonBuilder(super.source);

  @override
  ButtonStyle styleOf(
    ColorScheme colors,
    Color? iconColor,
    Color? backgroundColor,
    Color? outlineColor,
    double? outlineWidth,
  ) {
    final buttonColors = switch (source.color) {
      WidgetColor.primary => (colors.primary, Colors.transparent),
      WidgetColor.secondary => (colors.secondary, Colors.transparent),
      WidgetColor.tertiary => (colors.tertiary, Colors.transparent),
      _ => (colors.onSurface, Colors.transparent),
    };

    final shape = CircleBorder(
      side: outlineColor != null ? BorderSide(color: outlineColor, width: outlineWidth ?? 2) : BorderSide.none,
    );

    return ButtonStyle(
      iconColor: (iconColor ?? buttonColors.$1).widgetState(),
      backgroundColor: (backgroundColor ?? buttonColors.$2).widgetState(),
      overlayColor: (iconColor ?? buttonColors.$1).withOpacity(J1Config.buttonOverlayOpacity).widgetState(),
      elevation: Dimens.elevation_none.widgetState(),
      shape: shape.widgetState(),
    );
  }
}
