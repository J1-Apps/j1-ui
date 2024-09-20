import "package:equatable/equatable.dart";
import "package:flutter/material.dart";
import "package:j1_ui/j1_ui.dart";

class JDialogOverrides extends Equatable {
  final EdgeInsets? insetPadding;
  final double? cornerRadius;
  final double? elevation;

  final Color? backgroundColor;
  final Color? outlineColor;
  final double? outlineWidth;

  const JDialogOverrides({
    this.insetPadding,
    this.cornerRadius,
    this.elevation,
    this.backgroundColor,
    this.outlineColor,
    this.outlineWidth,
  });

  @override
  List<Object?> get props => [
        insetPadding,
        cornerRadius,
        elevation,
        backgroundColor,
        outlineColor,
        outlineWidth,
      ];
}

class JDialog extends StatelessWidget {
  final JDialogOverrides? overrides;
  final Widget? child;

  const JDialog({super.key, this.overrides, required this.child});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme();

    return Dialog(
      backgroundColor: overrides?.backgroundColor ?? theme.colorScheme.surfaceContainer,
      elevation: overrides?.elevation ?? JDimens.elevation_m,
      insetPadding: overrides?.insetPadding ??
          const EdgeInsets.symmetric(
            horizontal: JDimens.spacing_m,
            vertical: JDimens.spacing_xxxl,
          ),
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: overrides?.outlineColor ?? theme.colorScheme.onSurface,
          width: overrides?.outlineWidth ?? J1Config.strokeWidth,
        ),
        borderRadius: BorderRadius.circular(overrides?.cornerRadius ?? JDimens.radius_m),
      ),
      child: child,
    );
  }
}

extension JDialogExtension on BuildContext {
  Future<bool?> showJDialog({JDialogOverrides? overrides, required Widget? child}) {
    return showDialog<bool>(
      context: this,
      builder: (context) => JDialog(overrides: overrides, child: child),
    );
  }
}
