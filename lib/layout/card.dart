import "package:equatable/equatable.dart";
import "package:flutter/material.dart" hide Card;
import "package:flutter/material.dart" as material show Card;
import "package:j1_ui/j1_ui.dart";

class CardOverrides extends Equatable {
  final EdgeInsetsGeometry? margin;
  final double? cornerRadius;
  final double? strokeWidth;
  final double? elevation;

  final Color? foregroundColor;
  final Color? backgroundColor;

  const CardOverrides({
    this.margin,
    this.cornerRadius,
    this.strokeWidth,
    this.elevation,
    this.foregroundColor,
    this.backgroundColor,
  });

  @override
  List<Object?> get props => [
        margin,
        cornerRadius,
        strokeWidth,
        elevation,
        foregroundColor,
        backgroundColor,
      ];
}

class Card extends StatelessWidget {
  final WidgetSize size;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPressed;
  final CardOverrides? overrides;
  final Widget? child;

  const Card({
    this.size = WidgetSize.medium,
    this.onPressed,
    this.onLongPressed,
    this.overrides,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme();

    final borderRadius = BorderRadius.circular(
      overrides?.cornerRadius ??
          switch (size) {
            WidgetSize.large => Dimens.radius_l,
            WidgetSize.medium => Dimens.radius_m,
            WidgetSize.small => Dimens.radius_s,
          },
    );

    final shape = RoundedRectangleBorder(
      side: BorderSide(color: overrides?.foregroundColor ?? colors.onSurface, width: overrides?.strokeWidth ?? 2.0),
      borderRadius: borderRadius,
    );

    return material.Card(
      color: overrides?.backgroundColor ?? colors.surface,
      elevation: overrides?.elevation ?? Dimens.elevation_s,
      shape: shape,
      margin: overrides?.margin ?? EdgeInsets.zero,
      child: ClipRRect(
        borderRadius: borderRadius,
        child: onPressed == null
            ? child
            : InkWell(
                onTap: onPressed,
                onLongPress: onLongPressed,
                borderRadius: borderRadius,
                child: child,
              ),
      ),
    );
  }
}
