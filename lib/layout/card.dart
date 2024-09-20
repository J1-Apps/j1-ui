import "package:equatable/equatable.dart";
import "package:flutter/material.dart";
import "package:j1_ui/j1_ui.dart";

class JCardOverrides extends Equatable {
  final EdgeInsetsGeometry? margin;
  final double? cornerRadius;
  final double? strokeWidth;
  final double? elevation;

  final Color? foregroundColor;
  final Color? backgroundColor;

  const JCardOverrides({
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

class JCard extends StatelessWidget {
  final JWidgetSize size;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPressed;
  final JCardOverrides? overrides;
  final Widget? child;

  const JCard({
    this.size = JWidgetSize.medium,
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
            JWidgetSize.large => JDimens.radius_l,
            JWidgetSize.medium => JDimens.radius_m,
            JWidgetSize.small => JDimens.radius_s,
          },
    );

    final shape = RoundedRectangleBorder(
      side: BorderSide(
        color: overrides?.foregroundColor ?? colors.onSurface,
        width: overrides?.strokeWidth ?? J1Config.strokeWidth,
      ),
      borderRadius: borderRadius,
    );

    return Card(
      color: overrides?.backgroundColor ?? colors.surface,
      elevation: overrides?.elevation ?? JDimens.elevation_s,
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
